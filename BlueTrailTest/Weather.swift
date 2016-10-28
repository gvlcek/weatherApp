//
//  WeatherData.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class weatherForecast {
    let temperature: Double
    let date: Date
    let min: Double
    let max: Double
    let state: String
    let iconState: String
    
    lazy var icon: UIImage = { return UIImage(named: self.iconState)! }()
    
    init(temperature: Double, date: Date, min: Double, max: Double, state: String, iconState: String) {
        self.temperature = temperature
        self.date        = date
        self.min         = min
        self.max         = max
        self.state       = state
        self.iconState   = iconState
    }
}

let forecasts = [weatherForecast]()

class obtainForecast {
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            let redeableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : AnyObject]
            //print(redeableJSON)
            
            if let list = redeableJSON["list"] {
                //print(list)
                for i in 0..<list.count {
                    let item = list[i] as! [String : AnyObject]
                    print(item["temp"])
                }
                
            }
            
        }
        catch{
            print(error)
        }
    }
    
}
