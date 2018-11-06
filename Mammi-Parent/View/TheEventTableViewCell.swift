//
//  TheEventTableViewCell.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class TheEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageViewEvent: UIImageView!
    @IBOutlet weak var TxtViewEventDate: UITextView!
  
    @IBOutlet weak var TxtViewEventName: UITextField!
    @IBOutlet weak var TxtViewEventDesc: UITextView!
    @IBOutlet weak var TxtViewEventCost: UITextField!
    
    
    func ConfigrationTheCell( Date : String , Name : String , Desc : String , Cost : String , Image :UIImage ){
        
        TxtViewEventCost.text = Cost
        TxtViewEventDate.text = Date
        TxtViewEventDesc.text = Desc
        TxtViewEventName.text = Name
        ImageViewEvent.image  = Image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
