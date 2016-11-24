//
//  auxFuc.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 13/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UserNotifications

let dateFormatter = DateFormatter()

let clocale = Locale.current.usesMetricSystem

func convertCtF(tcelsius: Double) -> Double {
    return (tcelsius * 1.8) + 32
}

func makeURL(icon: String) -> String {
    return "http://www.openweathermap.org/img/w/" + icon + ".png"
}

func askPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
        
        if granted {
            print("ok")
        } else {
            print(error?.localizedDescription as Any)
        }
    })
}

func launchNotification(){
    let localNotification = UNMutableNotificationContent()
    
    localNotification.title = "Weather forecast"
    localNotification.body = "It looks like it will rain tomorrow ☔️"
    
    let theTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
    let request = UNNotificationRequest(identifier: "myNotification", content: localNotification, trigger: theTrigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        if error != nil{
        print(error)
        }
    })
}
