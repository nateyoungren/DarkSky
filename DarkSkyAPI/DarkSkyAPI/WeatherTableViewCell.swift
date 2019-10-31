//
//  WeatherTableViewCell.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var todaysForecastLabel: UILabel!
}
