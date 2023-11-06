package com.example.mysqljpaapi.domain;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Setter
@NoArgsConstructor
@Getter
@EntityListeners(AuditingEntityListener.class)
@Table()
@Entity
@ToString
public class Steel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column()
    private Integer id;

    // 파일 이름이 저장되는 column
    @Column(nullable = false, length = 20)
    private String fileName;

    // 원본 이미지 url이 저장되는 column
    @Column(nullable = false, length = 500)
    private String originImgUrl;

    // 검출된 이미지 url이 저장되는 column
    @Column(nullable = false, length = 500)
    private String detectedImgUrl;

    // 결함 유무
    @Column(nullable = false)
    private boolean isNormal;

    // 1대다 맵핑 (label 의 수가 여러개 일 수 있기 때문)
    @OneToMany(mappedBy = "steel", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<SteelLabel> labels = new ArrayList<SteelLabel>();

    // 데이터 전송받은 시각, 자동 생성
    @CreatedDate
    @Column()
    private LocalDateTime localDateTime;

    // Builder 패턴 생성자
    @Builder
    public Steel(Integer id, String fileName, boolean isNormal,
                 String originImgUrl, String detectedImgUrl,
                 List<SteelLabel> labels,
                 LocalDateTime localDateTime) {

        this.id = id;
        this.fileName = fileName;
        this.originImgUrl = originImgUrl;
        this.detectedImgUrl = detectedImgUrl;
        this.labels = labels;
        this.localDateTime = localDateTime;
        this.isNormal = isNormal;
    }
    public void addLabel(SteelLabel label){
        this.labels.add(label);
    }

    public List<Integer> getIntegerList(){
        List<Integer> list = new ArrayList<>();
        for(SteelLabel steelLabel: this.labels){
            list.add(steelLabel.getLabel());
        }
        return list;
    }

    public void updateFileName(String newName){
        this.fileName = newName;
    }
}
