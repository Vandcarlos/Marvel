//

import MarvelUIKit
import MarvelAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configFrameworks()
        configWindow()

        return true
    }

    private func configFrameworks() {
        MarvelUIKit.configure()
        MarvelAPI.configure(apiKeys: ApiKeys())
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
}

