
import Foundation
import UIKit

struct MarcinProfile {
    let name: String
    let role: String
    let image: UIImage?
    let details: KeyValuePairs<String, String>
    let motorbikes: [Motorbike]
}

extension MarcinProfile {
    init(name: String, role: String, image: UIImage?) {
        self.init(name: name, role: role, image: image, details: [:], motorbikes: [])
    }
}
