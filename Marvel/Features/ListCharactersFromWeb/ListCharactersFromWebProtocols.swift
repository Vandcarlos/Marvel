//

import UIKit.UIViewController

// MARK: View

protocol ListCharactersFromWebViewToPresenter: UIViewController {

    var presenter: ListCharactersFromWebPresenterToView! { get set }

    var query: String { get }

    func reloadCharcters()
    func showErrorAboutFechCharacters(withMessage message: String)
    func showEmptyState()
    func hideEmptyState()
    func showRetryButton()

}

protocol ListCharactersFromWebPresenterToView {

    var currentCharacters: [Character] { get }
    var numberOfRows: Int { get }

    // MARK: Life cycle

    func viewWillAppear()

    // MARK: Actions

    func searchTapped()
    func itemTapped(withIndex index: Int)
    func favoriteButtonTapped(withIndex index: Int)
    func retryLoad()
    func configuredCell(withRow row: Int)
    func cancelWhenErrorTapped()

}

// MARK: Interactor

protocol ListCharactersFromWebInteractorToPresenter {

    var presenter: ListCharactersFromWebPresenterToInteractor! { get set }

    func fetchCharacters(withQuery query: String, andPage page: Int)
    func checkCharactersFavoriteState(_ characters: [Character])

    func favoriteCharacter(_ character: Character)
    func unfavoriteCharacter(withId id: Int)

}

protocol ListCharactersFromWebPresenterToInteractor {

    func didFechCharacters(_ characters: [Character], toQuery query: String)
    func didFailOnFechCharacters(withMessage message: String, toQuery query: String)

    func didCheckCharactersFavoriteState(_ characters: [Character])

}

// MARK: Router

protocol ListCharactersFromWebRouterToPresenter {

    func openDetailsOf(character: Character)

}
