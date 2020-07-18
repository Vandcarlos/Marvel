//
//  RealmDB.swift
//  Marvel
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 10/07/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
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
