//
//  FolderModel.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation
struct Folder {
    let name : String
    let img : UIImage
    let id : Int
    init(_name : String , _img : UIImage, _id : Int ) {
        name = _name
        img = _img
       id = _id
    }
}
