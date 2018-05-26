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
    
    private var expiryDate_: Date?
    private var bus_: Bus?
    
    var expiryDate: Date{
        get{ return self.expiryDate_!}
        set{ self.expiryDate_ = newValue}
    }
    var bus: Bus{
        get{ return self.bus_!}
        set{ self.bus_ = newValue}
    }
    
    init(){
        expiryDate_ = Date()
        bus_ = Bus()
    }
    
    init(for bus: Bus){
        self.bus_ = bus
        self.expiryDate_ = Date()
    }
    
    var json: [String: Any]{
        
        return ["bus": bus.json, "expiryDate": expiryDate]
    }
    
}
