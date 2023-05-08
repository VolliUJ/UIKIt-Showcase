
import Nimble
import Quick
import UIKit

@testable import Playground

class MarcinCoordinatorTests: QuickSpec {
    override func spec() {
        var coordinator: MarcinCoordinator!

        beforeEach {
            coordinator = MarcinCoordinator(rootViewController: UINavigationController(),
                                            api: APIDump(),
                                            profile: MockMarcinProfile.mockMarcinEmptyProfile())
        }

        context("Navigation") {
            it("Shows the profile screen on the default start() implementation") {
                coordinator.start()

                expect(coordinator.navigationController.topViewController).to(beAKindOf(MarcinProfileViewController.self))
            }

            it("Shows the motorbike screen") {
                coordinator.showMotorbikeScreen(motorbike: MockMarcinProfile.mockMotorbike())

                expect(coordinator.navigationController.topViewController)
                    .to(beAKindOf(MarcinMotorbikeViewController.self))
            }
        }

        context("Delegate implementations") {
            it("GarimaProfileViewControllerDelegate") {
                coordinator.didSelectMotorbike(motorbike: MockMarcinProfile.mockMotorbike())

                expect(coordinator.navigationController.topViewController)
                    .to(beAKindOf(MarcinMotorbikeViewController.self))
            }
        }
    }
}
