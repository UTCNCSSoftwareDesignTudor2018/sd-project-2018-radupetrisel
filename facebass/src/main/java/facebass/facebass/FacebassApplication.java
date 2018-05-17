package facebass.facebass;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = {"dataAccess.entities"})
@EnableJpaRepositories("dataAccess.repositories")
@ComponentScan(basePackages = {"dataAccess", "business", "communication"})
public class FacebassApplication {

    public static void main(String[] args) {
    
        SpringApplication.run(FacebassApplication.class, args);
    }
}
