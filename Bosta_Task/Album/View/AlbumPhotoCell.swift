//
//  AlbumPhotoCell.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class AlbumPhotoCell: UICollectionViewCell {
    var photoViewModel : PhotoViewModel! {
        didSet{
            cellImageView.loadImage(from: URL(string: photoViewModel.getThumbnailURL())!)
        }
    }
    var cellImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cellIdentifier = "AlbumPhotoCellIdentifier"
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    func addViews(){
        addSubview(cellImageView)
        cellImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cellImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    }
}

