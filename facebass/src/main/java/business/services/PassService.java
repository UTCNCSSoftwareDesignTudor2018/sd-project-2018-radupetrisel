package business.services;

import business.dtos.Bus;
import business.dtos.Pass;
import dataAccess.repositories.BusRepository;
import dataAccess.repositories.PassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PassService {

    @Autowired
    private PassRepository passRepo;

    @Autowired
    private BusRepository busRepo;

    public void create(Pass pass){

        pass.bus(new Bus(busRepo.findByName(pass.getBus().getName())));
        pass.expiryDate(pass.getExpiryDate().plusMonths(1));
        passRepo.save(pass.getPass());
    }

}
