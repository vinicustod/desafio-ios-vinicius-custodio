//
//  CharactersResponse.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: ResultData<T>
}
