//
//  DataCharacters.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct ResultData<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
