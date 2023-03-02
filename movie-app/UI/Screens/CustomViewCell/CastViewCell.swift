//
//  CastViewCell.swift
//  movie-app
//
//  Created by TuanDQ on 02/03/2023.
//

import UIKit

class CastViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBOutlet weak var roleLabel: UILabel!
    
    var task: URLSessionDataTask?
    
    var castImageCache: [String: UIImage] = [:]
    
    override func prepareForReuse() {
        if (castImageView.image != nil) {
            task?.cancel()
        }
    }
    
    var data: Cast? {
        didSet {
            guard let data = data else { return }
            castImageView.image = nil
            loadFrom(URLAddress: Configs.Network.apiImageUrl + (data.profilePath ?? ""))
            castImageView.layer.cornerRadius = 15
            actorLabel.text = data.character
            roleLabel.text = data.name
        }
    }
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        if castImageCache[url.absoluteString] != nil {
            self.castImageView.image = castImageCache[url.absoluteString]
            return
        }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No image data received")
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.castImageCache[url.absoluteString] = image
                self.castImageView.image = image
            }
        }
        
        task?.resume()
    }
    
}
