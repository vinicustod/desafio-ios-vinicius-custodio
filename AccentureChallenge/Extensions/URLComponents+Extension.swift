//
//  URLRequest+Extension.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

extension URLComponents {
    mutating func addMarvelAuthentication() {
        let timestamp = Int(Date().timeIntervalSince1970)
        let apiKey = MarvelService.apiKey
        let privateKey = MarvelService.privateKey
        
        if apiKey?.isEmpty ?? true || privateKey?.isEmpty ?? true {
            fatalError("Não é possível executar o projeto, preencha a ApiKey e a PrivateKey no Item MarvelAuth no Info.plist")
        }

        let hash = "\(timestamp)\(privateKey!)\(apiKey!)".md5

        queryItems?.append(contentsOf: [URLQueryItem(name: "ts", value: String(timestamp)),
                                        URLQueryItem(name: "apikey", value: apiKey!),
                                        URLQueryItem(name: "hash", value: hash)])
        
    }
}
