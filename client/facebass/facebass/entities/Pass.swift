//
//  Pass.swift
//  facebass
//
//  Created by Radu Petrisel on 21/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit

class Pass: Encodable, Decodable, CustomStringConvertible {
    
    var description: String { return "Pass for " + self.bus.description + ", available until " + self.expiryDate.description}
    
    var expiryDate: Date
    var bus: Bus
    
    init(for bus: Bus){
        self.bus = bus
        self.expiryDate = Date()
    }
    
    var json: [String: Any]{
        
        return ["bus": bus, "expiryDate": expiryDate]
    }
    
}
