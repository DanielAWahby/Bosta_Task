//
//  AlbumViewModel.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import Foundation

struct PhotoViewModel{
    private let albumId:Int?
    private let id:Int?
    private let title:String?
    private let url:String?
    private let thumbnailUrl:String?
    init(album:Album) {
        self.userId = album.userId
        self.id = album.id
        self.title = album.title
    }
    func getAlbumId() -> Int{
        return albumId ?? 0
    }
    func getPhotoId() -> Int{
        return id ?? 0
    }
    func getPhotoTitle() -> String{
        return title ?? ""
    }
    func getURL() -> String{
        return url
    }
    func getThumbnailURL() -> String{
        return thumbnailUrl
    }
}
