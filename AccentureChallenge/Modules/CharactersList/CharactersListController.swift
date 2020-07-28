//
//  CharactersListController.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 25/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol CharactersListDisplayLogic: class {
    func displayCharacters(_ viewModel: CharactersList.LoadPage.ViewModel)
    func displayError(_ error: String)

    func displayCharacterDetails()
}

final class CharactersListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.showsVerticalScrollIndicator = false
        }
    }

    var interactor: CharactersListBusinessLogic?
    var router: (CharactersListRoutingLogic & CharactersListDataPassing)?
    
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
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter()
        let worker = CharactersListWorker(apiService: MarvelService())
        let router = CharactersListRouter()
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

        setupUI()
    }

    var isLoading: Bool = false {
        didSet {
            // TODO: Improvement, use tableView.reloadRows()
            self.tableView.reloadData()
        }
    }
    var displayableCharacters: [CharactersList.LoadPage.ViewModel.DisplayableCharacter] = []
    func setupUI() {
        isLoading = interactor?.loadCharacters(CharactersList.LoadPage.Request()) ?? false
    }
}

extension CharactersListController: CharactersListDisplayLogic {
    func displayError(_ error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)

        let retryAction = UIAlertAction(title: "Tentar novamente", style: UIAlertAction.Style.default) { (_) in
            self.isLoading = self.interactor?.loadCharacters(CharactersList.LoadPage.Request()) ?? false
        }


        alertController.addAction(retryAction)

        self.navigationController?.present(alertController, animated: true)
    }

    func displayCharacters(_ viewModel: CharactersList.LoadPage.ViewModel) {
        displayableCharacters.append(contentsOf: viewModel.displayableCharacters)
        isLoading = false
    }

    func displayCharacterDetails() {
        router?.routeToCharacterDetails()
    }

    
}

extension CharactersListController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return displayableCharacters.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier) as? CharacterCell else {
                return UITableViewCell()
            }

            cell.character = displayableCharacters[indexPath.row]

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier) as? LoadingCell else {
                return UITableViewCell()
            }

            cell.setLoading(isLoading)

            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        interactor?.didSelectRow(indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 1.2) && !isLoading {
            isLoading = interactor?.loadCharacters(CharactersList.LoadPage.Request()) ?? false
        }
    }


}
