//
//  CharactersListWorker.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

final class CharactersListWorker {
    let marvelAPI:ServiceInterface
    
    init(apiService: ServiceInterface) {
        self.marvelAPI = apiService
    }

    func loadCharacters(_ offset: Int, callback: @escaping (Result<MarvelResponse<MarvelCharacter>, Error>) -> Void) {
        let request = CharactersRequest(offset: offset)

        marvelAPI.send(apiRequest: request, callback: callback)
    }

}
