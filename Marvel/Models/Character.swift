//

import UIKit.UIImage

struct Character: Equatable {

    let id: Int
    let name: String
    let description: String
    let thumbnail: UIImage?
    var favorited: Bool

    static func==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id && lhs.favorited == rhs.favorited
    }

    init(id: Int, name: String, description: String, thumbnail: UIImage?, favorited: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.favorited = favorited
    }

    init(characterRealm: CharacterRealm, thumbnail: UIImage?, favorited: Bool) {
        self.init(
            id: characterRealm.id,
            name: characterRealm.name,
            description: characterRealm.desc,
            thumbnail: thumbnail,
            favorited: favorited
        )
    }
}
