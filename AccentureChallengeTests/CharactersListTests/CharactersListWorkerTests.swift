//
//  CharactersListWorkerTests.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright (c) 2020 Vinicius Custodio. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import AccentureChallenge
import XCTest

class CharactersListWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersListWorker!
    var mockService: MockMarvelService!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupCharactersListWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupCharactersListWorker() {
        mockService = MockMarvelService()
        sut = CharactersListWorker(apiService: mockService)
    }

    // MARK: Tests
    func testCharactersLoad() {
        // Given
        let expectation = self.expectation(description: "CharactersLoad")
        mockService.mockType = .characters
        var succeed = false

        // When
        sut.loadCharacters(0) { (result) in
            switch result {
            case .success(_):
                succeed = true
                expectation.fulfill()

            case .failure(_):
                break
            }
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(succeed)
    }

    func testFailCharactersLoad() {
        // Given
        let expectation = self.expectation(description: "CharactersLoad")
        mockService.mockType = .error
        var succeed = true

        // When
        sut.loadCharacters(0) { (result) in
            switch result {
            case .success(_):
                break

            case .failure(_):
                succeed = false
                expectation.fulfill()
            }
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(succeed)
    }
}
