//
//  MainTableViewPresenter.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit

protocol MainTableViewInput {
    var users: [User]? { get set }
    func usersListChanged()
    func usersNotLoaded(_ error: Error?)
}

protocol MainTableViewOutput: class {
    var router: MainTableViewRouterProtocol { get }
    var interactor: MainTableViewInteractorProtocol { get }
    
    func didViewReady()
    func didUsersLoaded(users: [User]?)
    func didUsersNotLoaded(_ error: Error?)
    func didSelectUser(_ user: User?)
}

class MainTableViewPresenter {
    let router: MainTableViewRouterProtocol
    let interactor: MainTableViewInteractorProtocol
    var viewInput: (UIViewController & MainTableViewInput)?
    
    init(interactor: MainTableViewInteractorProtocol, router: MainTableViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainTableViewPresenter: MainTableViewOutput {
    func didViewReady() {
        self.interactor.loadUsers()
    }
    
    func didUsersLoaded(users: [User]?) {
        self.viewInput?.users = users
        self.viewInput?.usersListChanged()
    }
    
    func didSelectUser(_ user: User?) {
        router.didOpenDetails(with: user)
    }
    
    func didUsersNotLoaded(_ error: Error?) {
        self.viewInput?.users = nil
        self.viewInput?.usersNotLoaded(error)
    }
}
