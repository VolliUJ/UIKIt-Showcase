
import Nimble
import Quick
import UIKit

@testable import Playground

class HomeCoordinatorTests: QuickSpec {
    override func spec() {
        var coordinator: HomeCoordinator!

        beforeEach {
            coordinator = HomeCoordinator(rootViewController: UINavigationController())
        }

        describe("Navigation") {
            it("Shows the home screen on the default start() implementation") {
                coordinator.start()

                expect(coordinator.navigationController.topViewController).to(beAKindOf(HomeViewController.self))
            }

            it("Shows the Marcin screen") {
                coordinator.showMarcinScreen()

                expect(coordinator.navigationController.topViewController)
                    .to(beAKindOf(MarcinProfileViewController.self))
            }
        }

        describe("Delegate implementations") {
            it("Did Select Marcin is called") {
                coordinator.didSelectMarcin()
                
                expect(coordinator.navigationController.topViewController)
                    .to(beAKindOf(MarcinProfileViewController.self))
            }
        }
    }
}
