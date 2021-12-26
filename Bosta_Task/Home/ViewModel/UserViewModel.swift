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
        let components = user.name?.capitalized.components(separatedBy: " ")
        let firstNameInitial = String(components?[0].first ?? "_")
        let lastNameInitial = String(components?[components!.count - 1].first ?? "_")
        let initials = "\(firstNameInitial)\(lastNameInitial)"
        UserDefaults.standard.set(initials,forKey: "savedIntitials")
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
