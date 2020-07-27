//
//  CharacterComics.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

class CharacterComicsRequest: APIRequest {
    var method: RequestType
    var path: String
    var parameters: [String : String]

    init(characterId: Int, offset: Int) {
        self.method = .GET
        self.path = "/v1/public/characters/\(characterId)/comics"
        self.parameters = ["offset": String(offset), "limit": String(100)]
    }

}
