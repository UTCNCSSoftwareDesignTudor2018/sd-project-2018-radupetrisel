package dataAccess.repositories;

import dataAccess.entities.Station_;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface StationRepository extends JpaRepository<Station_, Integer> {

}
