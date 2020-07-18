//

import Foundation

// MARK: View

protocol DetailsCharacterViewToPresenter {}

protocol DetailsCharacterPresenterToView: AnyObject {

    var currentCharacter: Character { get }

    func favoriteButtonTapped()

}

// MARK: Interactor

protocol DetailsCharacterInteractorToPresenter {

    func favoriteCharacter(_ character: Character)
    func unfavoriteCharacter(withId id: Int)

}

protocol DetailsCharacterPresenterToInteractor {

}

// MARK: Router

protocol DetailsCharacterRouterToPresenter {

}
