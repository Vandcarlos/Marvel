//

import RealmSwift

class CharacterRealm: Object {

    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""

}

extension CharacterRealm {

    static func create(id: Int, name: String, desc: String) {
        let character = CharacterRealm()
        character.id = id
        character.name = name
        character.desc = desc

        // swiftlint:disable:next force_try
        let realm = try! Realm()

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.add(character)
        }
    }

    static func find(byId id: Int) -> CharacterRealm? {
        // swiftlint:disable:next force_try
        return try! Realm()
            .objects(CharacterRealm.self)
            .filter("id == \(id)")
            .first
    }

    static func getAll(completion: @escaping ([CharacterRealm]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                // swiftlint:disable:next force_try
                let characters: [CharacterRealm] = try! Realm().objects(CharacterRealm.self)
                    .sorted(byKeyPath: "name")
                    .compactMap { $0 }

                completion(characters)
            }
        }
    }

    static func delete(withId id: Int) {
        // swiftlint:disable:next force_try
        let character = try! Realm()
            .objects(CharacterRealm.self)
            .filter("id == \(id)")

        // swiftlint:disable:next force_try
        let realm = try! Realm()

        // swiftlint:disable:next force_try
        try! realm.write {
            realm.delete(character)
        }
    }

    static func fetch(
        withNameStartsWith name: String,
        andOptions options: DBFetchOptions,
        completion: @escaping ([CharacterRealm]) -> Void
    ) {
        CharacterRealm.getAll { _charactersRealm in
            var charactersRealm = _charactersRealm

            if !name.isEmpty {
                charactersRealm = charactersRealm.filter { $0.name.starts(with: name) }
            }

            guard options.startIndex < charactersRealm.count else {
                completion([])
                return
            }

            let end: Int

            if options.splitBatch {
                end = min(options.endIndex, charactersRealm.count)
            } else {
                end = charactersRealm.count
            }

            charactersRealm = Array(charactersRealm[options.startIndex..<end])

            completion(charactersRealm)
        }
    }

}
