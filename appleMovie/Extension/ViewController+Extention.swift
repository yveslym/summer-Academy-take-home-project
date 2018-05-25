//
//  ViewController+Extention.swift
//  appleMovie
//
//  Created by Yveslym on 5/24/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //Purpose: HIde NavigationBar
    func hideNavigation(tint: UIColor) {
        //        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //        navigationController?.navigationBar.barStyle = .default
        //        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.tintColor = tint
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
    func showNavigation() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func changeNavigationColor(_ color: UIColor){
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func NavigationName(_ name: String){
        navigationItem.title = name
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

