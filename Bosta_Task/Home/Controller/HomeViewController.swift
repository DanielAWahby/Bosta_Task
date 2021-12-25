//
//  ViewController.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit
import Combine
import CombineMoya
import Moya


class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let provider = MoyaProvider<Service>()
    
    var albumViewModels = [AlbumViewModel]() {
        didSet{
            self.albumTableView.reloadData()
        }
    }
    
    var userViewModel : UserViewModel?{
        didSet {
            userNameLabel.text = userViewModel?.getName()
            addressLabel.text = userViewModel?.getAddress()
            
        }
    }
    var observer : AnyCancellable?
    @Published var isFetchingAlbums : Bool = false
    
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var addressLabel:UILabel!
    @IBOutlet weak var albumTableView : UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadUser(self)
    }
    //
    @IBAction func reloadUser(_ sender: Any) {
        activityIndicator.startAnimating()
        observer = provider.requestPublisher(.allUsers, callbackQueue: .main)
          .sink { completion in
              switch completion {
              case let .failure(error):
                  print(error)
                  self.activityIndicator.stopAnimating()
              case let.finished:
                  return
              }
              
            } receiveValue: { response in
                if response.statusCode == 200 {
                    do {
                        let fetchedUser =  (try JSONDecoder().decode([User].self, from: response.data)).randomElement() ?? User()
                        if fetchedUser.id == self.userViewModel?.getId() {
                            self.reloadUser(self)
                        }
                        self.userViewModel = UserViewModel(user:fetchedUser)
                        self.getAlbums(fetchedUser.id ?? 0)
                    } catch{
                        print(error.localizedDescription)
                        self.reloadUser(self)
                    }
                }
            }

    }
    func getAlbums(_ id:Int){
        provider.requestPublisher(.userAlbums(userid: id), callbackQueue: .main)
        provider.request(.userAlbums(userid: id)) { result in
            switch result{
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        self.activityIndicator.stopAnimating()
                        let albums = try JSONDecoder().decode([Album].self, from: response.data)
                        self.albumViewModels.removeAll()
                        for album in albums {
                            let viewModel = AlbumViewModel(album: album)
                            self.albumViewModels.append(viewModel)
                        }
                    } catch {
                        print("ERROR:\n",error)
                    }
                }
            case .failure(let error):
                print(error)
                self.getAlbums(id)
            }
        }
    }
    func setupTableView(){
        albumTableView.register(UserAlbumCell.self, forCellReuseIdentifier: "albumCell")
        albumTableView.delegate = self
        albumTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as? UserAlbumCell{
            cell.albumViewModel = albumViewModels[indexPath.row]
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(albumViewModels[indexPath.row].getAlbumId())
    }
}

