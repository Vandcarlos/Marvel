//

import MarvelAPI

class ListFavoriteCharactersInteractor: ListFavoriteCharactersInteractorToPresenter {

    var presenter: ListFavoriteCharactersPresenterToInteractor?

    var pageSize = 10

    func fetchCharacters(withQuery query: String, andPage page: Int) {
        let options = DBFetchOptions(page: page, size: pageSize, splitBatch: true)

        CharacterRealm.fetch(withNameStartsWith: query, andOptions: options) { [weak self] charactersRealm in
            guard let self = self else { return }

            let characters: [Character] = charactersRealm.map {
                let thumbnail = CharacterThumbnailStore.shared.load(withId: $0.id)
                return Character(characterRealm: $0, thumbnail: thumbnail, favorited: true)
            }
            self.presenter?.didFechCharacters(characters, toQuery: query)
        }
    }

    func refetchCharacters(withQuery query: String, andPage page: Int) {
        let options = DBFetchOptions(page: page, size: pageSize, splitBatch: false)

        CharacterRealm.fetch(withNameStartsWith: query, andOptions: options) { [weak self] charactersRealm in
            guard let self = self else { return }

            let characters: [Character] = charactersRealm.map {
                let thumbnail = CharacterThumbnailStore.shared.load(withId: $0.id)
                return Character(characterRealm: $0, thumbnail: thumbnail, favorited: true)
            }
            self.presenter?.didRefetchCharacters(characters)
        }
    }

    func unfavoriteCharacter(withId id: Int) {
        FavoriteCharacter.shared.unfavorite(withId: id)
    }

}
