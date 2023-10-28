package com.example.mysqljpaapi.controller;

import com.example.mysqljpaapi.dto.ResponseDTO;

import com.example.mysqljpaapi.dto.SteelReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.AddReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.GraphReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.DashboardReqDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO.GetRespDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO.GraphRespDto;
import com.example.mysqljpaapi.dto.SteelResponseDTO.AddRespDto;
import com.example.mysqljpaapi.service.SteelService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/api")
@RestController
public class SteelController {
    private final SteelService steelService;


    // 촬영용 디바이스에서 mysql 서버로 데이터를 전송할 때 쓰는 메소드
    @ResponseBody
    @PostMapping("/add")
    public ResponseEntity<?> addData(@RequestBody @Valid AddReqDto requestDTO, BindingResult bindingResult){
        AddRespDto addRespDto = steelService.addData(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1,"성공 했습니다.", addRespDto), HttpStatus.CREATED);
    }

    // 태블릿 디바이스에서 대쉬보드 모드에서 데이터를 가져올 때 쓰는 메소드
    @ResponseBody
    @PostMapping("/get/dashboard")
    public ResponseEntity<?> getData(@RequestBody @Valid DashboardReqDto requestDTO, BindingResult bindingResult){
        List<GetRespDto> getRespDtoList = steelService.getData(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1, "성공 했습니다.", getRespDtoList), HttpStatus.ACCEPTED);
    }

    // 태블릿 디바이스에서 그래프 모드에서 데이터를 가져올 때 쓰는 메소드
    @ResponseBody
    @PostMapping("/get/graph")
    public ResponseEntity<?> getGraphData(@RequestBody @Valid GraphReqDto requestDTO, BindingResult bindingResult){
        List<GraphRespDto> getRespDtoList = steelService.graphRespDtoList(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1, "성공 했습니다.", getRespDtoList),HttpStatus.ACCEPTED);
    }
}
