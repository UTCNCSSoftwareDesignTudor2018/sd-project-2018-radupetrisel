package dataAccess.entities;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "passes")
public class Pass_ {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne
    @JoinColumn
    private Person_ owner;

    @OneToOne
    @JoinColumn
    private Bus_ bus;

    @Column(name = "expiry_date")
    private LocalDate expiryDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Person_ getOwner() {
        return owner;
    }

    public void setOwner(Person_ owner) {
        this.owner = owner;
    }

    public Bus_ getBus() {
        return bus;
    }

    public void setBus(Bus_ bus) {
        this.bus = bus;
    }
}
