//
//  ComicDetailsInteractor.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

enum ComicDetailsError: Error {
    case noComicFound

    var localizedDescription: String {
        switch self {
        case .noComicFound:
            return "Nenhuma HQ encontrada."
        }
    }
}

protocol ComicDetailsBusinessLogic: class {
    func loadComic(_ request: ComicDetails.LoadHighestPriceComic.Request)
}

protocol ComicDetailsDataStore: class {
    var character: MarvelCharacter? { get set }
}

class ComicDetailsInteractor: ComicDetailsBusinessLogic, ComicDetailsDataStore {

    var presenter: ComicDetailsPresentationLogic?
    var worker: ComicDetailsWorker?
    var character: MarvelCharacter?
    var comics: [Comic] = []

    func loadComic(_ request: ComicDetails.LoadHighestPriceComic.Request) {
        worker?.retrieveComics(characterId: character!.id, offset: comics.count, callback: { [weak self] (result) in
            switch result {
            case .success(let comicsResponse):
                self?.comics.append(contentsOf: comicsResponse.data.results)

                guard comicsResponse.data.total != 0 else {
                    self?.presenter?.didFailLoadComic(ComicDetailsError.noComicFound)
                    return
                }

                if comicsResponse.data.total == self?.comics.count {
                    self?.sortComicsByPrices()

                    if let comic = self?.comics[0] {
                        self?.loadImage(comic)

                        let response = ComicDetails.LoadHighestPriceComic.Response(comic: comic)
                        self?.presenter?.presentComic(response)
                    }

                } else {
                    self?.loadComic(ComicDetails.LoadHighestPriceComic.Request())
                }

            case .failure(let error):
                self?.presenter?.didFailLoadComic(error)

            }
        })
    }

    func sortComicsByPrices() {
        sortPrices()
        sortComics()
    }

    func sortPrices() {
        for var comic in comics {
            comic.prices.sort { (firstPrice, secondPrice) -> Bool in
                return firstPrice.price > secondPrice.price
            }
        }
    }

    func sortComics() {
        comics = comics.sorted(by: { (firstComic, secondComic) -> Bool in
            return firstComic.prices[0].price > secondComic.prices[0].price
        })
    }



    func loadImage(_ comic: Comic) {
        let dataTask = URLSession.shared.dataTask(with: comic.thumbnail.url) { (data, response, error) in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    let response = ComicDetails.LoadImage.Response(image: image!)
                    self.presenter?.presentImage(response)
                }
            }
        }

        dataTask.resume()
    }

}
