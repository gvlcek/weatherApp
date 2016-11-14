//
//  WeatherData.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit

class weatherForecast {
    var temperature: Double
    let min: Double
    let max: Double
    let state: String
    let date:  String
    
    init(temperature: Double, min: Double, max: Double, state: String, date: String) {
        self.temperature = temperature
        self.min         = min
        self.max         = max
        self.state       = state
        self.date        = date
    }
}

var days = [weatherForecast]()
var country = String()
var city = String()

    func parseData(JSONData: Data) {
        do {
            
            days = [weatherForecast]()
            
            let redeableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : AnyObject]
            
            if let ci = redeableJSON["city"] {
                let co = ci["country"]
                let name = ci["name"]
                country = co! as! String
                city = name! as! String
            }
            
            if let list = redeableJSON["list"] {
                
                var dateC = Date()
                
                for i in 0..<list.count {
                    let dateFormatter = DateFormatter()
                    if (i > 0) {
                        dateC = dateC.addingTimeInterval(86400)
                    }
                    dateFormatter.locale = Locale.current
                    dateFormatter.setLocalizedDateFormatFromTemplate("ed")
                    
                    let item = list[i] as! [String : AnyObject]
                    
                    let temp = item["temp"]

                    let day = temp?["day"]
                    let min = temp?["min"]
                    let max = temp?["max"]
                    
                    if let weathers = item["weather"] {
                        let weather = weathers[0] as! [String : AnyObject]
                        let description = weather["description"]
                        
                        let w = weatherForecast(temperature: day!! as! Double, min: min!! as! Double, max: max!! as! Double, state: description! as! String, date: dateFormatter.string(from: dateC) as String)
                        
                        days.append(w)
                    }
                }
            }
        }
        catch{
            print(error)
        }

    }
