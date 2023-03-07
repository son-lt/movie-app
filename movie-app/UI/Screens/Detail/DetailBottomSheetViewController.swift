//
//  DetailBottomSheetViewController.swift
//  movie-app
//
//  Created by TuanDQ on 01/03/2023.
//

import UIKit

@IBDesignable
class DetailBottomSheetViewController: UIViewController {
    
    var detailMovie: DetailMovie?
    
    var castList: [Cast] = []

    @IBOutlet weak var title1Label: UILabel!
    
    @IBOutlet weak var title2Label: UILabel!
    
    @IBOutlet weak var genre1Label: UILabel!
    
    @IBOutlet weak var genre2Label: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    @IBOutlet weak var detailBottomSheetView: UIView!
    
    @IBOutlet weak var genre1View: UIView!
    
    @IBOutlet weak var genre2View: UIView!
    
    @IBOutlet weak var imdbView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        
        setupGenreLabel()
        
        setupCastCollectionView()
        
        setupIMDBLabel()
        
        ApiService.shareInstance.getCastList(ID: detailMovie?.id ?? 0) {
            [weak self] data in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.castList = data?.cast ?? []
                DispatchQueue.main.async {
                    strongSelf.castCollectionView.reloadData()
                }
            } onFailure: { errorMessage in
                print(errorMessage)
            }
        
        detailBottomSheetView.setGradientBackground(colorLeading: UIColor(red: 0.169, green: 0.345, blue: 0.463, alpha: 1), colorTrailing: UIColor(red: 0.306, green: 0.263, blue: 0.463, alpha: 1))
    }
    
    func setupCastCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        if let castFlowLayout = castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            castFlowLayout.scrollDirection = .horizontal
            castFlowLayout.minimumLineSpacing = 0
            castFlowLayout.minimumInteritemSpacing = 0
            castFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            castFlowLayout.itemSize = CGSize(width: castCollectionView.frame.width * 1/10, height: castCollectionView.frame.height * 0.8)
        }
    }
    
    func setupTitleLabel() {
        if ((detailMovie?.title ?? "").contains(": ")) {
            let splitText = (detailMovie?.title ?? "").components(separatedBy: ": ")
            title1Label.text = splitText[0]
            title2Label.text = splitText[1]
        }
        else {
            title1Label.text = detailMovie?.title ?? ""
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    func setupGenreLabel() {
        genre1View.layer.cornerRadius = 12
        genre2View.layer.cornerRadius = 12
        
        genre1Label.text = detailMovie?.genres?[0].name
        if (detailMovie?.genres?.count ?? 0 > 1) {
            genre2Label.text = detailMovie?.genres?[1].name
        } else {
            if let viewWithTag = self.view.viewWithTag(2) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    func setupIMDBLabel() {
        imdbView.layer.cornerRadius = 12
        imdbView.backgroundColor = UIColor(red: 0.961, green: 0.773, blue: 0.094, alpha: 1)
        
        scoreLabel.text = "\(round((detailMovie?.voteAverage ?? 0) * 10) / 10)"
        overviewLabel.text = detailMovie?.overview
    }
}

extension DetailBottomSheetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: "castViewCell", for: indexPath) as! CastViewCell
        cell.data = self.castList[indexPath.row]
        return cell
    }
    
    
}
