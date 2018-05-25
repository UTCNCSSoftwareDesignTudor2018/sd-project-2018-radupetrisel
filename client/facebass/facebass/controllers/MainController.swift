//
//  MainController.swift
//  facebass
//
//  Created by Radu Petrisel on 20/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class MainController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addPhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboard()

        addPhoto.addTarget(self, action: #selector(addPhotoHandler), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func addPhotoHandler(){
        
        let alert = UIAlertController(title: "Add photo", message: "Choose where to get photo from", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default){
            camera in
            
            self.authorize(type: .camera)
            
        })
        
        alert.addAction(UIAlertAction(title: "Photo library", style: .default){
          library in
           
            self.authorize(type: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authorize(type: Type){
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status{
            
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { status in
                if status == PHAuthorizationStatus.authorized{
                    self.openMedia(type)
            
                }else {
                    self.showAlert("Access to " + type.rawValue + " denied.")
                    
                }
            }
            
        case .authorized:
            self.openMedia(type)
        case .denied:
            self.showAlert("Access to " + type.rawValue + " denied.")
        case .restricted:
            self.showAlert("Access to " + type.rawValue + " restricted.")
        }
        
    }
    
    func showAlert(_ message: String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openMedia(_ type: Type){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        switch type{
            
        case .camera:
            
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            
            picker.sourceType = .camera
    
        case .photoLibrary:
            
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            
            picker.sourceType = .photoLibrary
            
        }
        
        self.present(picker, animated: true, completion: nil)
  
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("image error")
            return
        }
        
        let endpoint = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect"
        let key = "010fcff9d7fe45d584811ef37e83d87b"
        
        let url = URL(string: endpoint)!
        var req = URLRequest(url: url)
        req.addValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        req.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        req.httpBody = UIImageJPEGRepresentation(image, 0.5)
        req.httpMethod = "POST"
        
        Alamofire.request(req).responseJSON{response in
            
            let dict = response.result.value as! [[String: Any]]
            
            let face = dict[0]["faceRectangle"] as! [String: Any]
            
            let rect = FaceRectangle(left: face["left"] as! Int, top: face["top"] as! Int, height: face["height"] as! Int, width: face["width"] as! Int)
            
            let endpoint = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/persongroups/facebass/persons/" + faceApiId! + "/persistedFaces?targetFace=\(rect.left),\(rect.top),\(rect.width),\(rect.height)"
            let headers = ["Ocp-Apim-Subscription-Key": key, "Content-Type": "application/octet-stream"]

            let url = URL(string: endpoint)!
            var req = URLRequest(url: url)
            req.httpBody = UIImageJPEGRepresentation(image, 1.0)
            req.allHTTPHeaderFields = headers
            req.httpMethod = "POST"

            Alamofire.request(req).responseJSON{
                response in

                print(response.result.value)
            }
            
        }
    
        self.dismiss(animated: true, completion: nil)
    }

}

struct FaceRectangle{
    
    var height = Int()
    var left = Int()
    var top = Int()
    var width = Int()
    
    init(left: Int, top: Int, height: Int, width: Int){
        self.height = height
        self.width = width
        self.top = top
        self.left = left
    }
    
    var description: String{
        return "height: \(self.height), width: \(self.width), top: \(self.top), left: \(self.left)"
    }
    
}

struct Pixel{
    
    var r: Float
    var g: Float
    var b: Float
    
}

enum Type: String{
    case camera = "Camera"
    case photoLibrary = "Photo Library"
}
