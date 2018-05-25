//
//  DetailViewController.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit
import ChameleonFramework
class DetailViewController: UIViewController {

    // - MARK: IBOUTLET
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
     @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var buyNowButton: UIButton!
    
    // - MARK PROPERTIES
    var movie: Movie!
    var poster: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
let color =  ColorsFromImage(poster, withFlatScheme: true).first
        color?.withAlphaComponent(0.5)

        watchButton.backgroundColor = color!
        buyNowButton.backgroundColor = color!
        
        watchButton.layer.cornerRadius = 10
        buyNowButton.layer.cornerRadius = 10
        
        buyNowButton.layer.masksToBounds = true
        watchButton.layer.masksToBounds = true
       
        self.showNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        posterView.image = poster
        releasedDateLabel.text = movie.releaseDate
        priceLabel.text = movie.price
        summaryTextView.text = movie.summary
        categoryLabel.text = movie.category
       tabBarController?.tabBar.tintColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // - MARK: IBACTION:
    
    // redirect to app store
    @IBAction func buynowButtonTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string : movie.buy)!, options: [:])
    }
    
    // redirect to safari to see the trailer
    @IBAction func watchTrailerTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string : movie.preview)!, options: [:])
    }
}
