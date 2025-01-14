import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Literal
from mental_issues_prediction.features.build_features import encode_features
from mental_issues_prediction.models.predict_model import predict, load_model
import datasets
from stress_sentimental_analysis.models.predict_model import predict_stress,load_nn_model, get_label
from stress_sentimental_analysis.features.build_features import tokenize_example, numericalize_example, preprocessing, get_data_loader
import pickle
import torchtext; 

from torch.utils.data import Dataset, DataLoader
import numpy as np
import torch
# Create a FastAPI instance
app = FastAPI()

torchtext.disable_torchtext_deprecation_warning()

# Define the Survey model
class MentalIssuesSurvey(BaseModel):
    Gender: Literal['Female', 'Male']
    Occupation: Literal['Corporate', 'Student', 'Business', 'Housewife', 'Others']
    self_employed: Literal['No', 'Yes']
    family_history: Literal['No', 'Yes']
    treatment: Literal['Yes', 'No']
    Days_Indoors: Literal['1-14 days', 'Go out Every day', 'More than 2 months', '15-30 days', '31-60 days']
    Growing_Stress: Literal['Yes', 'No', 'Maybe']
    Changes_Habits: Literal['No', 'Yes', 'Maybe']
    Mood_Swings: Literal['Medium', 'Low', 'High']
    Coping_Struggles: Literal['No', 'Yes']
    Work_Interest: Literal['No', 'Maybe', 'Yes']
    Social_Weakness: Literal['Yes', 'No', 'Maybe']
    mental_health_interview: Literal['No', 'Maybe', 'Yes']
    care_options: Literal['Not sure', 'No', 'Yes']

class Text(BaseModel):
    text: str

# Load trained models
one_hot_encoder = load_model("../models/one_hot_encoder.pkl")
mental_issues_clf = load_model("../models/classifier_model.pkl")
lstm_model = load_nn_model("../models/lstm.pt")

target_map = {
    1: 'Yes',
    0: 'No',
    2:'Maybe'
}

stress_map = {
    0: False,
    1: True
}


with open('../models/tokenizer.pkl', 'rb') as f:
    tokenizer = pickle.load(f)

with open('../models/vocab.pkl', 'rb') as f:
    vocab = pickle.load(f)

pad_index = vocab["<pad>"]

@app.post("/predict_mental_issues/")
async def predict_mental_issues(item: MentalIssuesSurvey):

    input = [dict(item)]
    df = pd.DataFrame(input)

    encode_input = encode_features(one_hot_encoder, df)
    output = mental_issues_clf.predict(encode_input)
    result = target_map[output[0]]
    proba = mental_issues_clf.predict_proba(encode_input)[0]
    print(proba)
    return {"is_have_mental_issues": result, "no": proba[0], "yes": proba[1]}

@app.post("/predict_stress/")
async def predict_stress_text(item: Text):
    #prediction_result = predict_stress(lstm_model, item.text)
    input = pd.DataFrame([{'text': item.text}])
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

    print(np.__version__)

    ids = final_input["ids"].to('cpu')
    length = final_input["length"]
    length = torch.tensor([length], dtype=torch.int64)
    ids = ids.unsqueeze(0)

    prediction = lstm_model(ids, length)
    prediction_result = get_label(prediction)
    
    return {"Result": stress_map[prediction_result]}