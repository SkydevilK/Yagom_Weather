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
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(viewModel: SimpleWeatherViewModel?) {
        guard let viewModel = viewModel else {
            self.cityName.text = "Error"
            self.currentTemperature.text = "Error"
            self.currentHumidity.text = "Error"
            self.iconImageView.image = CacheData.publicCache.placeholderImage
            return
        }
        self.cityName.text = viewModel.cityName
        self.currentTemperature.text = viewModel.currentTemperature
        self.currentHumidity.text = viewModel.currentHumidity
        
        guard let url = URL(string: viewModel.iconURL ?? "") else {
            DispatchQueue.main.async {
                self.iconImageView?.image = UIImage(systemName: "xmark.circle")!
            }
            return
        }
        CacheData.publicCache.getImage(url: url) { image in
            guard let image = image else {
                DispatchQueue.main.async {
                    self.iconImageView?.image = UIImage(systemName: "xmark.circle")!
                }
                return
            }
            DispatchQueue.main.async {
                self.iconImageView?.image = image
            }
        }
    }
}
