//
//  MyChildren TableView CellTableViewCell.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/13/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class MyChildrenTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageViewChild: UIImageView!
    @IBOutlet weak var TxtFieldChildHadana: UITextField!
    @IBOutlet weak var TxtFieldChildClass: UITextField!
    @IBOutlet weak var TxtViewChildName: UITextField!
    
    func configurationTheCell (ChildName : String , CHildPhoto : UIImage , ChildClass : String , ChildHadana : String  ){
        
        ImageViewChild.image = CHildPhoto
        TxtViewChildName.text = ChildName
        TxtFieldChildClass.text = ChildClass
        TxtFieldChildHadana.text = ChildHadana
        ImageViewChild.makeRoundedImages()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
