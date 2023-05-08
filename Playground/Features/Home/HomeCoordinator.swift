
import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var stop: (() -> Void)?
    weak var deallocable: Deinitcallable?

    init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }

    func start() {
        showHomeScreen()
    }

    func showHomeScreen() {
        let viewModel = HomeViewModel(delegate: self)
        let viewController = HomeViewController(viewModel: viewModel)
        setDeallocable(with: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showMarcinScreen() {
        let coordinator = MarcinCoordinator(rootViewController: navigationController, api: APIDump(), profile: marcinProfile)
        coordinator.setupParent(with: self)
        coordinator.start()
    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    func didSelectMarcin() {
        showMarcinScreen()
    }
}

extension HomeCoordinator {
    private var marcinProfile: MarcinProfile {
        MarcinProfile(name: Texts.marcinName,
                      role: Texts.marcinRole,
                      image: Images.marcinAvatar)
    }
}
