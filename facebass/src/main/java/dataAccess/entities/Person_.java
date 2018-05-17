package dataAccess.entities;

import com.sun.org.apache.xml.internal.security.utils.Base64;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "persons")
@DynamicUpdate
public class Person_ {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "cnp", nullable = false)
    private String cnp;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "inspector")
    private boolean inspector;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "face_api_person_id")
    private String faceApiId;

    @OneToMany(mappedBy = "owner")
    private List<Pass_> passes;

    public List<Pass_> getPasses() {
        return passes;
    }

    public void setPasses(List<Pass_> passes) {
        this.passes = passes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getCnp() {
        return cnp;
    }

    public void setCnp(String cnp) {
        this.cnp = cnp;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public boolean isInspector() {
        return inspector;
    }

    public void setInspector(boolean inspector) {
        this.inspector = inspector;
    }

    public String getFaceApiId() {
        return faceApiId;
    }

    public void setFaceApiId(String faceApiId) {
        this.faceApiId = faceApiId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = Base64.encode(password.getBytes());
    }

    @Override
    public String toString() {
        return "Person_{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", cnp='" + cnp + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", inspector=" + inspector +
                ", password='" + password + '\'' +
                '}';
    }

    public void addPass(Pass_ pass){
        this.passes.add(pass);
    }
}
