package business.services;

import business.dtos.Bus;
import business.dtos.Station;
import dataAccess.repositories.BusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public void addStation(Bus bus, Station station){
        bus.addStation(station);
    }

}
