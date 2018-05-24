//
//  Movie.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import Foundation
import UIKit

struct AllMovie: Decodable{
    var entry: [Movie]
}

struct FeedStruct: Decodable{
    var feed: AllMovie
}

struct Movie: Decodable{
    
    var name: String
    var image: String
    var summary: String
    var price : String
    let buy: String
    let preview: String
    let releaseDate: String
    var category: String
    
    enum FeedKey: String, CodingKey{
        case feed = "feed", entry
    }
    
        
    enum EntryKey : String, CodingKey{
        case name = "im:name"
        case image = "im:image"
        case summary
        case price = "im:price"
        case link
        case releaseDate = "im:releaseDate"
        case category
        
        enum CategoryKey: String, CodingKey{
            case attributes
            enum AttributeKey: String, CodingKey{
                case label
            }
        }
       
        enum NameKey: String, CodingKey{
            case label
        }
        enum ImageKey: String,CodingKey{
            case label
        }
        enum SummaryKey: String, CodingKey{
            case label
        }
        enum PriceKey: String, CodingKey{
           case label
        }
        enum releaseDateKey: String, CodingKey{
            case attributes
            enum AttributeKey: String, CodingKey{
                case label
            }
        }
    }

     init(from decoder: Decoder) throws{
        
//        let container = try! decoder.container(keyedBy: FeedKey.self)
//        let feedCont = try! container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feed)
        
        
        
        let container = try! decoder.container(keyedBy: EntryKey.self)

        let nameContainer = try! container.nestedContainer(keyedBy: EntryKey.NameKey.self, forKey: .name)

        let summaryContainer = try container.nestedContainer(keyedBy: EntryKey.SummaryKey.self, forKey: .summary)
        let priceCont = try container.nestedContainer(keyedBy: EntryKey.PriceKey.self, forKey: .price)
        let linkCont = try container.decode([Link].self, forKey: .link)
        let releaseDateContainer = try container.nestedContainer(keyedBy: EntryKey.releaseDateKey.self, forKey: .releaseDate)
        let attributeContainer = try releaseDateContainer.nestedContainer(keyedBy: EntryKey.releaseDateKey.AttributeKey.self, forKey: .attributes)
        let categoryCont = try container.nestedContainer(keyedBy: EntryKey.CategoryKey.self, forKey: .category)
        let CatAttributeContainer = try categoryCont.nestedContainer(keyedBy: EntryKey.CategoryKey.AttributeKey.self, forKey: .attributes)
        category = try CatAttributeContainer.decode(String.self, forKey: .label)
        releaseDate = try attributeContainer.decode(String.self, forKey: .label)
        price = try priceCont.decode(String.self, forKey: .label)
        name = try nameContainer.decode(String.self, forKey: .label)
        summary = try summaryContainer.decode(String.self, forKey: .label)
        let images = try container.decode([Image].self, forKey: .image)
        image = (images.last?.label)!
        buy = (linkCont.first?.attributes["href"])!
        preview =  (linkCont.last?.attributes["href"])!
//        name = ""
//        image = ""
//        preview = ""
//        releaseDate = ""
//        summary = ""
//        price = ""
//        buy = ""
//        category = ""
    }
    
}

struct Image: Decodable{
    let label: String
}
struct Link: Decodable{
    let attributes: [String: String]
}
struct Attribute: Decodable{
    var label: String
}




