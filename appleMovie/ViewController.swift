//
//  ViewController.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit

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
        
        DispatchQueue.global().async {
           let url = URL(string: movie.image)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            let highQuality = self.imageWithImage(image: image!, scaledToSize: CGSize(width: 500.0, height: 500.0))
            DispatchQueue.main.async {
               
                
                cell.poster.image = highQuality
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
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
    
    func imageWithImage(image:UIImage ,scaledToSize newSize:CGSize)-> UIImage
    {
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage
    }
}

//MARK:- EXTENSION FOR UIIMAGE
extension UIImage {
    var uncompressedPNGData: Data      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData: Data { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: Data    { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: Data  { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: Data     { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:Data   { return UIImageJPEGRepresentation(self, 0.0)!  }
}








