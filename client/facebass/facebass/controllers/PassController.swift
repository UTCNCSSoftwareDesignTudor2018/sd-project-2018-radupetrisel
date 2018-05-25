//
//  PassController.swift
//  facebass
//
//  Created by Radu Petrisel on 20/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

class PassController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var linePicker: UIPickerView!
    var lines: [Bus] = [Bus]()
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var selectedBusText: UITextField!
    
    var selectedBus: Bus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linePicker.delegate = self
        self.linePicker.dataSource = self
        
        self.selectedBusText.delegate = self
        
        Alamofire.request(server! + "/bus/getAll", method: .get).responseJSON{
                response in
            
                self.lines = (try? JSONDecoder().decode([Bus].self, from: response.data!))!
                self.linePicker.reloadAllComponents()
        }
        
        buy.addTarget(self, action: #selector(buyPass), for: .touchUpInside)
    }
    
    @objc func buyPass(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let params: Parameters = ["bus": self.selectedBus!.json, "expiryDate": formatter.string(from: Date())]

        Alamofire.request(server! + "/person/" + user! + "/addPass", method: .post, parameters: params, encoding: JSONEncoding.default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedBusText.text! = lines[row].line
        self.selectedBus = lines[row]
        self.linePicker.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.lines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.lines[row].line
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        linePicker.isHidden = false
        return false
    }

}
