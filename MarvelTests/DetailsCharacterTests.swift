//

import XCTest
@testable import Marvel

class DetailsCharacterTests: XCTestCase {

    private var presenter: DetailsCharacterPresenter!
    private var view: TestDetailsCharacterViewToPresenter!
    private var interactor: TestDetailsCharacterInteractorToPresenter!
    private var router: TestDetailsCharacterRouter!
    private var character: Character!

    override func setUp() {
        character = Character(
            id: 1,
            name: "Foo",
            description: "Bar",
            thumbnail: UIImage(),
            favorited: false
        )
        view = TestDetailsCharacterViewToPresenter()
        interactor = TestDetailsCharacterInteractorToPresenter()
        router = TestDetailsCharacterRouter()
        presenter = DetailsCharacterPresenter(
            character: character,
            view: view,
            interactor: interactor,
            router: router
        )
        view.presenter = presenter
        interactor.presenter = presenter
    }

    func testExposedCharacter() throws {
        XCTAssertEqual(presenter.currentCharacter, character)
    }

    func testFavoriteCharacter() throws {
        presenter.favoriteButtonTapped()

        guard let characterIsFavorite = interactor.characterIsFavorite else {
            XCTFail("Expected characterIsFavorite not nil")
            return
        }

        XCTAssertTrue(characterIsFavorite)
    }

    func testUnfavoriteCharacter() throws {
        presenter.favoriteButtonTapped()
        presenter.favoriteButtonTapped()

        guard let characterIsFavorite = interactor.characterIsFavorite else {
            XCTFail("Expected characterIsFavorite not nil")
            return
        }

        XCTAssertFalse(characterIsFavorite)
    }

}

extension DetailsCharacterTests {

    class TestDetailsCharacterViewToPresenter: DetailsCharacterViewToPresenter {

        var presenter: DetailsCharacterPresenterToView!

    }

    class TestDetailsCharacterInteractorToPresenter: DetailsCharacterInteractorToPresenter {

        var presenter: DetailsCharacterPresenterToInteractor!

        var characterIsFavorite: Bool?

        func favoriteCharacter(_ character: Character) {
            characterIsFavorite = true
        }
        func unfavoriteCharacter(withId id: Int) {
            characterIsFavorite = false
        }

    }

    class TestDetailsCharacterRouter: DetailsCharacterRouter {}

}
