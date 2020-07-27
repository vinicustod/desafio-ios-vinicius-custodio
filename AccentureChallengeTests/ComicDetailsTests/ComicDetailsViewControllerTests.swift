//
//  ComicDetailsViewControllerTests.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 27/07/20.
//  Copyright (c) 2020 Vinicius Custodio. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import AccentureChallenge
import XCTest

class ComicDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ComicDetailsController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupComicDetailsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupComicDetailsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: ComicDetailsController.identifier, bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: ComicDetailsController.identifier) as? ComicDetailsController
        sut.router?.dataStore?.character = MarvelUtility.marvelCharacter
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testLoadComic() {
        // Given
        let mock = MockComicDetailsBusinessLogic()
        sut.interactor = mock

        // When
        loadView()

        // Then
        XCTAssertTrue(mock.didLoadComic)
    }

    func testDisplayComic() {
        // Given
        let displayableComic = ComicDetails.LoadHighestPriceComic.ViewModel.DisplayableComic(title: "Title", description: "Description", price: "9.99")
        let viewModel = ComicDetails.LoadHighestPriceComic.ViewModel(displayableComic: displayableComic)

        // When
        loadView()
        sut.displayLoadedComic(viewModel)

        // Then
        XCTAssertEqual(sut.descriptionLabel.text, displayableComic.description)
    }
}

class MockComicDetailsBusinessLogic: ComicDetailsBusinessLogic {
    var didLoadComic = false

    func loadComic(_ request: ComicDetails.LoadHighestPriceComic.Request) {
        didLoadComic = true
    }
}
