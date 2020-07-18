//
//  URL+.swift
//  Marvel
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 10/07/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

extension URL {

    static var documentsPath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}
