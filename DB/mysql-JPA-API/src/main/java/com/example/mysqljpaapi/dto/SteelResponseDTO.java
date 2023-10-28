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

        static public List<GetRespDto> getRespDtoList(List<Steel> listFound){
            List<GetRespDto> list = new ArrayList<>();

            for (Steel steel : listFound) {
                list.add(new GetRespDto(steel));
            }
            return list;
        }
    }

    @ToString
    @Getter
    @Setter
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

        static public List<GraphRespDto> getRespDtoList(List<Steel> listFound){
            List<GraphRespDto> list = new ArrayList<>();

            boolean flag = false;

            int one = 0;
            int two = 0;
            int three = 0;
            int four = 0;
            String date = CustomDateUtil.dateToStringFormat(listFound.get(0).getLocalDateTime());

            for(Steel steel: listFound){
                if(!date.equals(CustomDateUtil.dateToStringFormat(steel.getLocalDateTime()))){
                    flag = false;
                    list.add(new GraphRespDto(one, two, three, four, date));
                    one = 0;
                    two = 0;
                    three = 0;
                    four = 0;
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
                flag = true;
            }
            if(flag){
                list.add(new GraphRespDto(one, two, three, four, date));
            }
            return list;
        }
    }
}
