package project.snack.mysqlapi.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import project.snack.mysqlapi.model.Predict;
import project.snack.mysqlapi.model.request.PredictCreationRequest;
import project.snack.mysqlapi.repository.PredictRepository;
import project.snack.mysqlapi.service.PredictService;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class PredictController {
    private final PredictService predictService;

    @GetMapping(value = "/predict/getAll")
    public List<Predict> getAllPredict(){
        return predictService.getAllPredict();
    }

    //결함 번호와 저장된 origin_id 입력하면 저장됨.
    @PostMapping(value = "/predict/post")
    public ResponseEntity<Predict> postPredict(@RequestBody PredictCreationRequest request) {
        return ResponseEntity.ok(predictService.createPredictService(request));
    }

    @DeleteMapping("/predict/{id}")
    public ResponseEntity<String> deleteByIdPredict(@PathVariable int id) {
        try {
            predictService.deleteByIdPredictService(id); // ID를 기반으로 삭제 작업 수행
            return ResponseEntity.ok("Predict resource deleted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting predict resource.");
        }
    }
}
