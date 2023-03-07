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
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
            ApiService.shareInstance.getDetailMovie(ID: id!) {
                [weak self] data in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.detailMovie = data
                DispatchQueue.main.async {
                    strongSelf.loadFrom(URLAddress: Configs.Network.apiImageUrl + (strongSelf.detailMovie?.posterPath ?? ""))
                    
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
        
        setupBackButton()
        
        setupReopenBottomSheetButton()
        
        detailView.setGradientBackground(colorLeading: UIColor(red: 0.169, green: 0.345, blue: 0.463, alpha: 1), colorTrailing: UIColor(red: 0.306, green: 0.263, blue: 0.463, alpha: 1))
    }
    
    @IBAction func openBottomSheetView() {
        if let sheet = self.detailBottomSheetViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 50
        }
        
        self.present(self.detailBottomSheetViewController, animated: true)
    }
    
    func setupBackButton() {
        let backImage = UIImage(systemName: "arrow.uturn.backward")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.75)
    }
    
    func setupReopenBottomSheetButton() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(openBottomSheetView))
        swipeUp.direction = .up
        self.openButton.addGestureRecognizer(swipeUp)
    }
    
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
                self.backgroundImageView.image = image
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            }
        }
        task.resume()
    }
}
    
