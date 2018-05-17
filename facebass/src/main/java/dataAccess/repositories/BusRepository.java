package dataAccess.repositories;

import dataAccess.entities.Bus_;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface BusRepository extends JpaRepository<Bus_, Integer> {

    Bus_ findByName(String name);
}
