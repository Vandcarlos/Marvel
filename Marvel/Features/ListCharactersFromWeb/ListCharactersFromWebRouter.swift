//

import UIKit.UIViewController

class ListCharactersFromWebRouter: ListCharactersFromWebRouterToPresenter {

    let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDetailsOf(character: Character) {
        let detailsVC = UIViewController()

        viewController.navigationController?.pushViewController(detailsVC, animated: true)
    }

}
