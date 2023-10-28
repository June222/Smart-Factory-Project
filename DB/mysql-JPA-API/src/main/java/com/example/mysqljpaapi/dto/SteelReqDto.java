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
    // mysql 서버에 데이터를 전송할 때의 json Data DTO(Data Transfer Object)
    public static class AddReqDto {
        @NotEmpty
        private String fileName;
        @NotEmpty
        private List<Integer> defectLabelList;
        @NotEmpty
        private String originImgUrl;
        @NotEmpty
        private String detectedImgUrl;

        // mysql 서버에 저장 가능한 형태(entity: Steel Object)로 변환하는 메소드
        public Steel toEntity(){
            System.out.println("toEntity Process");
            Steel steel = Steel.builder()
                    .fileName(fileName)
                    .originImgUrl(originImgUrl)
                    .detectedImgUrl(detectedImgUrl)
                    .labels(new ArrayList<>())
                    .build();

            System.out.println(steel);
            // 전송받은 모든 label을 다 저장함.
            for (Integer label: defectLabelList){
                System.out.println("label:" + label);
                // steel_label Table에 하나씩 row를 insert함.
                SteelLabel steelLabel = SteelLabel.createLSteelLabel(label, steel);
                System.out.println(steelLabel);
                // 본 Table의 row와 맵핑
                steel.addLabel(steelLabel);
                System.out.println(steel);
            }
            // labelList가 빈 경우 == 결함이 없는 경우
            // Normal(결함 없음)을 true로 설정
            if(defectLabelList.isEmpty()){
                steel.setNormal(true);
            }
            System.out.println("toEntity done.");
            // mysql에 저장 가능한 entity 형태를 반환
            return steel;
        }
    }

    @Setter
    @Getter
    // Dashboard 모드에서 데이터를 요청할 때의 json Data DTO(Data Transfer Object)
    public static class DashboardReqDto {
        @NotEmpty
        private String localDateTimeStart;
        @NotEmpty
        private String localDateTimeEnd;
        private String status;
        private String label;
    }

    @Setter
    @Getter
    // Grpah 모드에서 데이터를 요청할 때의 json Data DTO(Data Transfer Object)
    public static class GraphReqDto{
        @NotEmpty
        private String localDateTimeStart;
        @NotEmpty
        private String localDateTimeEnd;
    }
}
