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
    
    let detailBottomSheetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailBottomSheetViewController") as! DetailBottomSheetViewController
    
    @IBOutlet weak var openButton: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(systemName: "arrow.uturn.backward")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.75)
        
            ApiService.shareInstance.getDetailMovie(ID: id!) {
                [weak self] data in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.detailMovie = data
                DispatchQueue.main.async {
                    strongSelf.backgroundImageView.loadFrom(URLAddress: Configs.Network.apiImageUrl + (strongSelf.detailMovie?.posterPath ?? ""))
                    
                    if let sheet = strongSelf.detailBottomSheetViewController.sheetPresentationController {
                        sheet.detents = [.medium(), .large()]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 50
                    }

                    strongSelf.detailBottomSheetViewController.detailMovie = strongSelf.detailMovie
                    
                    strongSelf.present(strongSelf.detailBottomSheetViewController, animated: true)
                   
                }
            } onFailure: { errorMessage in
                print(errorMessage)
            }
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(openBottomSheetView))
        swipeUp.direction = .up
        self.openButton.addGestureRecognizer(swipeUp)
    }
    
    @IBAction func openBottomSheetView() {
        if let sheet = self.detailBottomSheetViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 50
        }
        
        self.present(self.detailBottomSheetViewController, animated: true)
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
