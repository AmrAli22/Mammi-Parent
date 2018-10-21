//
//  UserModel.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import Foundation

struct user: Codable {
    
    let _TypeOfUser : String
    let _ImgURL : String
    let _HavePrivateChat : Bool
    let _HaveParentChat : Bool
    let _HaveClassChat : Bool
    let _Name : String
    let _Phone : String
    let _HaveTutorial : Bool
    let _CreationDate : String
    let _Id : Int16
    let _Token : String
   
}
