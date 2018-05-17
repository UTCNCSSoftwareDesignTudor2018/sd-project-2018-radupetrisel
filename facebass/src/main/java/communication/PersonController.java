package communication;

import business.dtos.Pass;
import business.dtos.Person;
import business.services.PersonService;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping(value = "/person")
public class PersonController {

    @Autowired
    private PersonService personService;

    @PostMapping(value = "/login")
    public boolean login(@RequestBody Credential credential) {
        return personService.login(credential.getEmail(), credential.getPassword());
    }

    @GetMapping
    public Person get(@RequestParam(value = "email") String email){
        return personService.get(email);
    }

    @PostMapping(value = "/create")
    public boolean create(@RequestBody Person person) {
        System.out.println(person);
        return personService.register(person);
    }

    @PostMapping(value = "/update")
    public void update(@RequestBody Person person){
        personService.update(person);
    }

    @PostMapping(value = "/{email}/updatePassword")
    public void updatePassword(@PathVariable("email") String email, @RequestBody String password){
        personService.updatePassword(email, password);
    }

    @PostMapping(value = "{email}/addPass")
    public void addPass(@RequestBody Pass pass,@PathVariable("email") String email){
        personService.addPass(email, pass);
    }

}
