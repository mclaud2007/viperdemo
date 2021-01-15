//
//  MainTableViewRouter.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation

protocol MainTableViewRouterProtocol: class {
    var mainTableViewController: MainTableViewController? { get set }
    
    func didOpenDetails(with user: User?)
}

class MainTableViewRouter: MainTableViewRouterProtocol {
    weak var mainTableViewController: MainTableViewController?
    
    func didOpenDetails(with user: User?) {    
        let detailScreen = DetailViewBuilder.build(with: user)
        mainTableViewController?.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
