//
//  File.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation


struct UserViewModel{
    
    private let id:Int?
    private let name:String?
    private let address:UserAddress?
    
    init(user:User){
        self.id = user.id
        self.name = user.name
        self.address = user.address
    }
    
    func getName()->String?{
        return name
    }
    
    func getId()->Int?{
        return id
    }
    func getAddress()->String?{
        return "\(address?.street ?? ""), \(address?.suite ?? ""), \(address?.city ?? "")\n\(address?.zipcode ?? "")"
    }
}
