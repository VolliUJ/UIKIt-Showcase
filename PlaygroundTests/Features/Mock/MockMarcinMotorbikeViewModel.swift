
import Foundation
import PromiseKit
import XCTest

@testable import Playground

class MockMarcinMotorbikeViewModel: MarcinMotorbikeViewModel {
    var fetchDataExceptation: XCTestExpectation?

    override func validate() -> Promise<Bool> {
        return firstly {
            super.validate()
        }.then { resp -> Promise<Bool> in
            self.fetchDataExceptation?.fulfill()
            return .value(resp)
        }
    }
}
