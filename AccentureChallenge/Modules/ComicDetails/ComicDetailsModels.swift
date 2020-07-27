//
//  ComicDetailsModels.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

enum ComicDetails {

  enum LoadHighestPriceComic {

    struct Request {

    }

    struct Response {
        var comic: Comic
    }

    struct ViewModel {
        struct DisplayableComic {
            var title: String
            var description: String?
            var price: String
        }

        var displayableComic: DisplayableComic
    }
  }

    enum LoadImage {
        struct Request { }

        struct Response {
            var image: UIImage
        }

        struct ViewModel {
            var image: UIImage
        }
    }
}
