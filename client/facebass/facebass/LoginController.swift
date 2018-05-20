import UIKit
import Alamofire

class LoginController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    @objc func loginFunc(){
        
        let parameters: Parameters = ["email": email.text!, "password": password.text!]
        Alamofire.request("http://192.168.100.6:1111/facebass/person/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
                response in
            
            print(response.result.value!)
            if let person = try? JSONDecoder().decode(Person.self, from: response.data!){
                print(person)
                self.performSegue(withIdentifier: "toMain", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        login.addTarget(self, action: #selector(self.loginFunc), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
