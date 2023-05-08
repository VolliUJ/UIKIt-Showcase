
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var stop: (() -> Void)?
    var deallocable: Deinitcallable?

    var window: UIWindow
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?

    init(with navigationController: UINavigationController = UINavigationController(), window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.navigationController = navigationController
        self.window = window
        self.launchOptions = launchOptions
    }

    func start() {
        let homeCoordinator = HomeCoordinator(rootViewController: navigationController)
        homeCoordinator.setupParent(with: self)
        homeCoordinator.start()

        window.rootViewController = homeCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
