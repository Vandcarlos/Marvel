//

import MarvelUIKit

class DetailsCharacterPresenter {

    private var character: Character
    private var view: DetailsCharacterViewToPresenter
    private var interactor: DetailsCharacterInteractorToPresenter
    private let router: DetailsCharacterRouterToPresenter

    init(
        character: Character,
        view: DetailsCharacterViewToPresenter,
        interactor: DetailsCharacterInteractorToPresenter,
        router: DetailsCharacterRouterToPresenter
    ) {
        self.character = character
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}

extension DetailsCharacterPresenter: DetailsCharacterPresenterToView {

    var currentCharacter: Character {
        character
    }

    func favoriteButtonTapped() {
        character.favorited = !character.favorited

        if character.favorited {
            interactor.favoriteCharacter(character)
        } else {
            interactor.unfavoriteCharacter(withId: character.id)
        }
    }

}

extension DetailsCharacterPresenter: DetailsCharacterPresenterToInteractor {

}
