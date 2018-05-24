//
//  DetailViewController.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit

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
    
    // - MARK PROPERTIES
    var movie: Movie!
    var poster: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    @IBAction func buynowButtonTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "buy", sender: movie.buy)
    }
    
    @IBAction func watchTrailerTapped(_ sender: Any) {
        let url = URL(string: movie.preview)
       self.performSegue(withIdentifier: "movie", sender: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! VideoViewController
        if segue.identifier == "movie"{
        destination.url = sender as! URL
        }
        else if segue.identifier == "buy" {
            destination.url = URL(string:movie.buy)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
