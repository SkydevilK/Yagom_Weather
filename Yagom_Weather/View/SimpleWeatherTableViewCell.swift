//
//  SimpleWeatherTableViewCell.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class SimpleWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
