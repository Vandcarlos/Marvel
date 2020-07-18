//

import UIKit.UIViewController

class ListCharactersFromWebRouter: ListCharactersFromWebRouterToPresenter {

    let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDetailsOf(character: Character) {
        let view = DetailsCharacterViewController()
        let interactor = DetailsCharacterInteractor()
        let router = DetailsCharacterRouter()

        let presenter = DetailsCharacterPresenter(
            character: character,
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter

        viewController.navigationController?.pushViewController(view, animated: true)
    }

}
