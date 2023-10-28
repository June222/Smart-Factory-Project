package com.example.mysqljpaapi.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Table(name = "steel_label")
// 철강 결함 label Table(다대일 맵핑)
public class SteelLabel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column()
    private int id;

    private int label;

    // 본 테이블(steel)의 id가 맵핑됨.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn()
    private Steel steel;

    // Builder 패턴 생성자
    @Builder
    public SteelLabel(int id, int label, Steel steel){
        this.id = id;
        this.label = label;
        this.steel = steel;
    }

    public static SteelLabel createLSteelLabel(Integer label, Steel steel){
        return SteelLabel.builder()
                .label(label)
                .steel(steel)
                .build();
    }
}
