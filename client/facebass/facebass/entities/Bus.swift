//
//  Bus.swift
//  facebass
//
//  Created by Radu Petrisel on 21/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import Foundation

class Bus: Encodable, Decodable, CustomStringConvertible{
    
    var description: String{ return self.line}

    var line: String = String()
    var stations: [Station]  = [Station]()
    
    var json: [String: Any]{
        return ["line": self.line, "stations": stations]
    }
}
