//
//  DetailWeatherViewController.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temparetureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var highestTemparetureLabel: UILabel!
    @IBOutlet weak var minimumTemparetureLabel: UILabel!
    @IBOutlet weak var iconUIImage: UIImageView!
    @IBOutlet weak var sensoryTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var atmosphericPressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    var weather = Weather()
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = weather.cityName
        temparetureLabel.text = "\(weather.currentTemperature)°"
        descriptionLabel.text = weather.description
        highestTemparetureLabel.text = "최고:\(weather.highestTemperature)°"
        minimumTemparetureLabel.text = "최저:\(weather.minimumTemperature)°"
        guard let url = URL(string: weather.weatherIconURL ) else {
            DispatchQueue.main.async {
                self.iconUIImage?.image = UIImage(systemName: "xmark.circle")!
            }
            return
        }
        CacheData.publicCache.getImage(url: url) { image in
            guard let image = image else {
                DispatchQueue.main.async {
                    self.iconUIImage?.image = UIImage(systemName: "xmark.circle")!
                }
                return
            }
            DispatchQueue.main.async {
                self.iconUIImage?.image = image
            }
        }
        sensoryTemperatureLabel.text = "체감기온 : \(weather.sensoryTemperature)°"
        humidityLabel.text = "현재습도 : \(weather.currentHumidity)%"
        atmosphericPressureLabel.text = "기압 : \(weather.atmosphericPressure) hPa"
        windSpeedLabel.text = "풍속 : \(weather.windSpeed) m/s"
    }
}
