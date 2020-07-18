//

import XCTest
@testable import Marvel

class ListCharactersFromWebTests: XCTestCase {

    private var presenter: ListCharactersFromWebPresenter!
    private var view: TestViewToPresenter!
    private var interactor: TestInteractorToPresenter!
    private var router: TestRouterToPresenter!

    override func setUp() {
        view = TestViewToPresenter()
        interactor = TestInteractorToPresenter()
        router = TestRouterToPresenter()
        presenter = ListCharactersFromWebPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
    }

    func testExposedCharacters() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        presenter.searchTapped()

        XCTAssertEqual(presenter.currentCharacters, interactor.characters)
    }

    func testLoadCharactersWillViewAppear() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        presenter.viewWillAppear()

        XCTAssertTrue(view.state.reloadCharcters)
        XCTAssertEqual(presenter.currentCharacters, interactor.characters)
    }

    func testRefreshCharactersWillViewAppearIfHasFavoritChanges() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        presenter.viewWillAppear()

        view.state.reloadCharcters = false

        interactor.characters[0].favorited = true
        presenter.viewWillAppear()

        XCTAssertTrue(view.state.reloadCharcters)
        XCTAssertEqual(presenter.currentCharacters, interactor.characters)
    }

    func testNotRefreshCharactersWillViewAppearIfNotHasFavoritChanges() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        presenter.viewWillAppear()

        view.state.reloadCharcters = false

        presenter.viewWillAppear()

        XCTAssertFalse(view.state.reloadCharcters)
    }

    func testFetchCharacterWithoutQuery() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 3, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 5, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 7, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        interactor.pageSize = 2
        presenter.searchTapped()
        XCTAssertEqual(presenter.currentCharacters.count, 2)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 4)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 6)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 7)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 7)
        XCTAssertTrue(view.state.reloadCharcters)
    }

    func testFetchCharacterWithQuery() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        view.query = "Bar"

        presenter.searchTapped()
        XCTAssertEqual(presenter.currentCharacters.count, 2)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 3)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 5)
        XCTAssertEqual(presenter.currentCharacters.count, 3)
        XCTAssertTrue(view.state.reloadCharcters)
    }

    func testOpenDetailsWhenItemIsTapped() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        interactor.pageSize = 10
        presenter.viewWillAppear()

        presenter.itemTapped(withIndex: 3)

        XCTAssertEqual(presenter.currentCharacters[3], router.characterToOpen)
    }

    func testFavoriteCharacterWhenFavoriteButtonIsTapped() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        interactor.pageSize = 10
        presenter.viewWillAppear()

        presenter.favoriteButtonTapped(withIndex: 3)

        XCTAssertTrue(presenter.currentCharacters[3].favorited)
        XCTAssertTrue(interactor.characters[3].favorited)
    }

    func testUnfavoriteCharacterWhenFavoriteButtonIsTapped() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: false),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: false)
        ]

        interactor.pageSize = 10
        presenter.viewWillAppear()

        presenter.favoriteButtonTapped(withIndex: 3)

        XCTAssertFalse(presenter.currentCharacters[3].favorited)
        XCTAssertFalse(interactor.characters[3].favorited)
    }

    func testShowErrorMessage() throws {
        presenter.viewWillAppear()
        let errorMessage = "Foo bar error"
        interactor.simulateError(message: errorMessage, toQuery: view.query)

        XCTAssertEqual(view.state.errorMessage, errorMessage)
    }

}

// MARK: Test classes

extension ListCharactersFromWebTests {

    struct TestSate {

        var reloadCharcters = false
        var errorMessage: String?
        var emptyStateEnabled: Bool = false
        var showRetryButton: Bool = false

    }

    class TestViewToPresenter: UIViewController, ListCharactersFromWebViewToPresenter {

        var state = TestSate()

        func resetTestState() {
            state = TestSate()
        }

        var presenter: ListCharactersFromWebPresenterToView!

        var query: String = ""

        func reloadCharcters() {
            state.reloadCharcters = true
        }

        func showErrorAboutFechCharacters(withMessage message: String) {
            state.errorMessage = message
        }

        func showEmptyState() {
            state.emptyStateEnabled = true
        }

        func hideEmptyState() {
            state.emptyStateEnabled = false
        }

        func showRetryButton() {
            state.emptyStateEnabled = true
        }
    }

    class TestInteractorToPresenter: ListCharactersFromWebInteractorToPresenter {

        var characters: [Character] = []

        var pageSize = 2

        var presenter: ListCharactersFromWebPresenterToInteractor!

        func simulateError(message: String, toQuery query: String) {
            presenter?.didFailOnFechCharacters(withMessage: message, toQuery: query)
        }

        func fetchCharacters(withQuery query: String, andPage page: Int) {
            var filteredCharcters = characters

            if !query.isEmpty {
                filteredCharcters = filteredCharcters.filter { $0.name.starts(with: query) }
            }

            let start = page * pageSize

            guard filteredCharcters.count > start else {
                presenter?.didFechCharacters([], toQuery: query)
                return
            }

            var end = start + pageSize

            if end > filteredCharcters.count {
                end = filteredCharcters.count
            }

            let charactersCallback = Array(filteredCharcters[start..<end])
            presenter?.didFechCharacters(charactersCallback, toQuery: query)
        }

        func checkCharactersFavoriteState(_ characters: [Character]) {
            let charactersCallback = characters.compactMap { character in
                return self.characters.first { $0.id == character.id }
            }
            presenter?.didCheckCharactersFavoriteState(charactersCallback)
        }

        func favoriteCharacter(_ character: Character) {
            if let index = characters.firstIndex(where: { $0.id == character.id }) {
                characters[index].favorited = true
            }
        }

        func unfavoriteCharacter(withId id: Int) {
            if let index = characters.firstIndex(where: { $0.id == id }) {
                characters[index].favorited = false
            }
        }

    }

    class TestRouterToPresenter: ListCharactersFromWebRouterToPresenter {

        var characterToOpen: Character?

        func openDetailsOf(character: Character) {
            characterToOpen = character
        }

    }

}
