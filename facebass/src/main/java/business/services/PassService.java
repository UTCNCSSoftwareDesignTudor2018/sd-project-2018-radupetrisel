package business.services;

import business.dtos.Pass;
import dataAccess.repositories.PassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PassService {

    @Autowired
    private PassRepository passRepo;

    public void create(Pass pass){
        passRepo.save(pass.getPass());
    }

}
