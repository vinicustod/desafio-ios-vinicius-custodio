//
//  MarvelUtility.swift
//  AccentureChallengeTests
//
//  Created by Vinicius Custodio on 27/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

@testable import AccentureChallenge
import Foundation

/*
 * Objetos para utilizar nos testes
 */
class MarvelUtility {
    static let thumbnail = Thumbnail(path: path, fileExtension: fileExtension)
    static let marvelCharacter = MarvelCharacter(id: 1, name: "Name", description: "Description", thumbnail: MarvelUtility.thumbnail, comics: ResourceData(available: 0, returned: 0, collectionURI: collectionURL, items: []))

    static let price = Price(price: 9.99, type: "type")
    static let comic = Comic(id: 1, title: "Title", description: "Description", thumbnail: MarvelUtility.thumbnail, prices: [price])
}
