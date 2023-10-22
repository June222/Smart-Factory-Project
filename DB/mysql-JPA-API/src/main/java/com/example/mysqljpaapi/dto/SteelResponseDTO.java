package com.example.mysqljpaapi.dto;

import com.example.mysqljpaapi.domain.Steel;
import com.example.mysqljpaapi.util.CustomDateUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

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
            this.detectedImgUrl = steel.getDetectedImgUrl();;
            this.createdAt = CustomDateUtil.
                    toStringFormat(steel.getLocalDateTime());
        }
    }

    @ToString
    @Setter
    @Getter
    public static class GetRespDto{
        private int id;
        private String fileName;
        private String originImgUrl;
        private String detectedImgUrl;
        private List<Integer> labelList;
        private String date;
        private String second;

        public GetRespDto(Steel steel){
            this.id = steel.getId();
            this.fileName = steel.getFileName();
            this.originImgUrl = steel.getOriginImgUrl();;
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
}
