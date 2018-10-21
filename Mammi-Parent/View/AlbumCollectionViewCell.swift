//
//  AlbumCollectionViewCell.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImgViewAlbumPhoto: UIImageView!
    @IBOutlet weak var TxtFieldAlbumTitle: UITextField!
    
    func GonfigureCell (Albumtitle : String , AlbumImage : UIImage){
        ImgViewAlbumPhoto.image = AlbumImage
        TxtFieldAlbumTitle.text = Albumtitle
        
    }
}
