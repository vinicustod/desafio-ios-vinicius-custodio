//
//  CharacterDetailsInteractor.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharacterDetailsBusinessLogic: class {
    func loadCharacter(_ request: CharacterDetails.LoadInfo.Request)
}

protocol CharacterDetailsDataStore: class {
    var character: MarvelCharacter? { get set }
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic, CharacterDetailsDataStore {

    var presenter: CharacterDetailsPresentationLogic?
    var worker: CharacterDetailsWorker?
    var character: MarvelCharacter?

    var dataTask: URLSessionDataTask?
    func loadCharacter(_ request: CharacterDetails.LoadInfo.Request) {
        presenter?.presentCharacter(CharacterDetails.LoadInfo.Response(character: character!))

        dataTask = URLSession.shared.dataTask(with: character!.thumbnail.url, completionHandler: { (data, response, error) in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                let image = UIImage(data: data)!
                DispatchQueue.main.async {
                    self.presenter?.presentCharacterImage(CharacterDetails.LoadImage.Response(image: image))
                }
            }
        })

        dataTask?.resume()
    }

}
