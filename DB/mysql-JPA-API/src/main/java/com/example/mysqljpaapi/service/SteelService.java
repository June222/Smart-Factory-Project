package com.example.mysqljpaapi.service;


import com.example.mysqljpaapi.domain.Steel;
import com.example.mysqljpaapi.domain.SteelRepository;
import com.example.mysqljpaapi.dto.SteelReqDto.GetReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.AddReqDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO;
import com.example.mysqljpaapi.dto.SteelResponseDTO.GetRespDto;
import com.example.mysqljpaapi.util.CustomDateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@RequiredArgsConstructor
@Service
public class SteelService {
    private final SteelRepository steelRepository;

    @Transactional
    public SteelResponseDTO.AddRespDto addData(AddReqDto requestDTO){
        Steel steelPS = steelRepository.save(requestDTO.toEntity());
        return new SteelResponseDTO.AddRespDto(steelPS);
    }

    @Transactional
    public List<GetRespDto> getData(GetReqDto requestDTO){
        LocalDateTime t1 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeStart());
        LocalDateTime t2 = CustomDateUtil.toLocalDataTimeFormat(requestDTO.getLocalDateTimeEnd());
        if (requestDTO.getStatus().equals("ALL")) {
            List<Steel> listFoundPS = steelRepository.findSteelsByLocalDateTime(t1, t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        else if(requestDTO.getStatus().equals("NORMAL")){
            List<Steel> listFoundPS =  steelRepository.findNormalsByLocalDateTime(t1,t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        else if(requestDTO.getStatus().equals("DEFECT") && requestDTO.getLabel().equals("ALL")){
            List<Steel> listFoundPS =  steelRepository.findDefectsByLocalDateTime(t1,t2);
            return GetRespDto.getRespDtoList(listFoundPS);
        }

        int label;
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
}
