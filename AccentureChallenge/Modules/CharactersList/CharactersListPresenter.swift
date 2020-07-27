//
//  CharactersListPresenter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol CharactersListPresentationLogic: class {
    func didLoadCharacters(_ response: CharactersList.LoadPage.Response)
    func didFailLoadCharacters(_ error: Error)

    func presentCharacterDetails()
}

final class CharactersListPresenter: CharactersListPresentationLogic {
    
    weak var viewController: CharactersListDisplayLogic?

    func didLoadCharacters(_ response: CharactersList.LoadPage.Response) {
        let displayableCharacters = response.marvelCharacters.map { (character) -> CharactersList.LoadPage.ViewModel.DisplayableCharacter in
            return CharactersList.LoadPage.ViewModel.DisplayableCharacter(avatarURL: character.thumbnail.url, name: character.name)
        }

        let viewModel = CharactersList.LoadPage.ViewModel(displayableCharacters: displayableCharacters)

        viewController?.displayCharacters(viewModel)
    }

    func didFailLoadCharacters(_ error: Error) {
        if let error = error as? MarvelServiceError {
            viewController?.displayError(error.localizedDescription)
        }
    }

    func presentCharacterDetails() {
        viewController?.displayCharacterDetails()
    }
}
