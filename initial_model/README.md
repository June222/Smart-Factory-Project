# 초기 모델 개발

> 본격적인 연구를 들어가기에 앞서, kaggle의 [Severstal: Steel Defect Detection](https://www.kaggle.com/competitions/severstal-steel-defect-detection/data) 철강 데이터셋을 활용하여 초기 모델을 작성해보려한다. 

### 📌 데이터셋 구조
```bash
├── train_images # train 이미지 파일이 들어 있는 폴더
│   ├── ...
│   └── ...jpg
├── test_images # test 이미지 파일이 들어 있는 폴더
│   ├── ...
│   └── ...jpg
├── train.csv # train 데이터셋의 결함 정보를 담은 파일
└── sample_submission.csv # 대회 제출용 파일 
``` 

### 📌 모델 개발 전략
데이터 셋이 ImageId, ClassId, EncodedPixels로 이루어져 있다. 

이때, 우리가 실제로 사용할 데이터 셋에는 EncodedPixels 칼럼이 없을 확률이 높기 때문에, Image를 input으로 넣었을 때 EncodedPixels를 output으로 내는 모델을 개발할 필요가 있다.

그렇기에 아래 그림과 같이 나누어 모델을 개발하려한다.

1. 불량을 검출하는 단계 (Image Segmentation)
2. 검출된 불량을 분류하는 단계 (Image Classification)

![steel](https://github.com/YeoJiSu/Smart-Factory-Project/assets/76769044/17836756-5d61-410d-b481-a720b6a59858)

(1) Image Classification <br>
* 철강 이미지 데이터에 대해  CNN, GAN, few-shot learning을 바로 적용하여 불량을 분류하는 모델<br>
* 1-1. input값: 철강 이미지, output 값: 불량 클래스 번호<br>

(2) Image Segmentation -> Classification <br>
* 철강 이미지 데이터에 대해 이미지 세그멘테이션으로 불량위치를 검출한 후 RLE인코딩 데이터로 불량을 분류하는 모델 <br>
* 2-1. image segmentation 모델) input 값: 철강 이미지, output 값: RLE 인코딩 데이터<br>
* 2-2. 단순 classification 모델) Input 값: RLE 인코딩 데이터, output 값: 불량 클래스 번호<br>

(3) Image Segmentation -> RLE Decoding -> Image Classification<br>
* 철강 이미지 데이터에 대해 이미지 세그멘테이션으로 RLE 인코딩된 값을 디코딩하여 이미지를 가공한 후 분류하는 방법<br>
* 3-1. image segmentation 모델) input 값: 철강 이미지, output 값: RLE 인코딩 데이터<br>
* 3-2. 마스크 이미지 만드는 함수)<br>
* 3-3. image classification 모델) input 값: 이미지 마스크 , output 값: 불량 클래스 번호<br>
