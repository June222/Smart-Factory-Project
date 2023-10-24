package com.example.mysqljpaapi.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;


public interface SteelRepository  extends JpaRepository<Steel, Integer> {

    @Query("SELECT s FROM Steel s WHERE s.localDateTime BETWEEN :t1 AND :t2")
    List<Steel> findSteelsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2") LocalDateTime t2);

    @Query("SELECT s FROM Steel s WHERE s.isNormal = TRUE AND s.localDateTime BETWEEN :t1 AND :t2")
    List<Steel> findNormalsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2")LocalDateTime t2);

    @Query("SELECT s FROM Steel s WHERE s.isNormal = FALSE AND s.localDateTime BETWEEN :t1 AND :t2")
    List<Steel> findDefectsByLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2")LocalDateTime t2);

    @Query(value = "SELECT s, sl.label FROM Steel AS s JOIN SteelLabel AS sl ON s.id = sl.steel.id WHERE s.isNormal = FALSE AND s.localDateTime BETWEEN :t1 AND :t2 AND sl.label = :label")
    List<Steel> findDefectsByLabelAndLocalDateTime(@Param("t1") LocalDateTime t1, @Param("t2") LocalDateTime t2, @Param("label") int label);
}
