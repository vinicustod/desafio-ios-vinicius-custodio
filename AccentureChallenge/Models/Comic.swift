//
//  Comic.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    var prices: [Price]
}
