from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
import os
from PIL import Image
import numpy as np
from tensorflow import keras

app = Flask(__name__)

@app.route('/uploader', methods = ['GET', 'POST'])
def uploader():
   f = request.files['image']
   os.chdir('./images')
   # f.save(secure_filename('image.jpg'))
   f.save(secure_filename(f.filename))
   # ------------------------------------------------
   # numpy로 변경하기

   number_of_data = 1  # 데이터 수
   img_width_size = 300  # 이미지의 사이즈 , 너비
   img_height_size = 400  # 이미지의 사이즈 , 높이

   testImage = np.zeros(number_of_data*img_width_size*img_height_size, dtype=np.int32).reshape(number_of_data, img_height_size, img_width_size) 
   
   img = np.array(Image.open(f.filename), dtype=np.int32)
   testImage[0,:,:] = img

   # Names
   dirNames = ['Aiden', 'Andrew', 'Cathy']
   os.chdir('..')
   model2 = keras.models.load_model("./best-gray-cnn-model.h5")
   preds = model2.predict(testImage[0:1])
   # print(dirNames[np.argmax(preds[0])])
    
   # return dirNames[np.argmax(preds[0])]
   return jsonify({'result' : dirNames[np.argmax(preds[0])]})
		
if __name__ == '__main__':
   app.run(host="127.0.0.1", port=5000, debug=True)