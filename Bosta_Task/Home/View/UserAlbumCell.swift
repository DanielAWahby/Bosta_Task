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
            textLabel?.text = albumViewModel.getAlbumTitle()
        }
    }
    override class func awakeFromNib() {
        self.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        let selectionBackground = UIView()
        selectionBackground.backgroundColor = UIColor(named: "AccentColor")
        let deSelectionBackground = UIView()
        deSelectionBackground.backgroundColor = .white
        self.backgroundView = selected ? selectionBackground : deSelectionBackground
        self.textLabel?.textColor = selected ? .white : .black
    }
}
