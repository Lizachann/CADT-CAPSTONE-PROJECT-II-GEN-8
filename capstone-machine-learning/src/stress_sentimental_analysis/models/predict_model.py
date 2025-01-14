
import pandas as pd

import nltk

nltk.download('stopwords')

from ..features.build_features import tokenize_example, numericalize_example, preprocessing, get_data_loader

import datasets

import torch
import torch.nn as nn

import pickle

with open('../models/tokenizer.pkl', 'rb') as f:
    tokenizer = pickle.load(f)

with open('../models/vocab.pkl', 'rb') as f:
    vocab = pickle.load(f)

pad_index = vocab["<pad>"]

class LSTM(nn.Module):
    def __init__(
        self,
        vocab_size,
        embedding_dim,
        hidden_dim,
        output_dim,
        n_layers,
        bidirectional,
        dropout_rate,
        pad_index,
    ):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, embedding_dim, padding_idx=pad_index)
        self.lstm = nn.LSTM(
            embedding_dim,
            hidden_dim,
            n_layers,
            bidirectional=bidirectional,
            dropout=dropout_rate,
            batch_first=True,
        )
        self.fc = nn.Linear(hidden_dim * 2 if bidirectional else hidden_dim, output_dim)
        self.dropout = nn.Dropout(dropout_rate)

    def forward(self, ids, length):
        # ids = [batch size, seq len]
        # length = [batch size]
        embedded = self.dropout(self.embedding(ids))
        # embedded = [batch size, seq len, embedding dim]
        packed_embedded = nn.utils.rnn.pack_padded_sequence(
            embedded, length, batch_first=True, enforce_sorted=False
        )
        packed_output, (hidden, cell) = self.lstm(packed_embedded)
        # hidden = [n layers * n directions, batch size, hidden dim]
        # cell = [n layers * n directions, batch size, hidden dim]
        output, output_length = nn.utils.rnn.pad_packed_sequence(packed_output)
        # output = [batch size, seq len, hidden dim * n directions]
        if self.lstm.bidirectional:
            hidden = self.dropout(torch.cat([hidden[-1], hidden[-2]], dim=-1))
            # hidden = [batch size, hidden dim * 2]
        else:
            hidden = self.dropout(hidden[-1])
            # hidden = [batch size, hidden dim]
        prediction = self.fc(hidden)
        # prediction = [batch size, output dim]
        return prediction

def initialize_weights(m):
    if isinstance(m, nn.Linear):
        nn.init.xavier_normal_(m.weight)
        nn.init.zeros_(m.bias)
    elif isinstance(m, nn.LSTM):
        for name, param in m.named_parameters():
            if "bias" in name:
                nn.init.zeros_(param)
            elif "weight" in name:
                nn.init.orthogonal_(param)

def get_label(prediction):
    predicted_classes = prediction.argmax(dim=-1)
    return predicted_classes.item()

def predict_stress(model, text, device='cpu'):
    input = pd.DataFrame([{'text': text}])
    input['clean_text'] = input['text'].apply(lambda text: preprocessing(text))
    input_data = datasets.Dataset.from_pandas(input)

    max_length=100
    batch_size=32

    input_data = input_data.map(
        tokenize_example, fn_kwargs={"tokenizer": tokenizer, "max_length": max_length}
    )

    input_data = input_data.map(numericalize_example, fn_kwargs={"vocab": vocab})

    input_data = input_data.with_format(type="torch", columns=["ids", "length"])

    input_data_loader = get_data_loader(input_data, batch_size, pad_index, shuffle=True)

    final_input = input_data_loader.dataset[0]

    ids = final_input["ids"].to(device)
    length = final_input["length"]
    length = torch.tensor([length], dtype=torch.int64)
    ids = ids.unsqueeze(0)

    prediction = model(ids, length)

    return get_label(prediction)

vocab_size = 5709
embedding_dim = 300
hidden_dim = 300
output_dim = 2
n_layers = 2
bidirectional = True
dropout_rate = 0.5

def load_nn_model(path):
    lstm_model = LSTM(vocab_size,
                      embedding_dim,
                      hidden_dim,
                      output_dim,
                      n_layers,
                      bidirectional,
                      dropout_rate,
                      pad_index)


    lstm_model.load_state_dict(torch.load(path, map_location=torch.device('cpu')))
    lstm_model.eval()

    return lstm_model
