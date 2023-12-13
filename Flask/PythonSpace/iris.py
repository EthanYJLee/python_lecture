"""
Create on 2023-02-06
author: Ethan
Description: Flutter와 Python의 AI 예측값 보내기
"""

from flask import Flask, jsonify, request
import joblib

app = Flask(__name__)

@app.route("/iris")
def iris():
    sepalLength = float(request.args.get("sepalLength"))
    sepalWidth = float(request.args.get("sepalWidth"))
    petalLength = float(request.args.get("petalLength"))
    petalWidth = float(request.args.get("petalWidth"))

    clf = joblib.load("./rf_iris.h5")
    pre = clf.predict([[sepalLength,sepalWidth,petalLength,petalWidth]])

    return jsonify({'result':pre[0][5:]})
    # Iris-setosa, Iris-verginica, Iris-versicolor에서 -'Iris-'

host_add = 'localhost'
port_num = 5000

if __name__ == "__main__":
    # app.run(host="localhost", port=5000, debug=True)
    app.run(host = host_add, port = port_num, debug=True)