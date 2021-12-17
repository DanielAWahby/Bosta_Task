//
//  AlbumViewModel.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation

struct AlbumViewModel {
    let userId:Int
    let id:Int
    let title:String
    
    init(album:Album) {
        self.userId = album.userId
        self.id = album.id
        self.name = album.name
    }
}
