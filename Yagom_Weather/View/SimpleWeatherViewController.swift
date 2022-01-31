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
    @IBOutlet weak var simpleWeatherTableView: UITableView!
    @IBAction func onOptionButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let sortAction = UIAlertAction(title: "정렬", style: .default, handler: { _ in
            let settingAlert = UIAlertController(title: "정렬", message: "정렬 방식 선택", preferredStyle: UIAlertController.Style.actionSheet)
            let nameSortAction = UIAlertAction(title: "도시 이름 순", style: .default, handler: { _ in
                self.simpleWeatherListViewModel.sortByName()
                DispatchQueue.main.async {
                    self.simpleWeatherTableView.reloadData()
                }
            })
            let temperatureSortAction = UIAlertAction(title: "현재 온도 순", style: .default, handler: { _ in
                self.simpleWeatherListViewModel.sortByTemperature()
                DispatchQueue.main.async {
                    self.simpleWeatherTableView.reloadData()
                }
            })
            settingAlert.addAction(nameSortAction)
            settingAlert.addAction(temperatureSortAction)
            self.present(settingAlert, animated: false, completion: nil)
        })
        let celsiusAction = UIAlertAction(title: "섭씨", style: .default, handler: { _ in
            print("섭씨")
        })
        let fahrenheitAction = UIAlertAction(title: "화씨", style: .default, handler: { _ in
            print("화씨")
        })
        let language = UIAlertAction(title: "언어 설정", style: .default, handler: {
            _ in
        })
        alert.addAction(sortAction)
        alert.addAction(celsiusAction)
        alert.addAction(fahrenheitAction)
        alert.addAction(language)
        present(alert, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherAPI.shared.getWeathers(cities: cityNames, completion: { weathers in
            self.simpleWeatherListViewModel = SimpleWeatherListViewModel(weathers: weathers)
            DispatchQueue.main.async {
                self.simpleWeatherTableView.reloadData()
            }
        })
        simpleWeatherTableView.delegate = self
        simpleWeatherTableView.dataSource = self
        simpleWeatherTableView.rowHeight = 128
        let nibName = UINib(nibName: "SimpleWeatherTableViewCell", bundle: nil)
        simpleWeatherTableView.register(nibName, forCellReuseIdentifier: "simpleWeatherCell")
        
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
