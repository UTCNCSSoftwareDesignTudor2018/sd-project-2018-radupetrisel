//
//  ProfileController.swift
//  facebass
//
//  Created by Radu Petrisel on 20/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

class ProfileController: UIViewController {
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var cnp: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://" + server! + ":1111/facebass/person", method: .get, parameters: ["email": user!]).responseJSON{
                response in
            
            let person = (try? JSONDecoder().decode(Person.self, from: response.data!))!
            self.fullName.text = person.firstName + " " + person.lastName
            self.email.text = person.email
            self.cnp.text = person.cnp
            self.phone.text = person.phoneNumber
            self.address.text = person.address
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
