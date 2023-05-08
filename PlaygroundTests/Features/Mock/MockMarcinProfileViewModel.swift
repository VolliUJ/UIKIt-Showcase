
import Foundation
import PromiseKit
import XCTest

@testable import Playground

class MockMarcinProfileViewModel: MarcinProfileViewModel {
    var fetchDataExceptation: XCTestExpectation?

    override func validate() -> Promise<Bool> {
        return firstly {
            super.validate()
        }.then { [weak self] resp -> Promise<Bool> in
            self?.fetchDataExceptation?.fulfill()
            return .value(resp)
        }
    }
}
