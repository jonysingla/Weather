//
//  WeatherListModel.swift
//  WeatherDemo
//
//  Created by PanshulK on 13/10/18.
//  Copyright © 2018 Jony Singla. All rights reserved.
//

import UIKit

class WeatherListModel: NSObject {
    
    var dateString: String = ""
    var subListDic = NSDictionary()
    class func setWeatherListData(weatherAPIData : NSDictionary)-> WeatherListModel
    {
        let weatherModel = WeatherListModel()
        weatherModel.dateString = JSON.StringValueForKey(json: weatherAPIData, key: "dt_txt")
        return weatherModel
    }
}

class WeatherDataModel: NSObject
{
    var weatherDataArray = NSMutableArray()
    class func getWeatherData(dataDict : NSDictionary)-> WeatherDataModel
    {
        let weatherDataModel = WeatherDataModel()
        let weatherArray = JSON.ArrayValueForKey(json: dataDict, key: "list")
        
        for recItem in weatherArray {
            let dict = recItem as! NSDictionary
            let weatherDataListModel: WeatherListModel = WeatherListModel.setWeatherListData(weatherAPIData: dict)
            weatherDataListModel.subListDic = (recItem as AnyObject).value(forKey: "main") as! NSDictionary
            weatherDataModel.weatherDataArray.add(weatherDataListModel)
        }
        return weatherDataModel
    }
}
