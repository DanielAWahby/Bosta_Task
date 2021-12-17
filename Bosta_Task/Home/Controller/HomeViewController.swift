//
//  ViewController.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var albumViewModels : [AlbumViewModel]?
    
    var userViewModel : UserViewModel?
    
    var albumTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupTableView()
    }
    
    func setupTitleLabel(){
        
    }
    
    func setupTableView(){
        self.view.addSubview(albumTableView)
        albumTableView.register(UserAlbumCell.self, forCellReuseIdentifier: "albumCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as? UserAlbumCell{
            cell.albumViewModel = albumViewModels?[indexPath.row]
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}

