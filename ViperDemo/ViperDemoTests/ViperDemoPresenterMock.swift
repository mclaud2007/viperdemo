//
//  ViperDemoPresenterMock.swift
//  ViperDemoTests
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import XCTest
@testable import ViperDemo

let userMock: [String: Any] = ["id": 1,
        "name": "Leanne Graham",
        "username": "Bret",
        "email": "Sincere@april.biz",
        "address": [
          "street": "Kulas Light",
          "suite": "Apt. 556",
          "city": "Gwenborough",
          "zipcode": "92998-3874",
          "geo": [
            "lat": "-37.3159",
            "lng": "81.1496"
          ]
        ],
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": [
          "name": "Romaguera-Crona",
          "catchPhrase": "Multi-layered client-server neural-net",
          "bs": "harness real-time e-markets"]]

class MainTableViewPresenterMock: MainTableViewOutput {
    var router: MainTableViewRouterProtocol
    var interactor: MainTableViewInteractorProtocol
    var viewInput: MainTableViewInput?
    
    init(interactor: MainTableViewInteractorProtocol, router: MainTableViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func didViewReady() {
        interactor.loadUsers()
    }
    
    func didUsersLoaded(users: [User]?) {
        guard users != nil, let mockUser = User(JSON: userMock) else {
            XCTFail()
            return
        }
        
        self.viewInput?.users = [mockUser]
        self.viewInput?.usersListChanged()
    }
    
    func didUsersNotLoaded(_ error: Error?) {
        self.viewInput?.usersNotLoaded(error)
    }
    
    func didSelectUser(_ user: User?) { }
}
