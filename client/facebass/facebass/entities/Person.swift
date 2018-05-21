import Foundation

class Person: Encodable, Decodable, CustomStringConvertible{
    
    var firstName: String = String()
    var lastName: String = String()
    var cnp: String = String()
    var address: String = String()
    var email: String = String()
    var phoneNumber: String = String()
    var type: Int = Int()
    var password: String = String()
    var faceApiId: String = String()
    var passes: [Pass] = [Pass]()
    
    var description: String { return self.email}
 
}
