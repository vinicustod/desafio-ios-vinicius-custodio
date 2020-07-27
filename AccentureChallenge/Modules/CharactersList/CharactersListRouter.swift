//
//  CharactersListRouter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharactersListRoutingLogic: class {
    func routeToCharacterDetails()
}

protocol CharactersListDataPassing: class {
    var dataStore: CharactersListDataStore? { get }
}

final class CharactersListRouter: CharactersListRoutingLogic, CharactersListDataPassing {
    
    weak var viewController: CharactersListController?
    var dataStore: CharactersListDataStore?

    func routeToCharacterDetails() {
        let characterDetailsController = UIStoryboard(name: CharacterDetailsController.identifier, bundle: nil).instantiateViewController(withIdentifier: CharacterDetailsController.identifier) as! CharacterDetailsController

        var destinationDataStore = characterDetailsController.router!.dataStore!

        passSelectedRepository(source: dataStore!,
                               destination: &destinationDataStore)

        viewController?.navigationController?.pushViewController(characterDetailsController, animated: true)
    }

    func passSelectedRepository(source: CharactersListDataStore,
                                destination: inout CharacterDetailsDataStore) {
        destination.character = source.selectedCharacter
    }
    
}
