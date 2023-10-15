package project.snack.mysqlapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.snack.mysqlapi.model.Origin;

import java.util.List;

@Repository
public interface OriginRepository extends JpaRepository<Origin, Integer> {
    //List<Origin> findAll();
}
