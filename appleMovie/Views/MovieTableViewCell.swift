//
//  MovieTableViewCell.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.poster.frame.size.width /= 2
        //self.poster.layer.borderColor = UIColor.random().cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
