//
//  CharacterDetailsPresenter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharacterDetailsPresentationLogic: class {
    func presentCharacter(_ response: CharacterDetails.LoadInfo.Response)
    func presentCharacterImage(_ response: CharacterDetails.LoadImage.Response)
}

final class CharacterDetailsPresenter: CharacterDetailsPresentationLogic {

  weak var viewController: CharacterDetailsDisplayLogic?

    func presentCharacter(_ response: CharacterDetails.LoadInfo.Response) {
        let character = CharacterDetails.LoadInfo.ViewModel.DisplayableCharacter(name: response.character.name, description: response.character.description)

        viewController?.displayCharacterDetails(CharacterDetails.LoadInfo.ViewModel(displayableCharacter: character))
    }

    func presentCharacterImage(_ response: CharacterDetails.LoadImage.Response) {
        let viewModel = CharacterDetails.LoadImage.ViewModel(image: response.image)

        viewController?.displayCharacterAvatar(viewModel)
    }

}
