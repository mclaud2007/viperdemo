//
//  MainList.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var userID: Int?
    var fullname: String?
    var userName: String?
    var email: String?
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        userID <- map["id"]
        fullname <- map["name"]
        userName <- map["username"]
        email <- map["email"]
        phone <- map["phone"]
        website <- map["website"]
        address <- map["address"]
        company <- map["company"]
    }
}

class UserAddress: Mappable {
    var street: String?
    var suite: String?
    var city: String?
    var zipCode: String?
    var geo: UserGeoStruct?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        street <- map["street"]
        suite <- map["suite"]
        city <- map["city"]
        zipCode <- map["zipcode"]
        geo <- map["geo"]
    }
}

class UserGeoStruct: Mappable {
    var lat: Double?
    var lng: Double?
    
    required init(map: Map) { }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

class UserCompany: Mappable {
    var name: String?
    var catchPhrase: String?
    var someBS: String?
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        name <- map["name"]
        catchPhrase <- map["catchPhrase"]
        someBS <- map["bs"]
    }
}
