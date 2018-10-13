//
//  ViewController.swift
//  WeatherDemo
//
//  Created by PanshulK on 13/10/18.
//  Copyright © 2018 Jony Singla. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var weatherDataModel: WeatherDataModel!
    var weatherSubListModel: WeatherListModel!
    var weatherListDic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
        self.weatherApiCall(cityID: 1270260, appId: "71217f67f527e84ed663b34609750d63")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func weatherApiCall(cityID: Int, appId: String)  {
        let weatherDataManager = WeatherDataManager()
        if Connectivity.isConnectedToInternet() {
            weatherDataManager.WeatherDataManager(viewControllerName: self, cityID: cityID, appId: appId, callBack: { (isSuccess, errroMessage,weatherListDic ) in
                SVProgressHUD.dismiss()
                if(isSuccess) {
                    self.weatherListDic = weatherListDic!
                    self.weatherDataModel =  WeatherDataModel.getWeatherData(dataDict: weatherListDic!)
                    self.weatherSubListModel =  self.weatherDataModel.weatherDataArray[0] as! WeatherListModel;
                    self.tableView.reloadData()
                }  else {
                    CustomAlert.showAlertMsg(message: errroMessage!, viewController: self)
                }
            })
        }
        else{
            SVProgressHUD.dismiss()
            CustomAlert.showAlertMsg(message: Internet_Error , viewController: self)
        }
    }
    
    //MARK: - Table view Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListDic.count == 0 ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        self.weatherSubListModel =  self.weatherDataModel.weatherDataArray[indexPath.row] as! WeatherListModel;
        
        cell.dateLabel.text = self.weatherSubListModel.dateString
        cell.minTempLabel.text  = String(format: "%@",self.weatherSubListModel.subListDic["temp_min"]! as! NSNumber)
        cell.maxTempLabel.text  = String(format: "%@",self.weatherSubListModel.subListDic["temp_max"]! as! NSNumber)
        return cell
    }
}

