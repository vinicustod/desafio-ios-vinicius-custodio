//
//  CharacterDetailsModels.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

enum CharacterDetails {

    enum LoadInfo {

        struct Request { }

        struct Response {
            var character: MarvelCharacter
        }

        struct ViewModel {
            struct DisplayableCharacter {
                var name: String
                var description: String
            }

            var displayableCharacter: DisplayableCharacter
        }
    }

    enum LoadImage {
        struct Request {}
        struct Response {
            var image: UIImage
        }
        struct ViewModel {
            var image:UIImage
        }
    }
}
