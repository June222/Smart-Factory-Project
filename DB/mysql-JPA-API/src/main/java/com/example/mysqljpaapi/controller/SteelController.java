package com.example.mysqljpaapi.controller;

import com.example.mysqljpaapi.dto.ResponseDTO;

import com.example.mysqljpaapi.dto.SteelReqDto.GetReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.AddReqDto;
import com.example.mysqljpaapi.dto.SteelReqDto.GraphReqDto;

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

    @ResponseBody
    @PostMapping("/add")
    public ResponseEntity<?> addData(@RequestBody @Valid AddReqDto requestDTO, BindingResult bindingResult){
        AddRespDto addRespDto = steelService.addData(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1,"성공 했습니다.", addRespDto), HttpStatus.CREATED);
    }

    @ResponseBody
    @PostMapping("/get/dashboard")
    public ResponseEntity<?> getData(@RequestBody @Valid GetReqDto requestDTO, BindingResult bindingResult){
        List<GetRespDto> getRespDtoList = steelService.getData(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1, "성공 했습니다.", getRespDtoList), HttpStatus.ACCEPTED);
    }

    @ResponseBody
    @PostMapping("/get/graph")
    public ResponseEntity<?> getGraphData(@RequestBody @Valid GraphReqDto requestDTO, BindingResult bindingResult){
        List<GraphRespDto> getRespDtoList = steelService.graphRespDtoList(requestDTO);
        return new ResponseEntity<>(new ResponseDTO<>(1, "성공 했습니다.", getRespDtoList),HttpStatus.ACCEPTED);
    }
}
