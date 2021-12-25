//
//  UserService.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 24/12/2021.
//

import Foundation
import Combine
import Moya

enum Service {
    case allUsers
    case userAlbums(userid:Int)
    case albumPhotos(albumId:Int)
}

extension Service : TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .allUsers:
            return "/users/"
        case .userAlbums(userid: let id):
            return "/albums/\(id)"
        case .albumPhotos(albumId: let id):
            return "/photos/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .allUsers:
            return .requestPlain
        case .userAlbums(let id):
            return .requestParameters(parameters: ["userId":id], encoding: JSONEncoding.default)
        case .albumPhotos(let id):
            return .requestParameters(parameters: ["albumId":id], encoding: JSONEncoding.default)
        
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
