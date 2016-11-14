//
//  WeatherData.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit

class WeatherForecast {
    var temperature: Double
    var min: Double
    var max: Double
    var state: String
    var date:  Date
    
    init(temperature: Double, min: Double, max: Double, state: String, date: Date) {
        self.temperature = temperature
        self.min         = min
        self.max         = max
        self.state       = state
        self.date        = date
    }
}

var days = [WeatherForecast]()
var country = String()
var city = String()

    func parseData(JSONData: Data) {
        do {
            
            days = [WeatherForecast]()
            
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
                    if (i > 0) {
                        dateC = dateC.addingTimeInterval(86400)
                    }
                    
                    let item = list[i] as! [String : AnyObject]
                    
                    let temp = item["temp"]

                    let day = temp?["day"]
                    let min = temp?["min"]
                    let max = temp?["max"]
                    
                    if let weathers = item["weather"] {
                        let weather = weathers[0] as! [String : AnyObject]
                        let description = weather["description"]
                        
                        let w = WeatherForecast(temperature: day!! as! Double, min: min!! as! Double, max: max!! as! Double, state: description! as! String, date: dateC as Date)
                        
                        days.append(w)
                    }
                }
                
                if (clocale != true) {
                    for i in 0..<days.count {
                        days[i].temperature = convertCtF(tcelsius: days[i].temperature)
                        days[i].max = convertCtF(tcelsius: days[i].max)
                        days[i].min = convertCtF(tcelsius: days[i].min)
                    }
                }
            }
        }
        catch{
            print(error)
        }

    }
