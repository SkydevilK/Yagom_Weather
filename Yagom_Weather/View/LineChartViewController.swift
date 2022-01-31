//
//  LineChartViewController.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class LineChartViewController: UIViewController {
    var weather = Weather()
    var minTempValues: [CGFloat] = []
    var maxTempValues: [CGFloat] = []
    var humidityValues: [CGFloat] = []
    var timeStamp: [String] = []
    var minView = UIView()
    var maxView = UIView()
    var humidityView = UIView()
    var timeStampViews = [UIView]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var humidityText: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.isTurn = true
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        appDelegate.isTurn = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureText.text = NSLocalizedString("Temperature", comment: "")
        humidityText.text =  NSLocalizedString("Humidity", comment: "")
        WeatherAPI.shared.getFutureWeather(city: weather.cityName, completion: { weathers in
            for weather in weathers {
                self.minTempValues.append(CGFloat((weather.minimumTemperature as NSString).doubleValue))
                self.maxTempValues.append(CGFloat((weather.highestTemperature as NSString).doubleValue))
                self.humidityValues.append(CGFloat((weather.currentHumidity as NSString).doubleValue))
                
                let timeStamp = weather.timeStamp.split(separator: " ")
                let _date = timeStamp[0].split(separator: "-")
                let _time = timeStamp[1].split(separator: ":")
                self.timeStamp.append("\(_date[1])/\(_date[2]) \(_time[0]):\(_time[1])")
            }
            self.drawChart()
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.drawChart()
    }
    
    func drawChart() {
        let padding: CGFloat = 100
        DispatchQueue.main.async {
            self.minView.removeFromSuperview()
            self.maxView.removeFromSuperview()
            self.humidityView.removeFromSuperview()
            for view in self.timeStampViews {
                view.removeFromSuperview()
            }
            self.timeStampViews.removeAll()
            let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - padding, height: self.view.frame.height - padding)
            self.minView = LineGraph(frame: frame,
                                     values: self.minTempValues, color: UIColor.blue.cgColor, isTemp: true)
            self.minView.center = CGPoint(x: self.view.frame.size.width  / 2,
                                          y: self.view.frame.size.height / 2)
            self.view.addSubview(self.minView)
            self.maxView = LineGraph(frame: frame,
                                     values: self.maxTempValues, color: UIColor.red.cgColor, isTemp: true)
            self.maxView.center = CGPoint(x: self.view.frame.size.width  / 2,
                                          y: self.view.frame.size.height / 2)
            self.view.addSubview(self.maxView)
            self.humidityView = LineGraph(frame: frame,
                                          values: self.humidityValues, color: UIColor.black.cgColor, isTemp: false)
            self.humidityView.center = CGPoint(x: self.view.frame.size.width  / 2,
                                               y: self.view.frame.size.height / 2)
            self.view.addSubview(self.humidityView)
            let xOffset: CGFloat = frame.width / CGFloat(self.timeStamp.count)
            
            for i in stride(from: 0, through: self.timeStamp.count - 1, by: 8) {
                let textView = UITextView(frame: CGRect(x: CGFloat(i) + xOffset * CGFloat(i) + 30, y: self.view.frame.height - padding, width: 100, height: 24))
                textView.text = self.timeStamp[i]
                textView.font = .systemFont(ofSize: 8)
                textView.backgroundColor = .none
                self.view.addSubview(textView)
                self.timeStampViews.append(textView)
            }
        }
    }
}
