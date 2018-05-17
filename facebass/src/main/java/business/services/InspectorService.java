package business.services;

import business.dtos.Bus;
import dataAccess.entities.Person_;
import org.apache.tomcat.jni.Local;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class InspectorService extends PersonService {

    public boolean check(String personApiId, Bus bus){

        Person_ person = personRepo.findByFaceApiId(personApiId);
        return person.getPasses().stream().filter(pass -> bus.getBus().equals(pass.getBus())).anyMatch(pass -> pass.getExpiryDate().isBefore(LocalDate.now()));
    }

}
