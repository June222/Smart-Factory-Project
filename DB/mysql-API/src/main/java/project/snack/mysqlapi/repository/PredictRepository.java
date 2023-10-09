package project.snack.mysqlapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.snack.mysqlapi.model.Predict;

@Repository
public interface PredictRepository extends JpaRepository<Predict,Integer> {

}
