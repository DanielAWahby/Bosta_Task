//
//  File.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation


struct UserViewModel{
    
    let id:Int
    let name:String
    let address:UserAddress
    let phone:String?
    let website:String?
    let company:UserCompany?
    
    init(user:User){
        self.id = user.id
        self.name = user.name
        self.address = user.address
        self.phone = user.phone
        self.website = user.website
        self.company = user.company
    }
}
