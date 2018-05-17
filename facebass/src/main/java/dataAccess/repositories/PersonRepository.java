package dataAccess.repositories;

import dataAccess.entities.Person_;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface PersonRepository extends JpaRepository<Person_, Integer> {

    Person_ findByFaceApiId(String faceApiId);

    Person_ findByEmail(String email);
}
