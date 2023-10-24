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
public class SteelLabel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column()
    private int id;

    private int label;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn()
    private Steel steel;

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
