//
//  backgroundFetch.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 26/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Alamofire
import Foundation

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
                    
                    print(id!)
                }
            }
        }
    }
    catch{
        print(error)
    }
    
}