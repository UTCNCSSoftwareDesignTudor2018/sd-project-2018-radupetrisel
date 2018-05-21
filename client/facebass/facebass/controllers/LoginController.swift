import UIKit
import Alamofire

class LoginController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    @objc func loginFunc(){
        
        let parameters: Parameters = ["email": email.text!, "password": password.text!]
        Alamofire.request("http://" + serverAddress.text! + ":1111/facebass/person/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
                response in
            
            print(response.result.value ?? "err")
            let status = response.result.value as! Int
            if status > -1{
                self.performSegue(withIdentifier: "toMain", sender: self)
                user = self.email.text!
                server = "http://" + self.serverAddress.text! + ":1111/facebass"
                type = status
            }
            else {
                self.errorMessage.isHidden = false
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

extension UIViewController{
    
    func hideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hide(){
        view.endEditing(true)
    }
}
