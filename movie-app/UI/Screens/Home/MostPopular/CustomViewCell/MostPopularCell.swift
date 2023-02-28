//
//  MostPopularCell.swift
//  movie-app
//
//  Created by TuanDQ on 24/02/2023.
//

import UIKit

class MostPopularCell: UICollectionViewCell {

    @IBOutlet weak var mostPopularImageView: UIImageView!
    
    @IBOutlet weak var mostPopularLabel: UILabel!
    
    @IBOutlet weak var imdbView: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var task: URLSessionDataTask?
    
    override func prepareForReuse() {
        task?.cancel()
    }
    
    var data: Movie? {
        didSet {
            guard let data = data else { return }
            mostPopularImageView.image = nil
            loadFrom(URLAddress: Configs.Network.apiImageUrl + data.posterPath)
            mostPopularImageView.layer.cornerRadius = 30
            mostPopularLabel.text = data.title
            mostPopularLabel.numberOfLines = 3
            imdbView.backgroundColor = UIColor(red: 0.961, green: 0.773, blue: 0.094, alpha: 1)
            imdbView.layer.cornerRadius = 10
            scoreLabel.text = "\(data.voteAverage)"
            print("SonLT === \(data.posterPath)")
        }
    }
    
    var mostPopularImageCache: [String: UIImage] = [:]
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        if mostPopularImageCache[url.absoluteString] != nil {
            self.mostPopularImageView.image = mostPopularImageCache[url.absoluteString]
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
                self.mostPopularImageCache[url.absoluteString] = image
                self.mostPopularImageView.image = image
            }
        }
        
        task?.resume()
    }
   
}


