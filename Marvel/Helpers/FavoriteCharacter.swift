//

import Foundation

final class FavoriteCharacter {

    private init() {}
    static let shared = FavoriteCharacter()

    func favorite(_ character: Character) {
        CharacterRealm.create(id: character.id, name: character.name, desc: character.description)

        if let thumbnail = character.thumbnail {
            CharacterThumbnailStore.shared.save(thumbnail, withId: character.id)
        }
    }

    func unfavorite(withId id: Int) {
        CharacterRealm.delete(withId: id)
        CharacterThumbnailStore.shared.delete(withId: id)
    }

}
