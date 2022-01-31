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
    @IBAction func onFutureButtonClick(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LineChartView") as? LineChartViewController else {
            return
        }
        vc.weather = self.weather
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    var weather = Weather()
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = weather.cityName
        temparetureLabel.text = "\(weather.currentTemperature)°"
        descriptionLabel.text = weather.description
        highestTemparetureLabel.text = "\(NSLocalizedString("Highest", comment: "")):\(weather.highestTemperature)°"
        minimumTemparetureLabel.text = "\(NSLocalizedString("Minimum", comment: "")):\(weather.minimumTemperature)°"
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
        sensoryTemperatureLabel.text = "\(NSLocalizedString("sensoryTemperature", comment: "")) : \(weather.sensoryTemperature)°"
        humidityLabel.text = "\(NSLocalizedString("currentHumidity", comment: "")) : \(weather.currentHumidity)%"
        atmosphericPressureLabel.text = "\(NSLocalizedString("atmosphericPressure", comment: "")) : \(weather.atmosphericPressure) hPa"
        windSpeedLabel.text = "\(NSLocalizedString("windSpeed", comment: "")) : \(weather.windSpeed) m/s"
    }
}
