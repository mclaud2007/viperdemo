//
//  MainTableBuilder.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit
import Swinject

final class MainTableBuilder {
    static func build() -> UIViewController {
        let container = Container()
        
        /// Router
        container.register(MainTableViewRouter.self) { _ in
            MainTableViewRouter()
        }.initCompleted { (resolver, router) in
            router.mainTableViewController = resolver.resolve(MainTableViewController.self)
        }
        
        /// Interactor
        container.register(MainTableViewInteractor.self) { _ in
            MainTableViewInteractor()
        }.initCompleted { (reslover, interactor) in
            interactor.interactorOutput = reslover.resolve(MainTableViewOutput.self)
        }
        
        /// PresenterProtocol
        container.register(MainTableViewOutput.self) { r in
            r.resolve(MainTableViewPresenter.self)!
        }
        
        /// Presenter
        container.register(MainTableViewPresenter.self) { r in
            guard let interactor = r.resolve(MainTableViewInteractor.self),
                  let router = r.resolve(MainTableViewRouter.self) else {
                preconditionFailure()
            }
            
            return MainTableViewPresenter(interactor: interactor, router: router)
        }.initCompleted { (resolver, presenter) in
            presenter.viewInput = resolver.resolve(MainTableViewController.self)
        }
        
        /// MainTableViewController
        container.register(MainTableViewController.self) { r in
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewController = mainSB.instantiateViewController(identifier: "MainTableViewController") as? MainTableViewController else {
                preconditionFailure()
            }
            
            return viewController
            
        }.initCompleted { (resolver, viewController) in
            viewController.presenter = resolver.resolve(MainTableViewPresenter.self)
        }
        
        guard let vc = container.resolve(MainTableViewController.self) else {
            preconditionFailure()
        }

        return vc
    }
}
