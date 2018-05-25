package dataAccess.entities;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "stations")
public class Station_ {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", unique = true)
    private String name;

    @ManyToMany(mappedBy = "stations")
    private List<Bus_> busses = new ArrayList<>();

    public List<Bus_> getBusses() {
        return busses;
    }

    public void setBusses(List<Bus_> busses) {
        this.busses = busses;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
