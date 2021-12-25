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
    
    let cellIdentifier = "PhotoCellIdentifier"
    
    @IBOutlet weak var photosCollectionView : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var profileLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    
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
//  MARK:- Setting views and delegates
    func setup(){
        profileLabel.text = UserDefaults.standard.string(forKey: "savedIntitials") ?? ""
        view.layoutIfNeeded()
        profileLabel.layer.cornerRadius = profileLabel.frame.size.height / 2
        profileLabel.clipsToBounds = true
        view.layoutIfNeeded()
        searchBar.delegate = self
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(AlbumPhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
//    MARK:- Get Photos API Call to Moya
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

//MARK:- Collection View Delegate
extension AlbumViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        TODO
    }
}
//MARK:- Collection View DataSource
extension AlbumViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumPhotoCell{
            cell.photoViewModel = photoViewModels[indexPath.row]
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
}
//MARK:- Search Bar Delegate
extension AlbumViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
    }
}
