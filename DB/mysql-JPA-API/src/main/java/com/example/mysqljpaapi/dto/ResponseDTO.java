package com.example.mysqljpaapi.dto;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
// code 및 msg를 함께 보내기 위한 ResponseDTO 클래스
public class ResponseDTO<T> {
    private final Integer code;
    private final String msg;
    private final T data;
}



