
import PromiseKit
import UIKit

@testable import Playground

class MockMarcinProfileViewModelDelegate: MarcinProfileViewModelDelegate {
    var fetchMarcinProfileCalled = false
    var didSelectMotorbikeCalled = false
    let profile: MarcinProfile

    init(profile: MarcinProfile) {
        self.profile = profile
    }

    func fetchMarcinProfile() -> Promise<MarcinProfile> {
        fetchMarcinProfileCalled = true
        return .value(profile)
    }

    func didSelectMotorbike(motorbike: Motorbike) {
        didSelectMotorbikeCalled = true
    }
}
