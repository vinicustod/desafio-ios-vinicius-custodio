//
//  Resource.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct ResourceItem: Decodable {
    let resourceURI: URL
    let name: String
    let type: String?
}
