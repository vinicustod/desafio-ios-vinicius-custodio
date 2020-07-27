//
//  CharacterDetailsRouter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharacterDetailsRoutingLogic: class {
    func routeToComic()
}

protocol CharacterDetailsDataPassing: class {
    var dataStore: CharacterDetailsDataStore? { get }
}

final class CharacterDetailsRouter: CharacterDetailsRoutingLogic, CharacterDetailsDataPassing {

    weak var viewController: CharacterDetailsController?
    var dataStore: CharacterDetailsDataStore?

    func routeToComic() {
        let comicController = UIStoryboard(name: ComicDetailsController.identifier, bundle: nil).instantiateViewController(withIdentifier: ComicDetailsController.identifier) as! ComicDetailsController

        var destinationDS = comicController.router!.dataStore!
        passCharacter(sourceDS: dataStore!, destinationDS: &destinationDS)

        viewController?.navigationController?.pushViewController(comicController, animated: true)
    }

    func passCharacter(sourceDS: CharacterDetailsDataStore, destinationDS: inout ComicDetailsDataStore) {
        destinationDS.character = sourceDS.character
    }
}
