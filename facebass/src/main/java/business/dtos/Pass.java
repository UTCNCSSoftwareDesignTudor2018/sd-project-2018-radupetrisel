package business.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import dataAccess.entities.Pass_;

import java.time.LocalDate;

public class Pass {

    @JsonIgnore
    private Pass_ pass;

    public Pass() {
        this.pass = new Pass_();
    }

    public Pass(Pass_ pass) {
        this.pass = pass;
    }

    public LocalDate getExpiryDate() {
        return pass.getExpiryDate();
    }

    @JsonProperty
    public void expiryDate(LocalDate expiryDate) {
        pass.setExpiryDate(expiryDate);
    }

    @JsonProperty
    public void owner(Person owner) {
        pass.setOwner(owner.getPerson());
    }

    public Bus getBus() {
        return new Bus(pass.getBus());
    }

    @JsonProperty
    public void bus(Bus bus) {
        pass.setBus(bus.getBus());
    }

    public Pass_ getPass() {
        return this.pass;
    }
}
