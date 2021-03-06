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
    var icon: UIImage
    var id: Int
    var iconID: String

    init(temperature: Double, min: Double, max: Double, state: String, date: Date, pressure: Double, humidity: Int, clouds: Int, speed: Double, night: Double, eve: Double, morn: Double, icon: UIImage, id: Int, iconID: String) {
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
        self.icon        = icon
        self.id          = id
        self.iconID      = iconID
    }

    init?(dictionary: [String : Any]) {
        guard
            let temperatureDictionary = dictionary["temp"] as? [String : Any],
            let weatherDictionaryList = dictionary["weather"] as? [[String : Any]],
            let pressure = dictionary["pressure"] as? Double,
            let humidity = dictionary["humidity"] as? Int,
            let clouds = dictionary["clouds"] as? Int,
            let speed = dictionary["speed"] as? Double,
            let dt = dictionary["dt"] as? TimeInterval,

            let temperature = temperatureDictionary["day"] as? Double,
            let min = temperatureDictionary["min"] as? Double,
            let max = temperatureDictionary["max"] as? Double,
            let night = temperatureDictionary["night"] as? Double,
            let eve = temperatureDictionary["eve"] as? Double,
            let morn = temperatureDictionary["morn"] as? Double,

            let description = weatherDictionaryList.first!["description"] as? String,
            let icon = weatherDictionaryList.first!["icon"] as? String
        else {
            return nil
        }

        self.temperature = temperature
        self.min         = min
        self.max         = max
        self.state       = description
        self.date        = Date(timeIntervalSince1970: dt)
        self.pressure    = pressure
        self.humidity    = humidity
        self.clouds      = clouds
        self.speed       = speed
        self.night       = night
        self.eve         = eve
        self.morn        = morn
        self.icon        = UIImage()
        self.id          = 0
        self.iconID      = icon


    }
}

var days = [WeatherForecast]()
var country = String()
var city = String()

func parseData(JSONData: Data) {
    do {

        days = [WeatherForecast]()

        let redeableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : AnyObject]

        //first I get the data for the Header
        if let ci = redeableJSON["city"] {
            let co = ci["country"]
            let name = ci["name"]
            country = co! as! String
            city = name! as! String
        }

        if let list = redeableJSON["list"] as? [[String: AnyObject]] {

            var dateC = Date()

            for i in 0..<list.count {
                if (i > 0) {
                    dateC = dateC.addingTimeInterval(86400)
                }

                let item = list[i]

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

                if let weathers = item["weather"] as? [[String : AnyObject]] {
                    let weather = weathers[0]
                    let description = weather["description"]
                    let icon = weather["icon"]
                    let iconID = weather["icon"]
                    let id = weather["id"]

                    let imageData = makeURL(icon: icon as! String)

                    let mainIconURL = URL(string: imageData)
                    let mainIconData = NSData (contentsOf: mainIconURL!)

                    let mainIcon = UIImage(data: mainIconData as! Data)

                    let w = WeatherForecast(temperature: day!! as! Double, min: min!! as! Double, max: max!! as! Double, state: description! as! String, date: dateC as Date, pressure: pressure! as! Double, humidity: humidity! as! Int, clouds: clouds! as! Int, speed: speed! as! Double, night: night!! as! Double, eve: eve!! as! Double, morn: morn!! as! Double, icon: mainIcon as UIImage!, id: id! as! Int, iconID: iconID! as! String)

                    days.append(w)
                }
            }

            //If is needed I convert the temperatures to Farenheit
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
