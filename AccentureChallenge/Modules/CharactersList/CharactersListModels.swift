//
//  CharactersListModels.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

enum CharactersList {
    
    enum LoadPage {
        
        struct Request { }
        
        struct Response {
            let marvelCharacters: [MarvelCharacter]
        }
        
        struct ViewModel {
            struct DisplayableCharacter {
                let avatarURL: URL
                let name: String
            }

            let displayableCharacters: [DisplayableCharacter]
        }
    }
}
