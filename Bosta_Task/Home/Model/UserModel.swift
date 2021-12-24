//
//  UserModel.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation

struct User:Codable{
    var id:Int?
    var name:String?
    var address:UserAddress?
}

struct UserAddress:Codable{
    var street:String?
    var suite:String?
    var city:String?
    var zipcode:String?
}
