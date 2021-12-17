//
//  UserAlbumCell.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class UserAlbumCell: UITableViewCell {
    
    var albumViewModel : AlbumViewModel! {
        didSet{
            textLabel?.text = albumViewModel.title
        }
    }
    override class func awakeFromNib() {
        self.awakeFromNib()
    }
}
