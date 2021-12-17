//
//  ProfileView.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class ProfileView: UIView {
    
    var headerLabel:UILabel!
    var nameLabel:UILabel!
    var addressLabel:UILabel!
    var userViewModel:UserViewModel!{
        didSet{
            nameLabel.text = userViewModel.getName()
            addressLabel.text = userViewModel.getAddress()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderLabel()
        setupUserLabels()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserLabels(){
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 1
        addressLabel.font = UIFont.systemFont(ofSize: 12)
        addressLabel.numberOfLines = 0
    }
    func setupHeaderLabel(){
        headerLabel.numberOfLines = 1
        headerLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(20)
    }
   
    func addSubviews(){
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 0).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 40).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        
        addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 20).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }

}
