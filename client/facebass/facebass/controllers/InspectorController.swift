//
//  InspectorController.swift
//  facebass
//
//  Created by Radu Petrisel on 26/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Alamofire

extension UIImage{
    
    func addRectangle(left: Int, top: Int, width: Int, height: Int, color: UIColor) -> UIImage{
        
        let size = self.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let ctx = UIGraphicsGetCurrentContext()
        
        self.draw(at: CGPoint(x: 0, y: 0))
        
        let rect = CGRect(x: left, y: top, width: width, height: height)
        
        ctx?.setStrokeColor(color.cgColor)
        ctx?.setLineWidth(1.0)
        ctx?.addRect(rect)
        ctx?.strokePath()
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

class InspectorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, FrameExtractorDelegate {
    
    
    private var rect: [String: Int]?
    private var color: UIColor?
    
    func captured(image: UIImage) {
        
        videoFeed.image = image
        
        if processImage {
            
            processImage = false
            DispatchQueue.main.async {
                
                let endpoint = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect"
                let key = "010fcff9d7fe45d584811ef37e83d87b"
                
                let url = URL(string: endpoint)!
                var req = URLRequest(url: url)
                req.addValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
                req.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                
                req.httpBody = UIImageJPEGRepresentation(image, 0.5)
                req.httpMethod = "POST"
                
                Alamofire.request(req).responseJSON{response in
                    
                    guard let dict = response.result.value as? [[String: Any]] else {
                        
                        //self.processImage = true
                        
                        self.rect = nil
                        self.color = nil
                        print("no face detected")
                        return
                    }
                    
                    guard dict.count > 0 else {
                        
                        //self.processImage = true
                        //print(response.result.value)
                        
                        self.rect = nil
                        self.color = nil
                        print("no face detected")
                        return
                    }
                    
                    guard let faceId = dict[0]["faceId"] as? String else {
                       // self.processImage = true
                        return
                    }
                    
                    self.rect = dict.map{elem in return elem["faceRectangle"] as! [String: Int]}.first!
                    self.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    
                    let endpoint = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/identify"
                    let headers = ["Ocp-Apim-Subscription-Key": key]
                    let body: Parameters = ["faceIds": [faceId], "personGroupId": "facebass"]
                    
                    Alamofire.request(endpoint, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON{
                        
                        response in
                        
                        guard let dict = response.result.value as? [[String: Any]] else {
                           // self.processImage = true
                            return
                        }
                        
                        guard let candidates = dict[0]["candidates"] as? [[String: Any]] else {
                            print("candidates parse error")
                            return
                        }
                        
                        guard candidates.count > 0 else {
                            
                            self.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                            print("no candidate found")
                            return
                        }
                        
                        guard let personId = candidates[0]["personId"] as? String else {
                            print("personId parse error")
                            return
                        }
                        
                        Alamofire.request(server! + "/person/inspect?faceId=" + personId + "&bus=\(self.selectedBus!.line)", method: .get).responseJSON{
                            
                            response in
                            
                            guard let status = response.result.value as? Bool else {
                                print("response parsing error")
                                return
                            }
                            
                            if status {
                                self.color = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                            } else {
                                self.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                            }
                            
                            //self.processImage = true
                        }
                        
                    }
                }
            }
        }
        
        guard let rect = self.rect else {
            self.videoFeed.image = image
            return
        }
        
        self.videoFeed.image = image.addRectangle(left: rect["left"]!, top: rect["top"]!, width: rect["width"]!, height: rect["height"]!, color: color!)
    }
    
    @IBOutlet weak var selectedLine: UITextField!
    @IBOutlet weak var linePicker: UIPickerView!
    @IBOutlet weak var videoFeed: UIImageView!
    @IBOutlet weak var startInspecting: UIButton!
    
    private var processImage: Bool = false
    
    var frameExtractor: FrameExtractor!
    
    var selectedBus: Bus?
    var busses: [Bus] = [Bus]()
    
    @objc func inspect(){
        
        frameExtractor = FrameExtractor()
        frameExtractor.delegate = self
        videoFeed.isHidden = false
        videoFeed.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeVideoFeed)))
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.processImage = true
        }
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
