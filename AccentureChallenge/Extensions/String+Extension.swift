//
//  String+Extension.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!)
            .prefix(Insecure.MD5.byteCount)
            .map {
                String(format: "%02hhx", $0)
            }.joined()
    }
}
