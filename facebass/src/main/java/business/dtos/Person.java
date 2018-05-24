package business.dtos;

import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSetter;
import dataAccess.entities.Person_;

import java.util.List;
import java.util.stream.Collectors;

public class Person {

    @JsonIgnore
    private Person_ person;

    public Person(){
        this.person = new Person_();
    }

    public Person(Person_ person){
        this.person = person;
    }

    @JsonIgnore
    public void setId(int id){
        person.setId(id);
    }

    public List<Pass> getPasses() {
        return person.getPasses().stream().map(Pass::new).collect(Collectors.toList());
    }

    @JsonProperty
    public void passes(List<Pass> passes) {
        person.setPasses(passes.stream().map(Pass::getPass).collect(Collectors.toList()));
    }

    public String getFirstName() {
        return person.getFirstName();
    }

    @JsonProperty
    public void firstName(String firstName) {
        person.setFirstName(firstName);
    }

    public String getLastName() {
        return person.getLastName();
    }

    @JsonProperty
    public void lastName(String lastName) {
        person.setLastName(lastName);
    }

    public String getCnp() {
        return person.getCnp();
    }

    @JsonProperty
    public void cnp(String cnp) {
        person.setCnp(cnp);
    }

    public String getAddress() {
        return person.getAddress();
    }

    @JsonProperty
    public void address(String address) {
        person.setAddress(address);
    }

    public String getEmail() {
        return person.getEmail();
    }

    @JsonProperty
    public void email(String email) {
        person.setEmail(email);
    }

    public String getPhoneNumber() {
        return person.getPhoneNumber();
    }

    @JsonProperty
    public void phoneNumber(String phoneNumber) {
        person.setPhoneNumber(phoneNumber);
    }

    public boolean isInspector() {
        return person.isInspector();
    }

    @JsonProperty
    public void inspector(boolean inspector) {
        person.setInspector(inspector);
    }

    public String getFaceApiId() {
        return person.getFaceApiId();
    }

    @JsonProperty
    public void faceApiId(String faceApiId) {
        person.setFaceApiId(faceApiId);
    }

    public String getPassword() {
        return person.getPassword();
    }

    @JsonProperty
    public void password(String password) {
        person.setPassword(password);
    }

    public Person_ getPerson(){
        return this.person;
    }

    @Override
    public String toString() {
        return person.toString();
    }
}
