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

