//
//  GradientView.swift
//  frame and bound challenge
//
//  Created by Yveslym on 5/3/18.
//  Copyright © 2018 UnicornVR. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIImageView {
    
    @IBInspectable var topColor: UIColor = UIColor.blue{
        didSet{
            self.makeGradient()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.blue{
        didSet{
            self.makeGradient()
        }
    }
    
    @IBInspectable var masktoBounds: Bool = true{
        didSet{
            layer.masksToBounds = masktoBounds
            
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
        
        }
    }
    
    @IBInspectable var shadowRaduis: CGFloat = 0.0 {
        didSet{
            layer.shadowRadius = shadowRaduis
            
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet{
            layer.shadowOpacity = shadowOpacity
            
        }
    }
    
    @IBInspectable var borderWidgth: CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWidgth
            
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
   
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        //GradientView.init(coder: aDecoder)
    }
    //    override func prepareForInterfaceBuilder() {
    //        layer.cornerRadius = cornerRadius
    //    }
    
    func makeGradient(){
        
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        gradient.cornerRadius = layer.cornerRadius
        gradient.shadowRadius = layer.shadowRadius
        gradient.shadowOpacity = layer.shadowOpacity
        gradient.shadowColor = layer.shadowColor
        gradient.borderWidth = layer.borderWidth
        gradient.borderColor = layer.borderColor
        gradient.masksToBounds = layer.masksToBounds
        
        gradient.colors = [topColor, bottomColor].map { $0.cgColor }
        gradient.locations = [0.0, 1.0]
        layer.addSublayer(gradient)
    }
    
}

