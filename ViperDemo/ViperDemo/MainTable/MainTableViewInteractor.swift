//
//  MainTableViewInteractor.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit

protocol MainTableViewInteractorProtocol {
    var interactorOutput: MainTableViewOutput? { get set }
    func loadUsers()
}

final class MainTableViewInteractor: MainTableViewInteractorProtocol {
    weak var interactorOutput: MainTableViewOutput?
    let networkService = NetworkService()
    
    func loadUsers() {
        guard let url = Constants.mainDataURL else { return }
        self.networkService.query(with: url) { [weak presenter = self.interactorOutput] userList in
            presenter?.didUsersLoaded(users: userList.users)
        } onError: { [weak presenter = self.interactorOutput] error in
            presenter?.didUsersNotLoaded(error)
        }
    }
}

extension MainTableViewInteractor {
    struct Constants {
        static let mainDataURL: URL? = URL(string: "https://jsonplaceholder.typicode.com/users")
    }
}
