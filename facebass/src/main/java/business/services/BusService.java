package business.services;

import business.dtos.Bus;
import business.dtos.Station;
import dataAccess.repositories.BusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BusService {

    @Autowired
    private BusRepository busRepository;

    public void create(Bus bus){
        busRepository.save(bus.getBus());
    }

    public Bus get(String lineName){
        return new Bus(busRepository.findByName(lineName));
    }

    public List<Bus> getAll(){
        return busRepository.findAll().stream().map(Bus::new).collect(Collectors.toList());
    }
    
    public void addStation(Bus bus, Station station){
        bus.addStation(station);
    }

}
