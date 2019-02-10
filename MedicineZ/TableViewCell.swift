//
//  TableViewCell.swift
//  MedicineZ
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var segment: UILabel!    
    
    @IBOutlet weak var alarmTimeSetting: UILabel!
    @IBOutlet weak var repetition: UILabel!
    
    @IBOutlet weak var alarmName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
