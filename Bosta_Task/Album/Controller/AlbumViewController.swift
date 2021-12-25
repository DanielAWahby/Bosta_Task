//
//  AlbumViewController.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 17/12/2021.
//

import UIKit
import Combine
import CombineMoya
import Moya

class AlbumViewController: UIViewController {
    
    var photoViewModels = [PhotoViewModel]()
    let provider = MoyaProvider<Service>()
    @IBOutlet weak var photosCollectionView : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var profileLabel:UILabel!
    
     private var passedID: Int {
        set {
            self.passedID = newValue
        }
        get{
            return self.passedID
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getPhotos()
    }
    func setup(){
        profileLabel.text = UserDefaults.standard.string(forKey: "savedIntitials")
        
    }
    
    func getPhotos(){
        provider.request(.albumPhotos(albumId: passedID)) { result in
            switch result{
            case .success(let httpResponse):
                if httpResponse.statusCode == 200{
                    do {
                        self.photoViewModels.removeAll()
                        let allPhotos = try JSONDecoder().decode([Photo].self, from: httpResponse.data)
                        allPhotos.forEach { photo in
                            self.photoViewModels.append(PhotoViewModel(photo))
                        }
                    } catch{
                        print(error.localizedDescription)
                        self.getPhotos()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
