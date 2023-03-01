//
//  DetailViewController.swift
//  movie-app
//
//  Created by TuanDQ on 01/03/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var id : Int?
    
    var detailMovie: DetailMovie?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (id != nil) {
            ApiService.shareInstance.getDetailMovie(ID: id!) {
                [weak self] data in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.detailMovie = data
                DispatchQueue.main.async {
                    strongSelf.backgroundImageView.loadFrom(URLAddress: Configs.Network.apiImageUrl + (strongSelf.detailMovie?.posterPath ?? ""))
                    strongSelf.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                }
            } onFailure: { errorMessage in
                print(errorMessage)
            }
        }
    }
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
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
                self.image = image
            }
        }
        task.resume()
    }
}
