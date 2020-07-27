//
//  MarvelCharacter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct MarvelCharacter: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let comics: ResourceData
//    let series: [ResourceData]
//    let stories: [ResourceData]
}
