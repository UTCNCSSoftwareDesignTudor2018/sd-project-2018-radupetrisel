//
//  Station.swift
//  facebass
//
//  Created by Radu Petrisel on 21/05/2018.
//  Copyright © 2018 Radu Petrisel. All rights reserved.
//

import UIKit

class Station: Encodable, Decodable, CustomStringConvertible {
    
    var name: String = String()
    var busses: [String] = [String]()

    var description: String { return self.name}
    
    var json: [String: Any]{
        return ["name": name, "busses": busses]
    }
}
