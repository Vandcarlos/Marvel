//
//  DBFetchOptions.swift
//  Marvel
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/07/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

struct DBFetchOptions {

    let page: Int
    let size: Int
    let splitBatch: Bool

    init (page: Int, size: Int, splitBatch: Bool) {
        self.page = max(0, page)
        self.size = max(0, size)
        self.splitBatch = splitBatch
    }

    var startIndex: Int {
        splitBatch ? page * size : 0
    }

    var endIndex: Int {
        page * size + size
    }

}
