//
//  CharacterDetailsController.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharacterDetailsDisplayLogic: class {
    func displayCharacterDetails(_ viewModel: CharacterDetails.LoadInfo.ViewModel)
    func displayCharacterAvatar(_ viewModel: CharacterDetails.LoadImage.ViewModel)

}

final class CharacterDetailsController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!

    var interactor: CharacterDetailsBusinessLogic?
    var router: (CharacterDetailsRoutingLogic & CharacterDetailsDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter()
        let worker = CharacterDetailsWorker()
        let router = CharacterDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        interactor?.loadCharacter(CharacterDetails.LoadInfo.Request())
    }

    @IBAction func didPressedButton(_ sender: Any) {
        router?.routeToComic()
    }

}

extension CharacterDetailsController: CharacterDetailsDisplayLogic {
    func displayCharacterDetails(_ viewModel: CharacterDetails.LoadInfo.ViewModel) {
        characterNameLabel.text = viewModel.displayableCharacter.name
        characterDescriptionLabel.text = viewModel.displayableCharacter.description
    }

    func displayCharacterAvatar(_ viewModel: CharacterDetails.LoadImage.ViewModel) {
        avatarImageView.image = viewModel.image
    }
}
