//
//  MockMarvelService.swift
//  AccentureChallengeTests
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

@testable import AccentureChallenge
import XCTest

enum MockMarvelServiceType {
    case characters
    case comics
    case error

    var filename: String {
        switch self {
        case .characters:
            return "CharactersResponse"

        case .comics:
            return "ComicsResponse"

        default:
            return ""
        }
    }
}

class MockMarvelService: ServiceInterface {
    var baseURL: URL?

    var mockType: MockMarvelServiceType?

    func send<T>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        switch mockType! {
        case .characters, .comics:
            if let model:T = loadFile(mockType!.filename) {
                callback(.success(model))
            }

        case .error:
            callback(.failure(MarvelServiceError.apiError))

        }
    }

    func loadFile<T: Decodable>(_ filename: String) -> T? {
        do {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.url(forResource: filename, withExtension: "json")
            let jsonData = try Data(contentsOf: path!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let model:T = try decoder.decode(T.self, from: jsonData)
            return model
        } catch {
            return nil
        }
    }
}
