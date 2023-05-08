
import Foundation
import UIKit

struct Motorbike {
    let brand: String
    let model: String
    let engine: String
    let description: String
    let image: UIImage?
}

extension Motorbike {
    var fullName: String {
        return "\(brand) \(model)"
    }
    
    var details: String {
        return "\(brand) \(model) \(engine)"
    }
}
