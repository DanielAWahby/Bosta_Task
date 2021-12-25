//
//  ViewController.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit
import CombineMoya
import Moya
import Combine
import Network

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let provider = MoyaProvider<Service>()
    
    var albumViewModels : [AlbumViewModel]?
    
    var userViewModel : UserViewModel?{
        didSet {
            userNameLabel.text = userViewModel?.getName()
            addressLabel.text = userViewModel?.getAddress()
        }
    }
    var observer : AnyCancellable?
    
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var addressLabel:UILabel!
    @IBOutlet weak var albumTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadUser(self)
    }
//
    @IBAction func reloadUser(_ sender: Any) {        
        observer = provider.requestPublisher(.allUsers, callbackQueue: .main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { response in
                if response.statusCode == 200 {
                    do {
                        self.userViewModel = UserViewModel(user: (try JSONDecoder().decode([User].self, from: response.data)).randomElement() ?? User())
                    } catch{
                        print(error.localizedDescription)
                        self.reloadUser(self)
                    }
                }
            })
    }
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

