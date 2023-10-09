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
    private final OriginRepository originRepository;
    private final OriginService originService;

    @GetMapping(value = "/origin/getAll")
    public List<Origin> getAllOrigin(){
        return originService.getAllOriginService();
    }

    @PostMapping(value = "/origin/post")
    public String postOrigin(@RequestBody Origin origin) {
        return originService.createOriginService(origin);
    }

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
