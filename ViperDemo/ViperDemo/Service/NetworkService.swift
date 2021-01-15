//
//  NetworkService.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import Alamofire

final class NetworkService {
    func query(with url: URL, onDone: @escaping ((UserList) -> Void), onError: @escaping ((Error?) -> Void)) {
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case let .success(data):
                if let json = data as? [[String: Any]] {
                    let users = UserList(from: json)
                    onDone(users)
                } else {
                    onError(nil)
                }
            case let .failure(error):
                onError(error)
            }
        }
    }
}
