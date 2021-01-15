//
//  ViperDemoRouterMock.swift
//  ViperDemoTests
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import XCTest
@testable import ViperDemo

class MainTableViewRouterMock: MainTableViewRouterProtocol {
    var mainTableViewController: MainTableViewController?
    
    func didOpenDetails(with user: User?) {
        
    }
}
