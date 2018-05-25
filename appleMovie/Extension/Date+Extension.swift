//
//  Date+Extension.swift
//  appleMovie
//
//  Created by Yveslym on 5/25/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import Foundation
extension String{
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else {return nil}
        return date
    }
}
