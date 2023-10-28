package com.example.mysqljpaapi.service;


import com.example.mysqljpaapi.domain.Steel;
import com.example.mysqljpaapi.domain.SteelRepository;

import com.example.mysqljpaapi.dto.SteelReqDto.DashboardReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.GraphReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.AddReqDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO;
import com.example.mysqljpaapi.dto.SteelResponseDTO.GetRespDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO.GraphRespDto;
import com.example.mysqljpaapi.util.CustomDateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@RequiredArgsConstructor
@Service
// mysql에 저장 가능한 entity 형태로 바꾸어 영속화
// 이해가 잘 안되면 Servlet 개념을 확인
public class SteelService {
    private final SteelRepository steelRepository;

    @Transactional
    public SteelResponseDTO.AddRespDto addData(AddReqDto requestDTO){
        Steel steelPS = steelRepository.save(requestDTO.toEntity());
        return new SteelResponseDTO.AddRespDto(steelPS);
    }

    @Transactional
    public List<GetRespDto> getData(DashboardReqDto requestDTO){
        // t1, t2 조회 시작 날짜, 종료 날짜
        LocalDateTime t1 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeStart());
        LocalDateTime t2 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeEnd());

        // 결함 유무를 따지지 않는 경우
        if (requestDTO.getStatus().equals("ALL")) {
            List<Steel> listFoundPS = steelRepository.findSteelsByLocalDateTime(t1, t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        // 정상 이미지만 따지는 경우
        else if(requestDTO.getStatus().equals("NORMAL")){
            List<Steel> listFoundPS =  steelRepository.findNormalsByLocalDateTime(t1,t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        // 결함 이미지만 따지는 경우
        else if(requestDTO.getStatus().equals("DEFECT") && requestDTO.getLabel().equals("ALL")){
            List<Steel> listFoundPS =  steelRepository.findDefectsByLocalDateTime(t1,t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        int label;
        // label을 mysql에 저장된 int 형식으로 변환
        switch (requestDTO.getLabel()){
            case "A":
                label = 1;
                break;
            case "B":
                label = 2;
                break;
            case "C":
                label = 3;
                break;
            default:
                label = 4;
                break;
        }
        List<Steel> listFoundPS = steelRepository.findDefectsByLabelAndLocalDateTime(t1, t2, label);
        return GetRespDto.getRespDtoList(listFoundPS);
    }

    @Transactional
    // graph 모드에서의 영속화
    public List<GraphRespDto> graphRespDtoList(GraphReqDto requestDTO){
        LocalDateTime t1 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeStart());
        LocalDateTime t2 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeEnd());
        List<Steel> listFoundPS = steelRepository.findSteelsByLocalDateTime(t1, t2);
        return GraphRespDto.getRespDtoList(listFoundPS);
    }
}
