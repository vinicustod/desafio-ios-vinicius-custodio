//
//  ComicDetailsController.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol ComicDetailsDisplayLogic: class {
    func displayLoadedComic(_ viewModel: ComicDetails.LoadHighestPriceComic.ViewModel)
    func displayErrorWithRetry(_ error: String)
    func displayError(_ error: String)

    func displayImage(_ viewModel: ComicDetails.LoadImage.ViewModel)
}

final class ComicDetailsController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var interactor: ComicDetailsBusinessLogic?
    var router: (ComicDetailsRoutingLogic & ComicDetailsDataPassing)?

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
        let interactor = ComicDetailsInteractor()
        let presenter = ComicDetailsPresenter()
        let worker = ComicDetailsWorker(marvelAPI: MarvelService())
        let router = ComicDetailsRouter()
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

    func setupUI() {
        interactor?.loadComic(ComicDetails.LoadHighestPriceComic.Request())
    }
}

extension ComicDetailsController: ComicDetailsDisplayLogic {
    func displayImage(_ viewModel: ComicDetails.LoadImage.ViewModel) {
        comicImageView.image = viewModel.image
    }

    func displayLoadedComic(_ viewModel: ComicDetails.LoadHighestPriceComic.ViewModel) {
        titleLabel.text = viewModel.displayableComic.title
        descriptionLabel.text = viewModel.displayableComic.description
        priceLabel.text = viewModel.displayableComic.price

        activityIndicator.stopAnimating()
    }

    func displayError(_ error: String) {
        displayAlert(error: error, retry: false)
    }

    func displayErrorWithRetry(_ error: String) {
        displayAlert(error: error, retry: true)
    }

    func displayAlert(error: String, retry: Bool) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)

        if retry {
            let retryAction = UIAlertAction(title: "Tentar novamente", style: UIAlertAction.Style.default) { (_) in
                self.interactor?.loadComic(ComicDetails.LoadHighestPriceComic.Request())
            }

            alertController.addAction(retryAction)
        }

        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (_) in
            self.router?.dismiss()
        }

        alertController.addAction(okAction)

        self.navigationController?.present(alertController, animated: true)
    }

}
