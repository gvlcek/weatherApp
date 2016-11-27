//
//  backgroundFetch.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 26/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Alamofire

var backgroundId = [Int]()

func backgroundAlamo() {
    Alamofire.request("http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b").responseJSON(completionHandler: {
        response in
        parseBackground(JSONData: response.data!)
    })
}

func parseBackground(JSONData: Data) {
    do {
        let redeableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : AnyObject]
        
        if let list = redeableJSON["list"] as? [[String: AnyObject]] {

            for i in 0..<list.count {
                
                let item = list[i]
                
                if let weathers = item["weather"] as? [[String : AnyObject]] {
                    let weather = weathers[0]
                    let id = weather["id"]
                    backgroundId.append(id! as! Int)
                }
            }
        }
        
        //It's the [1] cause it checks if it will rain the next day
        //700 it's the condition id, see openweathermap.org/weather-conditions
        if (backgroundId[1]) < 700 {
            let currentDate = Date()
            //if it would rain the next day it schedules a notification that day at 8.00 am
            launchNotification(notificationDate: currentDate.addingTimeInterval(86400))
        }
    }
    catch{
        print(error)
    }
}
