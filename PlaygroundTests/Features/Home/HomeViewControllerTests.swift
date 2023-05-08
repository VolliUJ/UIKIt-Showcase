
import Nimble
import Quick
import UIKit

@testable import Playground

class HomeViewControllerTests: QuickSpec {
    override func spec() {
        var viewModel: HomeViewModel!
        var viewController: HomeViewController!
        var delegate: HomeViewModelDelegate!

        beforeEach {
            delegate = MockHomeViewModelDelegate()
            viewModel = HomeViewModel(delegate: delegate)
            viewController = HomeViewController(viewModel: viewModel)

            viewController.viewDidLoad()
            viewController.render()
        }

        describe("Delegate methods") {
            it("Did Select Marcin is called") {
                let marcinIndex = viewController.displayItems.firstIndex {
                    switch $0 {
                    case .marcin: return true
                    default: return false
                    }
                }
                
                viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: marcinIndex!, section: 0))

                expect((delegate as! MockHomeViewModelDelegate).didSelectMarcinCalled)
                    .to(beTruthy())
            }
        }
    }
}
