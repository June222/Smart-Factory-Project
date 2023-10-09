package project.snack.mysqlapi.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.snack.mysqlapi.model.Origin;
import project.snack.mysqlapi.repository.OriginRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OriginService {
    private final OriginRepository originRepository;
    public List<Origin> getAllOriginService(){
        return originRepository.findAll();

    }
    public String deleteByIdOriginService(int id){
        originRepository.deleteById(id);
        return "삭제 완료";
    }

    public String createOriginService(Origin origin){
        originRepository.save(origin);
        return "등록 완료";
    }

}
