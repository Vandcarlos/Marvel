//

class DetailsCharacterInteractor: DetailsCharacterInteractorToPresenter {

    var presenter: DetailsCharacterPresenterToInteractor?

    func favoriteCharacter(_ character: Character) {
        FavoriteCharacter.shared.favorite(character)
    }

    func unfavoriteCharacter(withId id: Int) {
        FavoriteCharacter.shared.unfavorite(withId: id)
    }

}
