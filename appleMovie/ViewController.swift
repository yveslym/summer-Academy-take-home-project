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
    var popularMovie = [Movie]()
    
    // - MARK: IBACTIONS
    
    // action that handle the filter
    @IBAction func segmentSwitched(_ sender: Any, forEvent event: UIEvent) {
        let switchEvent = sender as! UISegmentedControl
        
        switch switchEvent.selectedSegmentIndex{
        case 0: self.movies = self.popularMovie
        case 1: self.sortNewMovies()
        case 2: self.sortByPrice()
        
        default: break
        }
    }
    
    // - MARK: METHODS
    
    func sortNewMovies(){
        self.movies.sort{return $0.releaseDateTimeStemp.toDate()! >  $1.releaseDateTimeStemp.toDate()!}
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
    func sortByPrice(){
        self.movies.sort{return $0._price > $1._price}
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        Networking.DownloadCat(page: 1) { (listOfMovie)  in
            
              self.movies = listOfMovie
            DispatchQueue.global().async {
               
             
                listOfMovie.forEach{
                    // download image
                    let url = URL(string: $0.image)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    
                   // add movie in the movie list
                    var movie = $0
                    movie.poster = image!
                    self.popularMovie.append(movie)
                    
                   
                }
                self.movies = self.popularMovie
               
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 8) {
            self.changeNavigationColor(HexColor("007AFF")!)
        }
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
        
      
        //color?.withAlphaComponent(0.5)

        if movie.poster != nil{
        let color =  ColorsFromImage(movie.poster!, withFlatScheme: true).first
        cell.poster.layer.borderColor = color?.cgColor
        cell.poster?.image = movie.poster!
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








