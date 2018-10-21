//
//  RoundedImages.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    
    func makeRoundedImages()
    {
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.purple.cgColor
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
}
