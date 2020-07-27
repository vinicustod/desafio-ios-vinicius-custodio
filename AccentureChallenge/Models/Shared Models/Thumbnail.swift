//
//  Thumbnail.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
    let fileExtension: String

    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path
    }

    var url: URL {
        return URL(string: "\(path).\(fileExtension)")!
    }
}
