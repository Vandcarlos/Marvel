//

import MarvelUIKit

class DetailsCharacterViewController: UIViewController, DetailsCharacterViewToPresenter {

    weak var presenter: DetailsCharacterPresenterToView?

    // MARK: View

    var mainView: DetailsCharacterView = {
        let mainView = DetailsCharacterView()
        return mainView
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        self.view = mainView

        guard let presenter = self.presenter else { return }

        mainView.thumbnail.image = presenter.currentCharacter.thumbnail
        mainView.favoriteButton.isFavorite = presenter.currentCharacter.favorited
        mainView.nameLabel.text = presenter.currentCharacter.name
        mainView.descLabel.text = presenter.currentCharacter.description

        mainView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

    // MARK: View to presenter stubs

    @objc func favoriteButtonTapped() {
        presenter?.favoriteButtonTapped()
    }

}
