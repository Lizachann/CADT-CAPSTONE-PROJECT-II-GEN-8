import nltk
from nltk.corpus import stopwords

nltk.download('stopwords')

import string
import torch
import torch.nn as nn

from torch.utils.data import DataLoader, Dataset

PUNCT_TO_REMOVE = string.punctuation
STOPWORDS = set(stopwords.words('english'))


def preprocessing(text):
    text = text.lower()
    text = text.translate(str.maketrans('', '', PUNCT_TO_REMOVE))
    text = " ".join([word for word in str(text).split() if word not in STOPWORDS])
    return text


def tokenize_example(text, tokenizer, max_length):
    tokens = tokenizer(text["clean_text"])[:max_length]
    length = len(tokens)
    return {"tokens": tokens, "length": length}


def numericalize_example(example, vocab):
    ids = vocab.lookup_indices(example["tokens"])
    return {"ids": ids}


def get_collate_fn(pad_index):
    def collate_fn(batch):
        batch_ids = [i["ids"] for i in batch]
        batch_ids = nn.utils.rnn.pad_sequence(
            batch_ids, padding_value=pad_index, batch_first=True
        )
        batch_length = [i["length"] for i in batch]
        batch_length = torch.stack(batch_length)
        batch_label = [i["label"] for i in batch]
        batch_label = torch.stack(batch_label)
        batch = {"ids": batch_ids, "length": batch_length, "label": batch_label}
        return batch

    return collate_fn


def get_data_loader(dataset, batch_size, pad_index, shuffle=False):
    collate_fn = get_collate_fn(pad_index)
    data_loader = torch.utils.data.DataLoader(
        dataset=dataset,
        batch_size=batch_size,
        collate_fn=collate_fn,
        shuffle=shuffle,
    )
    return data_loader
