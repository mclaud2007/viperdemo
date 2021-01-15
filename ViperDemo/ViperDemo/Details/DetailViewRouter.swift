//
//  DetailViewRouter.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation

protocol DetailViewRouterProtocol: class {
    var detailViewController: DetailViewController? { get set }
    
    func goBack()
}

class DetailViewRouter: DetailViewRouterProtocol {
    weak var detailViewController: DetailViewController?
    
    func goBack() {
        detailViewController?.navigationController?.popViewController(animated: true)
    }
}
