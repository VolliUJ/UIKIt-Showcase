
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().tintColor = .systemBlue
        
        appCoordinator = AppCoordinator(window: window, launchOptions: launchOptions)
        appCoordinator?.start()

        return true
    }
}
