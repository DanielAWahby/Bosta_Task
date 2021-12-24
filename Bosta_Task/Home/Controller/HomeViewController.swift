//
//  ViewController.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var albumViewModels : [AlbumViewModel]?
    
    var userViewModel : UserViewModel?{
        didSet{
            userNameLabel.text = userViewModel?.getName()
            addressLabel.text = userViewModel?.getAddress()
        }
    }
    
//    var profileView = ProfileView()
    
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var addressLabel:UILabel!
    @IBOutlet weak var albumTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupProfileView()
        setupTableView()
        
    }
    
//    func setupProfileView(){
    
//        profileView = ProfileView(viewModel: )
//
////        self.view.addSubview(profileView)
////        profileView.translatesAutoresizingMaskIntoConstraints = false
////        profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
////        profileView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        profileView.backgroundColor = .systemOrange
//        profileView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 3)
//
//    }
    
    func setupTableView(){
        albumTableView.register(UserAlbumCell.self, forCellReuseIdentifier: "albumCell")
        albumTableView.delegate = self
        albumTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModels?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as? UserAlbumCell{
//            cell.albumViewModel = albumViewModels?[indexPath.row]
            cell.textLabel?.text = "example text"
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}

