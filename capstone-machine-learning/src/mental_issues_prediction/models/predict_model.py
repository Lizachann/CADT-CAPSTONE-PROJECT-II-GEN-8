import pickle

def load_model(path):
    with open(path, 'rb') as file:
        loaded_model = pickle.load(file)

    return loaded_model

def predict(model, input):
    output = model.predict(input)
    return output