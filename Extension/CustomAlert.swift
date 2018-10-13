//
//  CustomAlert.swift
//  WeatherDemo
//
//  Created by PanshulK on 13/10/18.
//  Copyright © 2018 Jony Singla. All rights reserved.
//

import UIKit

class CustomAlert: NSObject {
    
    class func showAlertMsg(message: String, viewController: UIViewController)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
