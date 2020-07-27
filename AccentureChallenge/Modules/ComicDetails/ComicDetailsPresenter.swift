//
//  ComicDetailsPresenter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ComicDetailsPresentationLogic: class {
    func presentImage(_ response: ComicDetails.LoadImage.Response)

    func presentComic(_ response: ComicDetails.LoadHighestPriceComic.Response)
    func didFailLoadComic(_ error: Error)
}

final class ComicDetailsPresenter: ComicDetailsPresentationLogic {

    weak var viewController: ComicDetailsDisplayLogic?

    func presentComic(_ response: ComicDetails.LoadHighestPriceComic.Response) {
        let price = response.comic.prices[0]

        let displaybleComic = ComicDetails.LoadHighestPriceComic.ViewModel.DisplayableComic(title: response.comic.title,
                                                                                            description: response.comic.description,
                                                                                            price: String(price.price))
        viewController?.displayLoadedComic(ComicDetails.LoadHighestPriceComic.ViewModel(displayableComic: displaybleComic))
    }


    func presentImage(_ response: ComicDetails.LoadImage.Response) {
        let viewModel = ComicDetails.LoadImage.ViewModel(image: response.image)

        viewController?.displayImage(viewModel)
    }

    func didFailLoadComic(_ error: Error) {
        if let error = error as? MarvelServiceError {
            viewController?.displayErrorWithRetry(error.localizedDescription)

        } else if let error = error as? ComicDetailsError {
            viewController?.displayError(error.localizedDescription)
        }
    }

}
