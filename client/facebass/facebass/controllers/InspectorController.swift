//
//  InspectorController.swift
//  facebass
//
//  Created by Radu Petrisel on 26/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

class InspectorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, FrameExtractorDelegate {
    func captured(image: UIImage) {
        videoFeed.image = image
    }
    
    
    @IBOutlet weak var selectedLine: UITextField!
    @IBOutlet weak var linePicker: UIPickerView!
    @IBOutlet weak var videoFeed: UIImageView!
    @IBOutlet weak var startInspecting: UIButton!
    
    var frameExtractor: FrameExtractor!
    
    var selectedBus: Bus?
    var busses: [Bus] = [Bus]()
    
    @objc func inspect(){
        
        frameExtractor = FrameExtractor()
        frameExtractor.delegate = self
        videoFeed.isHidden = false
        videoFeed.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeVideoFeed)))
    }
    
    @objc func closeVideoFeed(){
        videoFeed.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.linePicker.delegate = self
        self.linePicker.dataSource = self
        
        self.selectedLine.delegate = self
        
        Alamofire.request(server! + "/bus/getAll", method: .get).responseJSON{
            response in
            
            self.busses = (try? JSONDecoder().decode([Bus].self, from: response.data!))!
            self.linePicker.reloadAllComponents()
        }
        
        startInspecting.addTarget(self, action: #selector(inspect), for: .touchUpInside)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedLine.text! = busses[row].line
        self.selectedBus = busses[row]
        self.linePicker.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.busses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.busses[row].line
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        linePicker.isHidden = false
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
