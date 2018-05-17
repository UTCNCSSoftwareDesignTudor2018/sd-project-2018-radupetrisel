package business.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import dataAccess.entities.Bus_;

import java.util.List;
import java.util.stream.Collectors;

public class Bus {

    @JsonIgnore
    private Bus_ bus;

    public Bus(){
        this.bus = new Bus_();
    }

    public Bus(Bus_ bus){
        this.bus = bus;
    }

    public List<Station> getStations() {
        return bus.getStations().stream().map(station -> new Station(station)).collect(Collectors.toList());
    }

    @JsonProperty
    public void stations(List<Station> stations) {
        bus.setStations(stations.stream().map(station -> station.getStation()).collect(Collectors.toList()));
    }

    public String getName() {
        return bus.getName();
    }

    @JsonProperty
    public void name(String name) {
        bus.setName(name);
    }

    public void addStation(Station station){
        bus.addStation(station.getStation());
    }

    public Bus_ getBus(){
        return this.bus;
    }
}
