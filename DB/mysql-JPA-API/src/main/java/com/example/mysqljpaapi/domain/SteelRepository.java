package com.example.mysqljpaapi.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;


public interface SteelRepository  extends JpaRepository<Steel, Integer> {

    // 조회 시작 날짜와 종료 날짜 사이의 data를 List 형태로 반환
    @Query("SELECT s FROM Steel s WHERE s.localDateTime BETWEEN :t1 AND :t2 order by s.localDateTime desc")
    List<Steel> findSteelsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2") LocalDateTime t2);

    // 조회 날짜 사이의 결함 없는 것만 반환
    @Query("SELECT s FROM Steel s WHERE s.isNormal = TRUE AND s.localDateTime BETWEEN :t1 AND :t2 order by s.localDateTime desc")
    List<Steel> findNormalsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2")LocalDateTime t2);

    // 조회 날짜 사이의 결함이 있는 것만 반환
    @Query("SELECT s FROM Steel s WHERE s.isNormal = FALSE AND s.localDateTime BETWEEN :t1 AND :t2 order by s.localDateTime desc")
    List<Steel> findDefectsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2")LocalDateTime t2);

    // 조회 날짜 사이의 자신이 원하는 결함(label)만 반환
    @Query(value = "SELECT s, sl.label FROM Steel AS s JOIN SteelLabel AS sl ON s.id = sl.steel.id WHERE s.isNormal = FALSE AND s.localDateTime BETWEEN :t1 AND :t2 AND sl.label = :label order by s.localDateTime desc")
    List<Steel> findDefectsByLabelAndLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2") LocalDateTime t2, @Param("label") int label);
}
