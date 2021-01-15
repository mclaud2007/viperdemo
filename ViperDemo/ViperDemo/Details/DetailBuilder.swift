//
//  DetailBuilder.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit
import Swinject

final class DetailViewBuilder {
    static func build(with user: User?) -> UIViewController {
        let container = Container()
        
        /// Router
        container.register(DetailViewRouter.self) { _ in
            DetailViewRouter()
        }.initCompleted { (resolver, router) in
            router.detailViewController = resolver.resolve(DetailViewController.self)
        }
        
        /// Interactor
        container.register(DetailViewInteractor.self) { _ in
            DetailViewInteractor(with: user)
        }.initCompleted { (resolver, interactor) in
            interactor.interactorOutput = resolver.resolve(DetailViewOutput.self)
        }
        
        /// PresenterProtocol
        container.register(DetailViewOutput.self) { r in
            r.resolve(DetailViewPresenter.self)!
        }
        
        /// Presenter
        container.register(DetailViewPresenter.self) { r in
            guard let interactor = r.resolve(DetailViewInteractor.self),
                  let router = r.resolve(DetailViewRouter.self) else {
                preconditionFailure()
            }
            
            return DetailViewPresenter(interactor: interactor, router: router)
        }.initCompleted { (resolver, presenter) in
            presenter.viewInput = resolver.resolve(DetailViewController.self)
        }
        
        /// DetailViewController
        container.register(DetailViewController.self) { r in
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewController = mainSB.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                preconditionFailure()
            }
            
            return viewController
        }.initCompleted { (resolver, viewController) in
            viewController.presenter = resolver.resolve(DetailViewPresenter.self)
            viewController.router = resolver.resolve(DetailViewRouter.self)
        }
        
        guard let vc = container.resolve(DetailViewController.self) else {
            preconditionFailure()
        }
        
        return vc
    }
}
