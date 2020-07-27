//
//  Service.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ServiceInterface: AnyObject {
    var baseURL: URL? { get set }
    
    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void)
}
