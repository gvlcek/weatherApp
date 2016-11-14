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
    var pressure: Double
    var humidity: Int
    var clouds: Int
    var speed: Double
    var night: Double
    var eve: Double
    var morn: Double
    
    init(temperature: Double, min: Double, max: Double, state: String, date: Date, pressure: Double, humidity: Int, clouds: Int, speed: Double, night: Double, eve: Double, morn: Double) {
        self.temperature = temperature
        self.min         = min
        self.max         = max
        self.state       = state
        self.date        = date
        self.pressure    = pressure
        self.humidity    = humidity
        self.clouds      = clouds
        self.speed       = speed
        self.night       = night
        self.eve         = eve
        self.morn        = morn
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
                    
                    let pressure = item["pressure"]
                    let humidity = item["humidity"]
                    let clouds = item["clouds"]
                    let speed = item["speed"]
                    
                    
                    let temp = item["temp"]

                    let day = temp?["day"]
                    let min = temp?["min"]
                    let max = temp?["max"]
                    
                    let night = temp?["night"]
                    let eve = temp?["eve"]
                    let morn = temp?["morn"]
                    
                    if let weathers = item["weather"] {
                        let weather = weathers[0] as! [String : AnyObject]
                        let description = weather["description"]
                        
                        let w = WeatherForecast(temperature: day!! as! Double, min: min!! as! Double, max: max!! as! Double, state: description! as! String, date: dateC as Date, pressure: pressure! as! Double, humidity: humidity! as! Int, clouds: clouds! as! Int, speed: speed! as! Double, night: night!! as! Double, eve: eve!! as! Double, morn: morn!! as! Double)
                        
                        days.append(w)
                    }
                }
                
                if (clocale != true) {
                    for i in 0..<days.count {
                        days[i].temperature = convertCtF(tcelsius: days[i].temperature)
                        days[i].max = convertCtF(tcelsius: days[i].max)
                        days[i].min = convertCtF(tcelsius: days[i].min)
                        days[i].night = convertCtF(tcelsius: days[i].night)
                        days[i].eve = convertCtF(tcelsius: days[i].eve)
                        days[i].morn = convertCtF(tcelsius: days[i].morn)
                    }
                }
            }
        }
        catch{
            print(error)
        }

    }
