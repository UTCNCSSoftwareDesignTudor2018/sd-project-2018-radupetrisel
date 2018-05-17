package communication;

import business.dtos.Bus;
import business.services.BusService;
import business.services.InspectorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/inspector")
public class InspectorController {

    @Autowired
    private InspectorService inspectorService;

    @Autowired
    private BusService busService;

    @GetMapping(value = "/inspect")
    public boolean check(@RequestParam("faceApiId") String apiId, @RequestParam("line") String line){

        Bus bus = busService.get(line);
        return inspectorService.check(apiId, bus);
    }
}
