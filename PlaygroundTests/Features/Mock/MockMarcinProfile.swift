
import Foundation
@testable import Playground
import UIKit

class MockMarcinProfile {
    class func mockMotorbike(id: String = "") -> Motorbike {
        return Motorbike(brand: "test_brand_\(id)",
                         model: "test_model_\(id)",
                         engine: "test_engine_\(id)",
                         description: "test_description_\(id)",
                         image: UIImage())
    }

    class func mockMarcinProfile(id: String = "") -> MarcinProfile {
        return MarcinProfile(name: "test_name_\(id)",
                             role: "test_role_\(id)",
                             image: UIImage(),
                             details: ["details_key_test_\(id)": "details_value_test_\(id)"],
                             motorbikes: [mockMotorbike(id: id)])
    }

    class func mockMarcinEmptyProfile(id: String = "") -> MarcinProfile {
        return MarcinProfile(name: "test_name_\(id)",
                             role: "test_role_\(id)",
                             image: nil,
                             details: [:],
                             motorbikes: [])
    }
}
