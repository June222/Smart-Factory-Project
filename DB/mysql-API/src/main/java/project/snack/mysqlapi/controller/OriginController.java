package project.snack.mysqlapi.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.snack.mysqlapi.model.Origin;
import project.snack.mysqlapi.repository.OriginRepository;
import project.snack.mysqlapi.service.OriginService;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class OriginController {
    private final OriginService originService;


    //저장된 모든 origin출력됨
    @GetMapping(value = "/origin/getAll")
    public List<Origin> getAllOrigin(){
        return originService.getAllOriginService();
    }

    // 파일이름, 생성날짜(date)형식으로 입력하면 자동으로 id가 매겨짐.
    @PostMapping(value = "/origin/post")
    public String postOrigin(Origin origin) {

        return originService.createOriginService(origin);
    }

    //저장된 id를 입력하면 삭제됨.
    @DeleteMapping("/origin/{id}")
    public ResponseEntity<String> deleteByIdOrigin(@PathVariable int id) {
        try {
            originService.deleteByIdOriginService(id); // ID를 기반으로 삭제 작업 수행
            return ResponseEntity.ok("Origin resource deleted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting origin resource.");
        }
    }


}
