//
//  ComicDetailsRouter.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ComicDetailsRoutingLogic: class {
    func dismiss()
}

protocol ComicDetailsDataPassing: class {
    var dataStore: ComicDetailsDataStore? { get }
}

final class ComicDetailsRouter: ComicDetailsRoutingLogic, ComicDetailsDataPassing {
    
    weak var viewController: ComicDetailsController?
    var dataStore: ComicDetailsDataStore?

    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
