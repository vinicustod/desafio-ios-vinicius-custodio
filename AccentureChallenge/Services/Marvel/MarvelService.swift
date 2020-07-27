//
//  MarvelService.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

enum MarvelServiceError: Error {
    case parsingError
    case apiError
}

class MarvelService: ServiceInterface {
    var baseURL: URL? = URL(string: "https://gateway.marvel.com:443")

    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) {
        let request = apiRequest.request(with: self.baseURL!)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in            
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {

                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        callback(.failure(MarvelServiceError.parsingError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    callback(.failure(MarvelServiceError.apiError))
                }
            }

        }

        task.resume()
    }
}
