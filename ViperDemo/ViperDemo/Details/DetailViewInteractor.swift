//
//  DetailViewInteractor.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit

protocol DetailViewInteractorProtocol {
    var interactorOutput: DetailViewOutput? { get set }
    func loadDetails()
}

final class DetailViewInteractor: DetailViewInteractorProtocol {
    weak var interactorOutput: DetailViewOutput?
    private var detail: User?
    
    init(with user: User?) {
        self.detail = user
    }
    
    func loadDetails() {
        guard let detail = self.detail else {
            self.interactorOutput?.didDetailNotLoaded()
            return
        }
        
        self.interactorOutput?.didDetailLoaded(detail)
    }
}
