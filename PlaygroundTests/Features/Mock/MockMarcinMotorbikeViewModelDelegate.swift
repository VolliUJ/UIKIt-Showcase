
import Foundation
import PromiseKit

@testable import Playground

class MockMarcinMotorbikeViewModelDelegate: MarcinMotorbikeViewModelDelegate {
    var didFetchMotorbikeCalled = false
    var motorbike: Motorbike

    init(motorbike: Motorbike) {
        self.motorbike = motorbike
    }

    func fetchMotorbike(name: String) -> Promise<Motorbike?> {
        didFetchMotorbikeCalled = true
        return .value(motorbike)
    }
}
