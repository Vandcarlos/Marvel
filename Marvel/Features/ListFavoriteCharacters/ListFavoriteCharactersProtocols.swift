//

import UIKit.UIViewController

// MARK: View

protocol ListFavoriteCharactersViewToPresenter: UIViewController {

    var query: String { get }

    func reloadCharcters()
    func showEmptyState()
    func hideEmptyState()

}

protocol ListFavoriteCharactersPresenterToView: AnyObject {

    var currentCharacters: [Character] { get }

    // MARK: Life cycle

    func viewWillAppear()

    // MARK: Actions

    func searchTapped()
    func itemTapped(withIndex index: Int)
    func deleteFavoriteButtonTapped(inRow row: Int)
    func configuredCell(withRow row: Int)

}

// MARK: Interactor

protocol ListFavoriteCharactersInteractorToPresenter {

    func fetchCharacters(withQuery query: String, andPage page: Int)
    func refetchCharacters(withQuery query: String, andPage page: Int)
    func unfavoriteCharacter(withId id: Int)

}

protocol ListFavoriteCharactersPresenterToInteractor: AnyObject {

    func didFechCharacters(_ characters: [Character], toQuery query: String)
    func didRefetchCharacters(_ characters: [Character])

}

// MARK: Router

protocol ListFavoriteCharactersRouterToPresenter {

    func openDetailsOf(character: Character)

}
