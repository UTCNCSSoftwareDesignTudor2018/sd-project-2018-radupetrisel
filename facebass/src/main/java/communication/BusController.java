package communication;

import business.dtos.Bus;
import business.services.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/bus")
public class BusController {

    @Autowired
    private BusService busService;

    @GetMapping("/getAll")
    public List<String> getAll(){

        return busService.getAll().stream().map(Bus::getName).collect(Collectors.toList());
    }

}
