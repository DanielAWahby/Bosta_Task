//
//  AlbumViewModel.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation

struct AlbumViewModel {
    private let userId:Int?
    private let id:Int?
    private let title:String?
    
    init(album:Album) {
        self.userId = album.userId
        self.id = album.id
        self.title = album.title
    }
    func getAlbumId() -> Int{
        return id ?? 0
    }
    func getUserId() -> Int{
        return userId ?? 0
    }
    func getAlbumTitle() -> String{
        return title ?? ""
    }
}
