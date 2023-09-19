class SteelDataset(Dataset):
    def __init__(self, csv_path, img_dir, transform=None):
        self.data = pd.read_csv(csv_path)
        self.img_dir = img_dir
        self.transform = transform

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        img_name = os.path.join(self.img_dir,  self.data.iloc[idx, 0])

        # 원본 이미지를 엽니다.
        original_image = Image.open(img_name)
        # 원본 이미지의 크기를 가져옵니다.
        width, height = original_image.size
        # 원하는 최종 크기를 정의합니다.
        final_size = 1600
        # 결과 이미지를 생성합니다. 배경은 검은색으로 채웁니다.
        result_image = Image.new("RGB", (final_size, final_size), (0, 0, 0))

        # 원본 이미지를 결과 이미지의 중앙에 붙여넣습니다.
        x_offset = (final_size - width) // 2
        y_offset = (final_size - height) // 2
        result_image.paste(original_image, (x_offset, y_offset))

        image = result_image

        label = self.data.iloc[idx, 1] - 1  # Adjust label to start from 0
        if self.transform:
            image = self.transform(image)
        return image, label

batch_size = 64
# 데이터 로드 및 전처리
transform = transforms.Compose([

    transforms.Resize((64, 64)),  # 이미지 크기 조정
    transforms.ToTensor(),  # 이미지를 Tensor로 변환
    transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))  # 이미지를 -1에서 1 사이로 정규화
])
train_dataset = SteelDataset(csv_path='~/dataset/new_train_2.csv',
                              img_dir='~/dataset/train_images/',
                              transform=transform)
train_loader = DataLoader(dataset=train_dataset, batch_size=batch_size, shuffle=True)