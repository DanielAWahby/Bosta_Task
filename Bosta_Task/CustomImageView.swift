//
//  CustomImageView.swift
//  Bosta_Task
//
//  Created by Daniel Wahby on 26/12/2021.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject,AnyObject>()

class CustomImageView: UIImageView {
    var task : URLSessionDataTask!
    var activityIndicatorView = UIActivityIndicatorView()
    
    func loadImage(from url:URL){
        image = nil
        
        
        self.addActivity()
        
        if let task = task{
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            DispatchQueue.main.async {
                self.removeActivity()
            }
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.removeActivity()
                }
                return
            }
            guard let data = data, let newImage = UIImage(data: data) else{
                print("Could not load image from: \(url)")
                self.image = UIImage(systemName: "questionmark")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
                self.removeActivity()
            }
        }
        task.resume()
    }
    func addActivity(){
        //        activityIndicatorView = NVActivityIndicatorView(frame:CGRect(x: 0, y: 0, width: self.frame.width / 6, height: self.frame.width / 6), type: .ballClipRotate, color: UIColor.lightGray, padding: 10)
        activityIndicatorView.color = UIColor(named: "AccentColor")
        activityIndicatorView.backgroundColor = .clear
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive  = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        activityIndicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        activityIndicatorView.startAnimating()
    }
    func removeActivity(){
        activityIndicatorView.stopAnimating()
    }
}
