package com.example.mysqljpaapi.dto;

import com.example.mysqljpaapi.domain.Steel;
import com.example.mysqljpaapi.domain.SteelLabel;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import java.util.ArrayList;
import java.util.List;


public class SteelReqDto {

    @Setter
    @Getter
    public static class AddReqDto {
        @NotEmpty
        private String fileName;
        @NotEmpty
        private List<Integer> defectLabelList;
        @NotEmpty
        private String originImgUrl;
        @NotEmpty
        private String detectedImgUrl;

        public Steel toEntity(){
            System.out.println("toEntity Process");
            Steel steel = Steel.builder()
                    .fileName(fileName)
                    .originImgUrl(originImgUrl)
                    .detectedImgUrl(detectedImgUrl)
                    .labels(new ArrayList<>())
                    .build();

            System.out.println(steel);
            for (Integer label: defectLabelList){
                System.out.println("label:" + label);
                SteelLabel steelLabel = SteelLabel.createLSteelLabel(label, steel);
                System.out.println(steelLabel);
                steel.addLabel(steelLabel);
                System.out.println(steel);
            }
            System.out.println("toEntity done.");
            return steel;
        }
    }

    @Setter
    @Getter
    public static class GetReqDto{
        @NotEmpty
        private String localDateTimeStart;
        @NotEmpty
        private String localDateTimeEnd;
        private boolean isNormal;
        private Integer defectLabel;
    }
}
