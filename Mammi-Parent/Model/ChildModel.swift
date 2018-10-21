//
//  ChildModel.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/13/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation

struct Child {
    let name : String
    let img : UIImage
    let hadanaID : Int
    let hadanaName : String
    let childClass : String
    
    init(_name : String , _img : UIImage , _hadanaID : Int ,_hadanaName : String , _childClass : String ) {
        name = _name
        img = _img
        hadanaID = _hadanaID
        hadanaName = _hadanaName
        childClass = _childClass
    }
}
