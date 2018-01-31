//
//  CollectionViewCell.swift
//  GameStep2
//
//  Created by Володимир Смульський on 1/11/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class CollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var ImageInCell: UIImageView!
    
 //   @IBOutlet weak var BackgroundImage: UIImageView!
    
    func remove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(950), execute: {
            UIView.transition(with: self,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: { self.alpha = 0
                                
            },
                              completion: nil )
             self.removeFromSuperview()
        })
       
    }
    
    func flip (picture:UIImage){
        UIView.transition(with: self,
                          duration: 0.25,
                          options: .transitionFlipFromLeft,
                          animations: { self.ImageInCell?.image = picture
                            
        },
                          completion: nil )
    }
    func flipDown (picture:UIImage){
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350), execute: {
            UIView.transition(with: self,
                              duration: 0.25,
                              options: .transitionFlipFromLeft,
                              animations: { self.ImageInCell?.image = picture
                                
            },
                              completion: nil )
        })
    }
    
}
