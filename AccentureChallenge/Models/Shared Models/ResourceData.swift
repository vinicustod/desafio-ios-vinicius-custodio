//
//  ResourceData.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct ResourceData: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: URL
    let items: [ResourceItem]
}
