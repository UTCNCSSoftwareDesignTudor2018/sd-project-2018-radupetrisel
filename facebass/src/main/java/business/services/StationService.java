package business.services;

import business.dtos.Station;
import dataAccess.repositories.StationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StationService {

    @Autowired
    private StationRepository stationRepository;

    public void create(Station station){
        stationRepository.save(station.getStation());
    }

}
