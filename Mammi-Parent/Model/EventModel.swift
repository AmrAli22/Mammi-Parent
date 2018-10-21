//
//  EventModel.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation
struct Event {
    let name : String
    let img : UIImage
    let Desc : String
    let Date : String
    let Cost : String
    let Attends : Int
    
    init(_name : String , _img : UIImage , _Desc : String ,_Date : String , _Cost : String , _Attends : Int ) {
        name = _name
        img = _img
        Desc = _Desc
        Date = _Date
        Cost = _Cost
        Attends = _Attends
    }
}
