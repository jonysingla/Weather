//
//  Connectivity.swift
//  WeatherDemo
//
//  Created by PanshulK on 13/10/18.
//  Copyright © 2018 Jony Singla. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
