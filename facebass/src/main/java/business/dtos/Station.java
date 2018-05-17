package business.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import dataAccess.entities.Station_;

import java.util.List;
import java.util.stream.Collectors;

public class Station {

    @JsonIgnore
    private Station_ station;

    public Station() {
        this.station = new Station_();
    }

    public Station(Station_ station) {
        this.station = station;
    }

    public List<String> getBusses() {
        return station.getBusses().stream().map(bus -> bus.getName()).collect(Collectors.toList());
    }

    @JsonProperty
    public void busses(List<Bus> busses) {
        station.setBusses(busses.stream().map(bus -> bus.getBus()).collect(Collectors.toList()));
    }

    public String getName() {
        return station.getName();
    }

    @JsonProperty
    public void name(String name) {
        station.setName(name);
    }

    public Station_ getStation() {
        return this.station;
    }
}
