//
//  AppManager.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import UIKit

final class AppManager {
    static var shared = AppManager()
    
    func start(in window: UIWindow?) {
        window?.makeKeyAndVisible()
        let viewController = MainTableBuilder.build()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
}
