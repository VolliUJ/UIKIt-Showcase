//  Inspiration: https://khanlou.com/2015/10/coordinators-redux/
//  Deinit Inspiration: https://medium.com/@ed.mejia/a-deallocation-approach-for-the-coordinator-pattern-ec1b9181c958

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var stop: (() -> Void)? { get set }
    var deallocable: Deinitcallable? { get set }

    func start()
    func setDeallocable(with object: Deinitcallable)
}

protocol Deinitcallable: AnyObject {
    var onDeinit: (() -> Void)? { get set }
}

extension Coordinator {
    func setDeallocable(with object: Deinitcallable) {
        deallocable?.onDeinit = nil
        object.onDeinit = { [weak self] in
            self?.stop?()
        }
        deallocable = object
    }

    func setupParent(with parentCoordinator: Coordinator) {
        stop = { [weak parentCoordinator] in
            parentCoordinator?.childCoordinators.removeAll { $0 is Self }
        }

        parentCoordinator.childCoordinators.append(self)
    }
}
