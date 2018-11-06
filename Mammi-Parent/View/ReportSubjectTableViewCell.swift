//
//  ReportSubjectTableViewCell.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/29/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class ReportSubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var TxtFieldGrade: UITextField!
    @IBOutlet weak var TxtFieldSubject: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigurationCell(Subject : String , Grade : String ) {
        self.TxtFieldGrade.text = Grade
        self.TxtFieldSubject.text = Subject
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
