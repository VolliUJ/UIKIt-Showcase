
import PromiseKit
import UIKit

@testable import Playground

class MockHomeViewModelDelegate: HomeViewModelDelegate {
    var didSelectMarcinCalled = false
    
    func didSelectMarcin() {
        didSelectMarcinCalled = true
    }
}
