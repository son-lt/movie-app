//
//  ViewController.swift
//  movie-app
//
//  Created by TuanDQ on 20/02/2023.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    var popularMovieList : [Movie] = []
    
    var upcomingMovieList : [Movie] = []
    
    
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    @IBOutlet weak var mostPopularCollectionView: UICollectionView!
    
    @IBOutlet weak var homeView: UIView!
        
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var mostPopularPageControl: UIPageControl!
    
    @IBOutlet weak var upcomingPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        setupMostPopularCollectionView()
        
        setupUpcomingCollectionView()
        
        homeView.setGradientBackground(colorLeading: UIColor(red: 0.169, green: 0.345, blue: 0.463, alpha: 1), colorTrailing: UIColor(red: 0.306, green: 0.263, blue: 0.463, alpha: 1))
        
        ApiService.shareInstance.getPopularMovieList(page: 1) { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            strongSelf.popularMovieList = data?.results ?? []
            DispatchQueue.main.async {
                strongSelf.mostPopularCollectionView.reloadData()
                strongSelf.mostPopularPageControl.numberOfPages = strongSelf.popularMovieList.count
            }
        } onFailure: { errorMessage in
            print(errorMessage)
        }
        
        ApiService.shareInstance.getUpcomingMovieList(page: 1) { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.upcomingMovieList = data?.results ?? []
            DispatchQueue.main.async {
                strongSelf.upcomingCollectionView.reloadData()
                strongSelf.upcomingPageControl.numberOfPages = strongSelf.upcomingMovieList.count
            }
        } onFailure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
    func setupSearchBar() {
        searchBarView.layer.cornerRadius = 15
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    func setupMostPopularCollectionView() {
        mostPopularCollectionView.delegate = self
        mostPopularCollectionView.dataSource = self
        
        if let mostPopularFlowLayout = mostPopularCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            mostPopularFlowLayout.scrollDirection = .horizontal
            mostPopularFlowLayout.minimumLineSpacing = 0
            mostPopularFlowLayout.minimumInteritemSpacing = 0
            mostPopularFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 0)
            mostPopularFlowLayout.itemSize = CGSize(width: mostPopularCollectionView.frame.width * 0.7, height: mostPopularCollectionView.frame.height * 0.8)
        }
    }
    
    func setupUpcomingCollectionView() {
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        
        if let upcomingFlowLayout = upcomingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            upcomingFlowLayout.scrollDirection = .horizontal
            upcomingFlowLayout.minimumLineSpacing = 0
            upcomingFlowLayout.minimumInteritemSpacing = 0
            upcomingFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 0)
            upcomingFlowLayout.itemSize = CGSize(width: mostPopularCollectionView.frame.width * 1/3, height: mostPopularCollectionView.frame.height)
        }
    }
}
    
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in mostPopularCollectionView.visibleCells {
            mostPopularPageControl.currentPage = mostPopularCollectionView.indexPath(for: cell)?.row ?? 0
        }
        for cell in upcomingCollectionView.visibleCells {
            upcomingPageControl.currentPage = upcomingCollectionView.indexPath(for: cell)?.row ?? 0
        }
    }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if (collectionView == mostPopularCollectionView) {
                return popularMovieList.count
            }
                return upcomingMovieList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if (collectionView == mostPopularCollectionView) {
                let cell = (mostPopularCollectionView.dequeueReusableCell(withReuseIdentifier: "mostPopularCell", for: indexPath) as! MostPopularCell)
                cell.data = self.popularMovieList[indexPath.row]
                return cell
            }
            else {
                let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingCell
                cell.data = self.upcomingMovieList[indexPath.row]
                return cell
            }
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailviewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        if (collectionView == mostPopularCollectionView) {
            detailviewController.id = popularMovieList[indexPath.row].id
        }
        else {
            detailviewController.id = upcomingMovieList[indexPath.row].id
        }
        self.navigationController?.pushViewController(detailviewController, animated: true)
    }
}

extension UIView {
    func setGradientBackground(colorLeading: UIColor, colorTrailing: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeading.cgColor, colorTrailing.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
       layer.insertSublayer(gradientLayer, at: 0)
    }
}
