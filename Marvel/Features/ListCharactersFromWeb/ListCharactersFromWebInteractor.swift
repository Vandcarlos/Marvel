//

import MarvelAPI

class ListCharactersFromWebInteractor: ListCharactersFromWebInteractorToPresenter {

    var presenter: ListCharactersFromWebPresenterToInteractor?

    private let charactersWorer = MAPICharactersWorker()

    private func performSuccessRequest(with mAPICharacters: [MAPICharacter], toQuery query: String) {
        let characters: [Character] = mAPICharacters.map {
            let favorited = CharacterRealm.find(byId: $0.id) != nil
            return Character(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                thumbnail: $0.thumbnail,
                favorited: favorited
            )
        }

        presenter?.didFechCharacters(characters, toQuery: query)
    }

    private func performErrorRequest(with mAPIError: MAPIError, toQuery query: String) {
        let localizableString: LocalizableString
        switch mAPIError {
        case .internet: localizableString = .errorInternet
        default: localizableString = .errorGeneric
        }

        presenter?.didFailOnFechCharacters(withMessage: localizableString.message, toQuery: query)
    }

    func fetchCharacters(withQuery query: String, andPage page: Int) {
        charactersWorer.perform(page: page, nameStartsWith: query) { [weak self] result in
            switch result {
            case .success(let mAPICharacters):
                self?.performSuccessRequest(with: mAPICharacters, toQuery: query)
            case .failure(let error):
                self?.performErrorRequest(with: error, toQuery: query)
            }
        }
    }

    func checkCharactersFavoriteState(_ characters: [Character]) {
        let checkedCharacters: [Character] = characters.map {
            let favorited = CharacterRealm.find(byId: $0.id) != nil
            return Character(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                thumbnail: $0.thumbnail,
                favorited: favorited
            )
        }

        presenter?.didCheckCharactersFavoriteState(checkedCharacters)
    }

    func favoriteCharacter(_ character: Character) {
        FavoriteCharacter.shared.favorite(character)
    }

    func unfavoriteCharacter(withId id: Int) {
        FavoriteCharacter.shared.unfavorite(withId: id)
    }

}
