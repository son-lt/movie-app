//
//  ViewController.swift
//  movie-app
//
//  Created by TuanDQ on 20/02/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.shareInstance.getPopularMovieList(page: 1)
        ApiService.shareInstance.getUpcomingMovieList(page: 1)
    }


}

