package com.example.mysqljpaapi.dto;

import com.example.mysqljpaapi.domain.Steel;
import com.example.mysqljpaapi.domain.SteelLabel;
import com.example.mysqljpaapi.util.CustomDateUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.*;

public class SteelResponseDTO {

    @ToString
    @Setter
    @Getter
    // 데이터 전송의 Response jsonData DTO(Data Transfer Object)
    // 파일이름, 원본 이미지 url, 검출이미지 url, DB에 추가된 시각
    public static class AddRespDto {
        private int id;
        private String fileName;
        private String originImgUrl;
        private String detectedImgUrl;
        private String createdAt;

        public AddRespDto(Steel steel){
            this.id = steel.getId();
            this.fileName = steel.getFileName();
            this.originImgUrl = steel.getOriginImgUrl();
            this.detectedImgUrl = steel.getDetectedImgUrl();
            this.createdAt = CustomDateUtil.
                    toStringFormat(steel.getLocalDateTime());
        }
    }

    @ToString
    @Setter
    @Getter
    // Dashboard 모드에서 요청의 jsonData Response DTO(Data Transfer Object)
    public static class GetRespDto{
        private String fileName;
        private String originImgUrl;
        private String detectedImgUrl;
        private List<Integer> labelList;
        private String date;
        private String second;

        public GetRespDto(Steel steel){
            this.fileName = steel.getFileName();
            this.originImgUrl = steel.getOriginImgUrl();
            this.detectedImgUrl = steel.getDetectedImgUrl();
            this.labelList = steel.getIntegerList();
            this.date = CustomDateUtil.dateToStringFormat(steel.getLocalDateTime());
            this.second = CustomDateUtil.secondToStringFormat(steel.getLocalDateTime());
        }
        // 원하는 조건의 데이터가 여러개가 있을 수 있으므로 List 형태로 반환
        static public List<GetRespDto> getRespDtoList(List<Steel> listFound){
            List<GetRespDto> list = new ArrayList<>();

            // listFound: 실행한 쿼리문의 결과
            for (Steel steel : listFound) {
                // responseDTO 형태로 변환하여 return할 List에 추가
                list.add(new GetRespDto(steel));
            }
            return list;
        }
    }

    @ToString
    @Getter
    @Setter
    // 그래프 모드에서 요청의 jsonData RespnoseDTO(Data Transfer Object)
    // 동일한 날짜에서 발생한 label들의 개수들을 하나의 DTO로 만듬.
    // ex) 2023-10-28,10개,15개,3개 => DTO 한 개
    // 2023-10-29, 5개,7개,9개 => DTO 두 개
    public static class GraphRespDto{
        private int num_class_one;
        private int num_class_two;
        private int num_class_three;
        private int num_class_four;
        private String date;

        public GraphRespDto(int num_class_one, int num_class_two, int num_class_three, int num_class_four, String date){
            this.num_class_one = num_class_one;
            this.num_class_two = num_class_two;
            this.num_class_three= num_class_three;
            this.num_class_four = num_class_four;
             this.date = date;
        }

        // 원하는 조건의 데이터가 여러개가 있을 수 있으므로 List형태로 반환
        // DTO에 대한 설명은 line.73 주석을 확인
        static public List<GraphRespDto> getRespDtoList(List<Steel> listFound){
            List<GraphRespDto> list = new ArrayList<>();

            // 맨 마지막에 추가되지 않는 데이터를 추가하기 위한 flag
            boolean flag = false;

            int one = 0;
            int two = 0;
            int three = 0;
            int four = 0;
            System.out.println(listFound.size());

            // boundException을 피하기 위한 코드
            if(listFound.isEmpty()){
                return list;
            }

            // 첫 데이터의 저장 날짜
            String date = CustomDateUtil.dateToStringFormat(listFound.get(0).getLocalDateTime());

            // listFound: 쿼리문의 실행 결과
            for(Steel steel: listFound){
                // 데이터의 날짜가 달라지는 경우 DTO 생성
                if(!date.equals(CustomDateUtil.dateToStringFormat(steel.getLocalDateTime()))){
                    // 데이터가 추가되었으면 flag = false;
                    flag = false;
                    list.add(new GraphRespDto(one, two, three, four, date));
                    // 개수 초기화
                    one = 0;
                    two = 0;
                    three = 0;
                    four = 0;
                    // 날짜 갱신
                    date = CustomDateUtil.dateToStringFormat(steel.getLocalDateTime());
                }

                for(SteelLabel label :steel.getLabels()){
                    switch (label.getLabel()) {
                        case 1:
                            one++;
                            break;
                        case 2:
                            two++;
                            break;
                        case 3:
                            three++;
                            break;
                        case 4:
                            four++;
                            break;
                        default:
                            break;
                    }
                }
                // DTO가 생성되지 않고 list iteration이 종료될 수 있음.
                flag = true;
            }
            // DTO가 생성되지 않은 경우 DTO 생성하여 추가
            if(flag){
                list.add(new GraphRespDto(one, two, three, four, date));
            }
            return list;
        }
    }
}
