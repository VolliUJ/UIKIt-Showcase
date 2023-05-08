
import PromiseKit
import UIKit

final class MarcinCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var stop: (() -> Void)?
    weak var deallocable: Deinitcallable?

    private let api: API
    private let profile: MarcinProfile
    
    init(rootViewController: UINavigationController, api: API, profile: MarcinProfile) {
        self.navigationController = rootViewController
        self.api = api
        self.profile = profile
    }

    func start() {
        show(screen: .profile)
    }

    func start(screen: Screen) {
        show(screen: screen)
    }
}

extension MarcinCoordinator {
    enum Screen {
        case profile
        case motorbike(motorbike: Motorbike)
    }

    func show(screen: Screen) {
        switch screen {
        case .profile:
            showProfileScreen()
        case let .motorbike(motorbike):
            showMotorbikeScreen(motorbike: motorbike)
        }
    }

    func showProfileScreen() {
        let viewModel = MarcinProfileViewModel(profile: profile, delegate: self)
        let viewController = MarcinProfileViewController(viewModel: viewModel)

        setDeallocable(with: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showMotorbikeScreen(motorbike: Motorbike) {
        let viewModel = MarcinMotorbikeViewModel(motorbike: motorbike, delegate: self)
        let viewController = MarcinMotorbikeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: Marcin Profile Delegate

extension MarcinCoordinator: MarcinProfileViewModelDelegate {
    func fetchMarcinProfile() -> Promise<MarcinProfile> {
        return api.fetchMarcinProfile()
    }

    func didSelectMotorbike(motorbike: Motorbike) {
        show(screen: .motorbike(motorbike: motorbike))
    }
}

// MARK: Marcin Motorbike Delegate

extension MarcinCoordinator: MarcinMotorbikeViewModelDelegate {
    func fetchMotorbike(name: String) -> Promise<Motorbike?> {
        return api.fetchMotorbike(name: name)
    }
}
