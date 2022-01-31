//
//  ViewController.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class SimpleWeatherViewController: UIViewController {
    private let cityNames = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju City", "Cheonan", "Cheongju-si", "Chuncheon"]
    
    private var simpleWeatherListViewModel = SimpleWeatherListViewModel(weathers: [])
    @IBOutlet weak var currentTemperatureText: UILabel!
    @IBOutlet weak var simpleWeatherTableView: UITableView!
    @IBAction func onOptionButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let sortAction = UIAlertAction(title: NSLocalizedString("Sort", comment: ""), style: .default, handler: { _ in
            let settingAlert = UIAlertController(title: NSLocalizedString("Sort", comment: ""), message: NSLocalizedString("SelectSorting", comment: ""), preferredStyle: UIAlertController.Style.actionSheet)
            let nameSortAction = UIAlertAction(title: NSLocalizedString("ByCityName", comment: ""), style: .default, handler: { _ in
                self.simpleWeatherListViewModel.sortByName()
                DispatchQueue.main.async {
                    self.simpleWeatherTableView.reloadData()
                }
            })
            let temperatureSortAction = UIAlertAction(title: NSLocalizedString("ByCurrentTemperature", comment: ""), style: .default, handler: { _ in
                self.simpleWeatherListViewModel.sortByTemperature()
                DispatchQueue.main.async {
                    self.simpleWeatherTableView.reloadData()
                }
            })
            settingAlert.addAction(nameSortAction)
            settingAlert.addAction(temperatureSortAction)
            self.present(settingAlert, animated: false, completion: nil)
        })
        let celsiusAction = UIAlertAction(title: NSLocalizedString("Celsius", comment: ""), style: .default, handler: { _ in
            if Value.shared.units != "metric" {
                Value.shared.units = "metric"
                self.setData()
            }
        })
        let fahrenheitAction = UIAlertAction(title: NSLocalizedString("Fahrenheit", comment: ""), style: .default, handler: { _ in
            if Value.shared.units != "imperial" {
                Value.shared.units = "imperial"
                self.setData()
            }
        })
        alert.addAction(sortAction)
        alert.addAction(celsiusAction)
        alert.addAction(fahrenheitAction)
        present(alert, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTemperatureText.text = NSLocalizedString("CurrentWeather", comment: "")
        setData()
        simpleWeatherTableView.delegate = self
        simpleWeatherTableView.dataSource = self
        simpleWeatherTableView.rowHeight = 128
        let nibName = UINib(nibName: "SimpleWeatherTableViewCell", bundle: nil)
        simpleWeatherTableView.register(nibName, forCellReuseIdentifier: "simpleWeatherCell")
        
    }
    func setData() {
        WeatherAPI.shared.getWeathers(cities: self.cityNames, completion: { weathers in
            self.simpleWeatherListViewModel = SimpleWeatherListViewModel(weathers: weathers)
            DispatchQueue.main.async {
                self.simpleWeatherTableView.reloadData()
            }
        })
    }
}

extension SimpleWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.simpleWeatherListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "simpleWeatherCell", for: indexPath) as? SimpleWeatherTableViewCell {
            let simpleWeatherViewModel = self.simpleWeatherListViewModel.weatherAtIndex(indexPath.row)
            cell.configure(viewModel: simpleWeatherViewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailWeatherView") as? DetailWeatherViewController else {
            return
        }
        vc.weather = self.simpleWeatherListViewModel.weathers[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
