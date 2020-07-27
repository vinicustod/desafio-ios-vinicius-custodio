//
//  CharactersRequest.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

class CharactersRequest: APIRequest {
    var method: RequestType
    var path: String
    var parameters: [String : String]

    init(offset: Int) {
        self.method = .GET
        self.path = "/v1/public/characters"
        self.parameters = ["offset": String(offset)]
    }


}
