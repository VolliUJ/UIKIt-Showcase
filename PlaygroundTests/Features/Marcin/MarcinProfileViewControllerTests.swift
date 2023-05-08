
import Nimble
import Quick
import UIKit

@testable import Playground

class MarcinProfileViewControllerTests: QuickSpec {
    override func spec() {
        var viewModel: MarcinProfileViewModel!
        var viewController: MarcinProfileViewController!
        var delegate: MarcinProfileViewModelDelegate!

        beforeEach {
            let profile = MockMarcinProfile.mockMarcinProfile()
            delegate = MockMarcinProfileViewModelDelegate(profile: profile)
            viewModel = MarcinProfileViewModel(profile: profile, delegate: delegate)
            viewController = MarcinProfileViewController(viewModel: viewModel)

            viewController.viewDidLoad()
            viewController.render()            
        }

        context("Delegate methods") {
            it("shows motorbike details") {
                let motorbikeIndex = viewController.displayItems.firstIndex {
                    switch $0 {
                    case .motorbike: return true
                    default: return false
                    }
                }
                
                viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: motorbikeIndex!, section: 0))

                expect((delegate as! MockMarcinProfileViewModelDelegate).didSelectMotorbikeCalled)
                    .to(beTruthy())
            }
        }
    }
}
