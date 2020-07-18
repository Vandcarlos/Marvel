//

import MarvelUIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = MUIColorManager.background.color
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rootNavigationController = MUINavigationController()
        let rootTabBarController = MUITabBarController()

        let tabs = [
            ListCharactersFromWebPresenter.build(viewController: rootTabBarController)
        ]

        rootTabBarController.viewControllers = tabs
        rootTabBarController.title = tabs.first?.title
        rootNavigationController.viewControllers = [rootTabBarController]

        UIApplication.shared.windows.first?.rootViewController = rootNavigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
