from sklearn.preprocessing import OneHotEncoder
import pandas as pd

target_map = {
    'Yes': 1,
    'No': 0,
    'Maybe': 2
}

def encode_features(encoder, features):
    one_hot_encoder = encoder
    encoded_features = one_hot_encoder.transform(features)
    features = pd.DataFrame(encoded_features.toarray(), columns=one_hot_encoder.get_feature_names_out())
    return features

def preprocessing(features, target):
    encoded_features = encode_features(features)
    encoded_target = target.apply(lambda x: target_map[x])
    return encoded_features, encoded_target
