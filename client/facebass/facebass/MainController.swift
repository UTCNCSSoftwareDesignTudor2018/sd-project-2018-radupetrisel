//
//  MainController.swift
//  facebass
//
//  Created by Radu Petrisel on 20/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var viewPasses: UIButton!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
