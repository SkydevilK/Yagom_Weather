//
//  ViewController.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class SimpleWeatherViewController: UIViewController {

    @IBOutlet weak var simpleWeatherTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleWeatherTableView.delegate = self
        simpleWeatherTableView.dataSource = self
        let nibName = UINib(nibName: "SimpleWeatherTableViewCell", bundle: nil)
        simpleWeatherTableView.register(nibName, forCellReuseIdentifier: "simpleWeatherCell")
    }


}

extension SimpleWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
