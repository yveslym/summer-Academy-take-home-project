//
//  ViewController.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController {

    // - MARK: IBOUTLET
    @IBOutlet weak var movieTableView: UITableView!
    
    // - MARK: PROPERTIES
    var movies = [Movie](){
        didSet{
            DispatchQueue.main.async {
                 self.movieTableView.reloadData()
            }
           
        }
    }
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor.clear
        Networking.DownloadCat(page: 1) { (mov)  in
            self.movies = mov
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
   
    /// table view delegate that return the number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    /// table view delegate method that update the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "movie") as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell.nameLabel.text = movie.name
        cell.priceLabel.text = movie.price
        cell.releaseDateLabel.text = movie.releaseDate
        
        // download the image on the backgroud thread
        DispatchQueue.global().async {
           let url = URL(string: movie.image)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
           
            // update the view on the main thread
            DispatchQueue.main.async {
                cell.poster.image = image
            }
        }
        
        return cell
    }
    // define size of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // prepare data to be sent trought segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! DetailViewController
        destination.movie = sender as! Movie
        destination.poster = self.image
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
       
        DispatchQueue.global().async {
            let url = URL(string: movie.image)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                 self.image = image!
                 self.performSegue(withIdentifier: "next", sender: movie)
               
            }
        }
    }
}








