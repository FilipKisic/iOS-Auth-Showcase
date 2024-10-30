import UIKit

// MARK: - AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: CoordinatorType!
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
        -> Bool
    {
        let coordinator = Coordinator(window: window!, sceneFactory: SceneFactory())
        coordinator.start()

        window?.makeKeyAndVisible()
        return true
    }
}

