//
//  Networking.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import Foundation

import UIKit

class Networking{
    static func DownloadCat(page: Int, completionHandler: @escaping ([Movie])->()){
        let url = URL(string: "https://itunes.apple.com/us/rss/topmovies/limit=50/json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, resp, error) in
            
            do{
                guard let data = data else {return}
                
                let json = try  JSONDecoder().decode(FeedStruct.self, from: data)
                let movies = json.feed.entry
                completionHandler(movies)
            }
            catch{
                print("oups")
            }
        }
        task.resume()
    }
}
