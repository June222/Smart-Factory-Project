package com.example.mysqljpaapi.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// mysql에는 dateTime type의 값이 저장되어 있음.
// 이를 원하는 형태의 String으로 변환하는 클래스 및 메소드
public class CustomDateUtil {
    public static String toStringFormat(LocalDateTime localDateTime){
        return localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public static String dateToStringFormat(LocalDateTime localDateTime) {
        return localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public static String secondToStringFormat(LocalDateTime localDateTime) {
        return localDateTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
    }

    public static LocalDateTime toLocalDataTimeFormat(String stringLocalDateTime){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return LocalDateTime.parse(stringLocalDateTime, formatter);
    }
}
