package com.example.mysqljpaapi.dto;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public class ResponseDTO<T> {
    private final Integer code;
    private final String msg;
    private final T data;
}



