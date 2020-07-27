//
//  ComicDetailsWorker.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

final class ComicDetailsWorker {
    var marvelAPI: ServiceInterface

    init(marvelAPI: ServiceInterface) {
        self.marvelAPI = marvelAPI
    }

    func retrieveComics(characterId: Int, offset: Int, callback: @escaping (Result<MarvelResponse<Comic>, Error>) -> Void) {
        let request = CharacterComicsRequest(characterId: characterId, offset: offset)

        marvelAPI.send(apiRequest: request, callback: callback)
    }
}
