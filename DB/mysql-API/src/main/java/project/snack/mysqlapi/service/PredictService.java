package project.snack.mysqlapi.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.snack.mysqlapi.model.Predict;
import project.snack.mysqlapi.repository.PredictRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PredictService {
    private final PredictRepository predictRepository;
    public List<Predict> getAllPredict(){
        return predictRepository.findAll();
    }
    public String deleteByIdPredictService(int id){
        predictRepository.deleteById(id);
        return "삭제 완료";
    }

    public String createPredictService(Predict predict){
        predictRepository.save(predict);
        return "등록 완료";
    }

}
