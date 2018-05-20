import Foundation

class Person: Decodable, CustomStringConvertible{
    
    var firstName: String?
    var lastName: String?
    var cnp: String?
    var address: String?
    var email: String?
    var phoneNumber: String?
    var ispector: Bool?
    var password: String?
    var faceApiId: String?
    
    public var description: String { return self.firstName! + " " + self.lastName!}
 
}
