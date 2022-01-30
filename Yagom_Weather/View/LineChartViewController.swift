//
//  LineChartViewController.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class LineChartViewController: UIViewController {
    var weather = Weather()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    }
}
