package dataAccess.repositories;

import dataAccess.entities.Pass_;
import dataAccess.entities.Person_;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface PassRepository extends JpaRepository<Pass_, Integer> {

    Pass_ findByOwner(Person_ owner);

}
