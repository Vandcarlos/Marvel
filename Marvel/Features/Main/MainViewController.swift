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
            createTabListCharacterFromWeb(viewController: rootTabBarController)
        ]

        rootTabBarController.viewControllers = tabs
        rootTabBarController.title = tabs.first?.title
        rootNavigationController.viewControllers = [rootTabBarController]

        UIApplication.shared.windows.first?.rootViewController = rootNavigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    private func createTabListCharacterFromWeb(viewController: UIViewController) -> UIViewController {
        let view = ListCharactersFromWebViewController()
        let interactor = ListCharactersFromWebInteractor()
        let router = ListCharactersFromWebRouter(viewController: viewController)
        let presenter = ListCharactersFromWebPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }

}
