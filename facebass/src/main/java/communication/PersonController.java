package communication;

import business.dtos.Pass;
import business.dtos.Person;
import business.services.PersonService;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping(value = "/person")
public class PersonController {

    @Autowired
    private PersonService personService;

    @PostMapping(value = "/login")
    public int login(@RequestBody Credential credential) {
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
    public void addPass(@PathVariable("email") String email, @RequestBody Pass pass){

        personService.addPass(email, pass);
    }

    @PostMapping(value = "{email}/addFace")
    public boolean addFace(@PathVariable("email") String email, @RequestBody JsonNode json){

        String faceId = json.get("faceId").asText();

        return personService.addFace(email, faceId);
    }

}
