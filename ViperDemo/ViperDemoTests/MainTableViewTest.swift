//
//  ViperDemoTests.swift
//  ViperDemoTests
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import XCTest
@testable import ViperDemo

class ViperDemoTests: XCTestCase {
    var tableViewMock: MainViewControllerMock!
    var interactor: MainTableViewInteractor!
    var exception = XCTestExpectation(description: "tableViewLoaded")
    
    override func setUpWithError() throws {
        let router = MainTableViewRouterMock()
        interactor = MainTableViewInteractor()
        let presenter = MainTableViewPresenterMock(interactor: interactor, router: router)
        interactor.interactorOutput = presenter
        tableViewMock = MainViewControllerMock(presenter: presenter, exception: self.exception)
        presenter.viewInput = tableViewMock
    }

    override func tearDownWithError() throws {
        tableViewMock = nil
        interactor = nil
    }

    func testMainTableView() throws {
        tableViewMock.didViewLoad()
        wait(for: [self.exception], timeout: 10)
    }
    
    func testMainTableInteractor() throws {
        interactor.loadUsers()
        wait(for: [self.exception], timeout: 10)
    }
}
