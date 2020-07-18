//
//  LocalizableString.swift
//  Marvel
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 10/07/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

enum LocalizableString: String {

    // MARK: Actions

    case tryAgain = "action.try_again"
    case cancel = "action.cancel"

    // MARK: Errors

    case errorGeneric = "error.generic"
    case errorInternet = "error.internet"
    case errorOnFetchCharacters = "error.on_fetch_characters"

    case list = "Lista"
    case favorites = "Favoritos"
    case details = "Detalhes"
    case notHasCharactersToShow = "not_has_characters_to_show"

    var message: String {
        NSLocalizedString(self.rawValue, comment: "String to \(self.rawValue)")
    }

}
