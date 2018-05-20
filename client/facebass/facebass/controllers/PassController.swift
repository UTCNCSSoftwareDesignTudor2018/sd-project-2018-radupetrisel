//
//  PassController.swift
//  facebass
//
//  Created by Radu Petrisel on 20/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

class PassController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var linePicker: UIPickerView!
    var lines: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linePicker.delegate = self
        self.linePicker.dataSource = self
        
        Alamofire.request("http://" + server! + ":1111/facebass/bus/getAll", method: .get).responseJSON{
                response in
            
                self.lines = (try? JSONDecoder().decode([String].self, from: response.data!))!
                self.linePicker.reloadAllComponents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.lines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.lines[row]
    }

}
