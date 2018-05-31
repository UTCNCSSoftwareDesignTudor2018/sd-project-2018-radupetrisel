package business.services;

import business.dtos.Bus;
import business.dtos.Pass;
import business.dtos.Person;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import dataAccess.entities.Bus_;
import dataAccess.entities.Person_;
import dataAccess.repositories.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class PersonService {

    @Autowired
    protected PersonRepository personRepo;

    @Autowired
    private PassService passService;

    @Autowired
    private BusService busService;

    public int login(String email, String password) {

        String encrypted = Base64.encode(password.getBytes());

        try {
            Person_ person = personRepo.findByEmail(email);

            if (person.getPassword().equals(encrypted))
                return person.getType();

            return -1;
        } catch (Exception e){
            return -1;
        }
    }

    public Person get(String email){
        System.out.println(email);
        return new Person(personRepo.findByEmail(email));
    }

    public boolean register(Person person) {

        try {
            personRepo.save(person.getPerson());
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    public void addPass(String email, Pass pass) {

        Person_ person = personRepo.findByEmail(email);

        pass.owner(new Person(person));
        passService.create(pass);

        person.addPass(pass.getPass());

        personRepo.save(person);
    }

    public void update(Person person){

        person.setId(personRepo.findByEmail(person.getEmail()).getId());
        personRepo.save(person.getPerson());
    }

    public void updatePassword(String email, String password){

        Person_ person = personRepo.findByEmail(email);
        person.setPassword(password);
        personRepo.save(person);
    }

    public boolean check(String personApiId, String line){

        Bus_ bus = busService.get(line).getBus();

        Person_ person = personRepo.findByFaceApiId(personApiId);
        return person.getPasses().stream().filter(pass -> bus.equals(pass.getBus())).anyMatch(pass -> pass.getExpiryDate().isAfter(LocalDate.now().minusDays(1)));
    }

    public boolean addFace(String email, String faceId){

        try {
            Person_ person = personRepo.findByEmail(email);

            person.setFaceApiId(faceId);

            personRepo.save(person);

            return true;
        } catch(Exception e){
            return false;
        }
    }
}
