//

import XCTest
@testable import Marvel

class ListFavoriteCharactersTests: XCTestCase {

    private var presenter: ListFavoriteCharactersPresenter!
    private var view: TestViewToPresenter!
    private var interactor: TestInteractorToPresenter!
    private var router: TestRouterToPresenter!

    override func setUp() {
        view = TestViewToPresenter()
        interactor = TestInteractorToPresenter()
        router = TestRouterToPresenter()

        presenter = ListFavoriteCharactersPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
    }

    func testExposedCharacters() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        presenter.searchTapped()

        XCTAssertEqual(presenter.currentCharacters, interactor.characters)
    }

    func testLoadCharactersWillViewAppear() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        presenter.viewWillAppear()

        XCTAssertTrue(view.state.reloadCharcters)
        XCTAssertEqual(presenter.currentCharacters, interactor.characters)
    }

    func testRefreshCharactersWillViewAppearIfHasFavoritChanges() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        presenter.viewWillAppear()

        view.state.reloadCharcters = false

        interactor.characters[0].favorited = true
        presenter.viewWillAppear()

        XCTAssertTrue(view.state.reloadCharcters)
        XCTAssertEqual(presenter.currentCharacters.count, 1)
    }

    func testNotRefreshCharactersWillViewAppearIfNotHasFavoritChanges() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        presenter.viewWillAppear()

        view.state.reloadCharcters = false

        presenter.viewWillAppear()

        XCTAssertTrue(view.state.reloadCharcters)
        XCTAssertEqual(presenter.currentCharacters.count, 1)
    }

    func testFetchCharacterWithoutQuery() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 3, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 5, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 7, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        interactor.pageSize = 2
        presenter.searchTapped()
        XCTAssertEqual(presenter.currentCharacters.count, 2)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 4)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 6)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 7)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 7)
        XCTAssertTrue(view.state.reloadCharcters)
    }

    func testFetchCharacterWithQuery() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        view.query = "Bar"

        presenter.searchTapped()
        XCTAssertEqual(presenter.currentCharacters.count, 2)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 3)
        XCTAssertTrue(view.state.reloadCharcters)
        view.resetTestState()

        presenter.configuredCell(withRow: presenter.currentCharacters.count - 1)
        XCTAssertEqual(presenter.currentCharacters.count, 3)
        XCTAssertTrue(view.state.reloadCharcters)
    }

    func testOpenDetailsWhenItemIsTapped() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        interactor.pageSize = 10
        presenter.viewWillAppear()

        presenter.itemTapped(withIndex: 3)

        XCTAssertEqual(presenter.currentCharacters[3], router.characterToOpen)
    }

    func testUnfavoriteCharacterWhenFavoriteButtonIsTapped() throws {
        interactor.characters = [
            Character(id: 1, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 2, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 3, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 4, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 5, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 6, name: "Foo", description: "Nany", thumbnail: UIImage(), favorited: true),
            Character(id: 7, name: "Bar", description: "Nany", thumbnail: UIImage(), favorited: true)
        ]

        interactor.pageSize = 10
        presenter.viewWillAppear()

        presenter.deleteFavoriteButtonTapped(inRow: 3)

        XCTAssertEqual(presenter.currentCharacters.count, 6)
        XCTAssertFalse(interactor.characters[3].favorited)
    }

}

// MARK: Test classes

extension ListFavoriteCharactersTests {

    struct TestSate {

        var reloadCharcters = false
        var emptyStateEnabled: Bool = false

    }

    class TestViewToPresenter: UIViewController, ListFavoriteCharactersViewToPresenter {

        var state = TestSate()

        func resetTestState() {
            state = TestSate()
        }

        var presenter: ListFavoriteCharactersPresenterToView!

        var query: String = ""

        func reloadCharcters() {
            state.reloadCharcters = true
        }

        func showEmptyState() {
            state.emptyStateEnabled = true
        }

        func hideEmptyState() {
            state.emptyStateEnabled = false
        }

    }

    class TestInteractorToPresenter: ListFavoriteCharactersInteractorToPresenter {

        var characters: [Character] = []

        var pageSize = 2

        var presenter: ListFavoriteCharactersPresenterToInteractor!

        func fetchCharacters(withQuery query: String, andPage page: Int) {
            var filteredCharcters = characters.filter { $0.favorited }

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

        func refetchCharacters(withQuery query: String, andPage page: Int) {
            var filteredCharcters = characters.filter { $0.favorited }

            if !query.isEmpty {
                filteredCharcters = filteredCharcters.filter { $0.name.starts(with: query) }
            }

            var end = page * pageSize + pageSize

            if end > filteredCharcters.count {
                end = filteredCharcters.count
            }

            let charactersCallback = Array(filteredCharcters[0..<end])
            presenter?.didRefetchCharacters(charactersCallback)
        }

        func unfavoriteCharacter(withId id: Int) {
            if let index = characters.firstIndex(where: { $0.id == id }) {
                characters[index].favorited = false
            }
        }
    }

    class TestRouterToPresenter: ListFavoriteCharactersRouterToPresenter {

        var characterToOpen: Character?

        func openDetailsOf(character: Character) {
            characterToOpen = character
        }

    }

}
