//
//  CreateAccountController.swift
//  facebass
//
//  Created by Radu Petrisel on 23/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountController: UIViewController {
    
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var cnp: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    
    @objc func createAccount(){
        
        let params: Parameters = ["firstName": firstName.text!,
                                  "lastName": lastName.text!,
                                  "cnp": cnp.text!,
                                  "address": address.text!,
                                  "email": email.text!,
                                  "phoneNumber": phoneNumber.text!,
                                  "password": password.text!
                                ]
        
        Alamofire.request("http://" + serverAddress.text! + ":1111/facebass/person/create", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{
            
            response in
           
            guard response.result.isSuccess else { return }
            
            let key = "010fcff9d7fe45d584811ef37e83d87b"
            let endpoint = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/facebass/persons"
            
            let headers = ["Ocp-Apim-Subscription-Key": key]
            let body = ["name": self.firstName.text! + " " + self.lastName.text!]
            
            Alamofire.request(endpoint, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON{
                
                response in
                
                guard let id = try? JSONDecoder().decode(PersonId.self, from: response.data!) else{
                    return
                }
                
                let params: Parameters = ["faceId": id.personId]
                
                Alamofire.request("http://" + self.serverAddress.text! + ":1111/facebass/person/" + self.email.text! + "/addFace", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{
                    response in
                    
                    if (response.result.value as! Bool){
                        self.performSegue(withIdentifier: "toLogin", sender: self)
                    } else {
                        self.error.isHidden = false
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboard()
        
        create.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
