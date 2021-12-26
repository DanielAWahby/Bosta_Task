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
import SwiftUI

class AlbumViewController: UIViewController {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumPhotoCell{
//            cell.backgroundColor = .red
//            //            cell.photoViewModel = photoViewModels[indexPath.row]
//            return cell
//        }
//        else{
//            return UICollectionViewCell()
//        }
//    }
    
    
    var photoViewModels = [PhotoViewModel]()
    let provider = MoyaProvider<Service>()
    
    let cellIdentifier = "PhotoCellIdentifier"
    
    @IBOutlet weak var photosCollectionView : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var profileLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    
    var passedID: Int = 0
    var passedTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getPhotos()
        
    }
   
//  MARK:- Setting views and delegates
    func setup(){
        profileLabel.text = UserDefaults.standard.string(forKey: "savedIntitials") ?? ""
        titleLabel.text = passedTitle 
        view.layoutIfNeeded()
        profileLabel.layer.cornerRadius = profileLabel.frame.size.height / 2
        profileLabel.clipsToBounds = true
        view.layoutIfNeeded()
        searchBar.delegate = self
        photosCollectionView.register(AlbumPhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self

    }
//    MARK:- Get Photos API Call to Moya
    func getPhotos(){
        provider.request(.albumPhotos(albumId: 1)) { result in
            switch result{
            case .success(let httpResponse):
                if httpResponse.statusCode == 200{
                    do {
                        self.photoViewModels.removeAll()
                        let allPhotos = try JSONDecoder().decode([Photo].self, from: httpResponse.data)
                        
                        allPhotos.forEach { photo in
//                            print(photo)
                            self.photoViewModels.append(PhotoViewModel(photo))
                        }
                        if allPhotos.count == self.photoViewModels.count {
                            DispatchQueue.main.async{
                                self.photosCollectionView.reloadData()
                            }
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

////MARK:- Collection View Delegate
extension AlbumViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("photo selected")
    }
}
//MARK:- Collection View DataSource
extension AlbumViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoViewModels.count)
        return photoViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow : CGFloat = 3
        let width = collectionView.frame.size.width / numberOfItemsPerRow
        return CGSize(width:width, height: width)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlbumPhotoCell
        cell.photoViewModel = photoViewModels[indexPath.row]
        return cell
    }
}
////MARK:- Search Bar Delegate
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
