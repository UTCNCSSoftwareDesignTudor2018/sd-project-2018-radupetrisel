package business.services;

import business.dtos.Pass;
import business.dtos.Person;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import dataAccess.entities.Person_;
import dataAccess.repositories.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonService {

    @Autowired
    protected PersonRepository personRepo;

    @Autowired
    private PassService passService;

    public boolean login(String email, String password) {

        String encrypted = Base64.encode(password.getBytes());
        Person_ person = personRepo.findByEmail(email);

        return person.getPassword().equals(encrypted);
    }

    public Person get(String email){
        System.out.println(email);
        Person person = new Person(personRepo.findByEmail(email));
        return person;
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
        person.addPass(pass.getPass());

        personRepo.save(person);

        pass.owner(new Person(person));
        passService.create(pass);
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
}
