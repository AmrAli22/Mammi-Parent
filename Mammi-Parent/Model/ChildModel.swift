//
//  ChildModel.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/13/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation

struct Child: Codable {
    
    let name : String
    let imgURL : String
    let hadanaID : Int
    let hadanaName : String
    let childClass : String
    
    init(_name : String , _imgURL : String , _hadanaID : Int ,_hadanaName : String , _childClass : String ) {
        name = _name
        imgURL = _imgURL
        hadanaID = _hadanaID
        hadanaName = _hadanaName
        childClass = _childClass
    }
}
