//
//  ViperDemoViewControllerMock.swift
//  ViperDemoTests
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import XCTest
@testable import ViperDemo


class MainViewControllerMock: MainTableViewInput {
    var users: [User]?
    var presenter: MainTableViewOutput
    var exception: XCTestExpectation
    
    init(presenter: MainTableViewOutput, exception: XCTestExpectation) {
        self.presenter = presenter
        self.exception = exception
    }
    
    func didViewLoad() {
        presenter.didViewReady()
    }
    
    func usersListChanged() {
        if users?.first?.userName == "Bret" {
            exception.fulfill()
        } else {
            XCTFail()
        }
    }
    
    func usersNotLoaded(_ error: Error?) {
        XCTFail()
    }
}
