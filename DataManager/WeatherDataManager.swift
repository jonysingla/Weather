//
//  WeatherDataManager.swift
//  WeatherDemo
//
//  Created by PanshulK on 13/10/18.
//  Copyright © 2018 Jony Singla. All rights reserved.
//

import UIKit
import Alamofire

class WeatherDataManager: NSObject {
    
    // for getting response
    func WeatherDataManager(viewControllerName: UIViewController,cityID: Int, appId: String, callBack : @escaping ((_ isSuccess : Bool, _ errroMessage : String?, _ responserData : NSDictionary?) -> ()))
    {
        let Completeurl = Common_Domain  + "\(cityID),&APPID=\(appId)"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(Completeurl, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)")                      // serialized json response
                if let data = response.data,
                    let _ = String(data: data, encoding: .utf8) {
                    if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                    {
                        if((dictionary.object(forKey: "cod") as! String) == "200")
                        {
                            callBack(true, dictionary.object(forKey: "message") as? String, dictionary )
                        }
                        else
                        {
                            callBack(false, dictionary.object(forKey: "message") as? String, nil)
                        }
                    }
                    else
                    {
                        callBack(false, "Something went wrong with the server. Please try again.",nil)
                    }
                }
                
            }
        }
    }
}
