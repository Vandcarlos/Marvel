//

import UIKit.UIViewController

class ListCharactersFromWebPresenter {

    private var view: ListCharactersFromWebViewToPresenter
    private var interactor: ListCharactersFromWebInteractorToPresenter
    private let router: ListCharactersFromWebRouterToPresenter

    private var characters: [Character] = [] {
        didSet {
            characters.isEmpty ? view.showEmptyState() : view.reloadCharcters()
        }
    }

    private var lastQuery: String = ""
    private var page: Int = 0

    private var performingRequest: Bool = false
    private var hasError: Bool = false
    private var lastRequestReturnsEmpty: Bool = false

    private var numberOfFakeRows: Int = 10
    private var startLoadingWhenHasXCells: Int = 5

    init(
        view: ListCharactersFromWebViewToPresenter,
        interactor: ListCharactersFromWebInteractorToPresenter,
        router: ListCharactersFromWebRouterToPresenter
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

extension ListCharactersFromWebPresenter: ListCharactersFromWebPresenterToView {

    var currentCharacters: [Character] {
        characters
    }

    var numberOfRows: Int {
        performingRequest ? characters.count + numberOfFakeRows : characters.count
    }

    // MARK: Life cycle

    func viewWillAppear() {
        if characters.isEmpty {
            page = 0
            fetchCharacters()
        } else {
            interactor.checkCharactersFavoriteState(characters)
        }
    }

    // MARK: Actions

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

    func favoriteButtonTapped(withIndex index: Int) {
        guard characters.count > index else { return }

        characters[index].favorited = !characters[index].favorited

        let character = characters[index]

        if character.favorited {
            interactor.favoriteCharacter(character)
        } else {
            interactor.unfavoriteCharacter(withId: character.id)
        }
    }

    func retryLoad() {
        performingRequest = false
        fetchCharacters()
    }

    func configuredCell(withRow row: Int) {
        guard !performingRequest && !lastRequestReturnsEmpty && !hasError else { return }

        if row == characters.count - startLoadingWhenHasXCells {
            page += 1
            fetchCharacters()
        }
    }

    func cancelWhenErrorTapped() {
        characters.isEmpty ? view.showEmptyState() :view.reloadCharcters()
        view.showRetryButton()
    }

}

extension ListCharactersFromWebPresenter: ListCharactersFromWebPresenterToInteractor {

    func didFechCharacters(_ characters: [Character], toQuery query: String) {
        guard query == lastQuery else { return }

        performingRequest = false
        hasError = false
        lastRequestReturnsEmpty = characters.isEmpty
        self.characters.append(contentsOf: characters)

        if self.characters.isEmpty {
            view.showEmptyState()
        } else {
            view.reloadCharcters()
        }
    }

    func didFailOnFechCharacters(withMessage message: String, toQuery query: String) {
        guard query == lastQuery else { return }
        performingRequest = false
        hasError = true
        view.showErrorAboutFechCharacters(withMessage: message)
    }

    func didCheckCharactersFavoriteState(_ characters: [Character]) {
        if self.characters != characters {
            self.characters = characters
            view.reloadCharcters()
        }
    }

}
