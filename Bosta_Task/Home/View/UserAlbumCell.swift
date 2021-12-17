//
//  UserAlbumCell.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class UserAlbumCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextLabel()
    }
    
    func setupTextLabel(){
        self.textLabel?.numberOfLines = 1
        self.textLabel?.textColor = .black
    }
}
