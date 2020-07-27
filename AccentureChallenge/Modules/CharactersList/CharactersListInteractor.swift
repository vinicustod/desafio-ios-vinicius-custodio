//
//  CharactersListInteractor.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol CharactersListBusinessLogic: class {
    func loadCharacters(_ request: CharactersList.LoadPage.Request) -> Bool
    func didSelectRow(_ index: Int)
}

protocol CharactersListDataStore: class {
    var marvelCharacters: [MarvelCharacter] { get set }
    var selectedCharacter: MarvelCharacter? { get set }
    var currentOffSet: Int { get set }
}

class CharactersListInteractor: CharactersListBusinessLogic, CharactersListDataStore {

    var marvelCharacters: [MarvelCharacter] = []
    var maxItens: Int?
    var selectedCharacter: MarvelCharacter?
    var currentOffSet: Int = 0

    var presenter: CharactersListPresentationLogic?
    var worker: CharactersListWorker?

    /*
     * Pode demorar bastante tempo para personagens famosos, porque tenho que buscar
     * todas as páginas e depois encontrar as mais caras
     */
    func loadCharacters(_ request: CharactersList.LoadPage.Request) -> Bool {
        if maxItens != marvelCharacters.count {
            worker?.loadCharacters(marvelCharacters.count, callback: { (response) in
                switch response {
                case .success(let marvelResponse):
                    let marvelCharacters = marvelResponse.data.results
                    self.marvelCharacters.append(contentsOf: marvelCharacters)
                    self.maxItens = marvelResponse.data.total

                    let response =  CharactersList.LoadPage.Response(marvelCharacters: marvelCharacters)
                    self.presenter?.didLoadCharacters(response)

                case .failure(let error):
                    self.presenter?.didFailLoadCharacters(error)
                }
            })

            return true
        }

        return false

    }

    func didSelectRow(_ index: Int) {
        selectedCharacter = marvelCharacters[index]
        presenter?.presentCharacterDetails()
    }
}
