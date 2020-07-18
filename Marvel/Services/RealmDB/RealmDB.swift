//

import RealmSwift

final class RealmDB {

    private init() {}

    let shared = RealmDB()

    static func configure() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { _, _ in }
        )

        Realm.Configuration.defaultConfiguration = config

        let realmDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint("Realm file directory: \(realmDirectory)")

        // swiftlint:disable:next force_try
        _ = try! Realm()
    }

}
