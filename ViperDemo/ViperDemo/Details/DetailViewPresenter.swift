//
//  DetailViewPresenter.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit

protocol DetailViewInput {
    func detailLoaded(_ detail: User)
    func detailNotLoaded()
}

protocol DetailViewOutput: class {
    var router: DetailViewRouterProtocol { get }
    var interactor: DetailViewInteractorProtocol { get }
    
    func didViewReady()
    func didDetailLoaded(_ detail: User)
    func didDetailNotLoaded()
    func didGoBackClicked()
}

class DetailViewPresenter {
    let router: DetailViewRouterProtocol
    let interactor: DetailViewInteractorProtocol
    var viewInput: (UIViewController & DetailViewInput)?
    
    init(interactor: DetailViewInteractorProtocol, router: DetailViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DetailViewPresenter: DetailViewOutput {
    func didViewReady() {
        self.interactor.loadDetails()
    }
    
    func didDetailLoaded(_ detail: User) {
        self.viewInput?.detailLoaded(detail)
    }
    
    func didDetailNotLoaded() {
        self.viewInput?.detailNotLoaded()
    }
    
    func didGoBackClicked() {
        router.goBack()
    }
}
