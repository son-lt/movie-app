//
//  CustomItemView.swift
//  movie-app
//
//  Created by TuanDQ on 23/02/2023.
//

import UIKit

@IBDesignable
class GenresView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.grid.2x2")
        imageView.tintColor = UIColor(white: 1, alpha: 0.75)
        return imageView
    }()
    
    let labelText: UILabel = {
        let labelText = UILabel()
        labelText.textAlignment = .center
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.textColor = UIColor.white
        labelText.text = "Genres"
        labelText.font = UIFont.systemFont(ofSize: 10)
        labelText.numberOfLines = 0
        return labelText
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.addSubview(iconImageView)
        self.addSubview(labelText)
        
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive =  true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1).isActive = true
        
        labelText.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor).isActive = true
        labelText.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        labelText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        
    }
}
