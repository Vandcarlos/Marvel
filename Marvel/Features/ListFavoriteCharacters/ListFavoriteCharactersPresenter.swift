//

import UIKit.UIViewController

class ListFavoriteCharactersPresenter {

    private var view: ListFavoriteCharactersViewToPresenter
    private var interactor: ListFavoriteCharactersInteractorToPresenter
    private let router: ListFavoriteCharactersRouterToPresenter

    private var lastQuery: String = ""
    private var page: Int = 0
    private var characters: [Character] = [] {
        didSet {
            characters.isEmpty ? view.showEmptyState() : view.reloadCharcters()
        }
    }

    private var performingRequest: Bool = false
    private var lastRequestReturnsEmpty: Bool = false

    init(
        view: ListFavoriteCharactersViewToPresenter,
        interactor: ListFavoriteCharactersInteractorToPresenter,
        router: ListFavoriteCharactersRouterToPresenter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    private func fetchCharacters() {
        guard !performingRequest else { return }

        lastQuery = view.query
        performingRequest = true
        lastRequestReturnsEmpty = false
        view.hideEmptyState()
        view.reloadCharcters()
        interactor.fetchCharacters(withQuery: view.query, andPage: page)
    }

}

extension ListFavoriteCharactersPresenter: ListFavoriteCharactersPresenterToView {

    var currentCharacters: [Character] {
        characters
    }

    func viewWillAppear() {
        if characters.isEmpty {
            page = 0
            fetchCharacters()
        } else {
            lastQuery = view.query
            performingRequest = true
            interactor.refetchCharacters(withQuery: lastQuery, andPage: page)
        }
    }

    func searchTapped() {
        if view.query != lastQuery {
            page = 0
            characters = []
        }

        fetchCharacters()
    }

    func itemTapped(withIndex index: Int) {
        guard characters.count > index else { return }
        router.openDetailsOf(character: characters[index])
    }

    func deleteFavoriteButtonTapped(inRow row: Int) {
        guard characters.count > row else { return }

        let character = characters[row]
        interactor.unfavoriteCharacter(withId: character.id)
        characters.remove(at: row)
        view.reloadCharcters()
    }

    func configuredCell(withRow row: Int) {
        guard !performingRequest && !lastRequestReturnsEmpty else { return }

        if row == characters.count - 1 {
            page += 1
            fetchCharacters()
        }
    }

}

extension ListFavoriteCharactersPresenter: ListFavoriteCharactersPresenterToInteractor {

    func didFechCharacters(_ characters: [Character], toQuery query: String) {
        guard query == lastQuery else { return }

        performingRequest = false
        lastRequestReturnsEmpty = characters.isEmpty
        self.characters.append(contentsOf: characters)
    }

    func didRefetchCharacters(_ characters: [Character]) {
        performingRequest = false
        lastRequestReturnsEmpty = characters.isEmpty
        self.characters = characters
    }

}
