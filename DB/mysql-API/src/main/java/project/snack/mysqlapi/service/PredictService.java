package project.snack.mysqlapi.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import project.snack.mysqlapi.model.Origin;
import project.snack.mysqlapi.model.Predict;
import project.snack.mysqlapi.model.request.PredictCreationRequest;
import project.snack.mysqlapi.repository.OriginRepository;
import project.snack.mysqlapi.repository.PredictRepository;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PredictService {
    private final PredictRepository predictRepository;
    private final OriginRepository originRepository;
    public List<Predict> getAllPredict(){
        return predictRepository.findAll();
    }
    public String deleteByIdPredictService(int id){
        predictRepository.deleteById(id);
        return "삭제 완료";
    }

    public Predict createPredictService(PredictCreationRequest predict){
        Optional<Origin> origin = originRepository.findById(predict.getOriginId()); //Origin에서
        if (!origin.isPresent()) {
            throw new EntityNotFoundException(
                    "origin image is Not Found");
        }
        Predict predictToCreate = new Predict();
        BeanUtils.copyProperties(predict, predictToCreate);
        predictToCreate.setOrigin(origin.get());
        return predictRepository.save(predictToCreate);

    }

}
