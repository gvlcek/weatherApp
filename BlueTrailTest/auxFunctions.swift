//
//  auxFuc.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 13/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UserNotifications

//AUXILIARY FUNCTIONS

//This is the dateFormatter used to change the dates way of display
let dateFormatter = DateFormatter()

//I use this constant to check if I have to use C or F
let clocale = Locale.current.usesMetricSystem

//Convert celsius to fahrenheit
func convertCtF(tcelsius: Double) -> Double {
    return tcelsius.convertToFahrenheit()
}

extension Double {
    func convertToCelsius() -> Double {
        return (self - 32.0) * 5.0/9.0
    }

    func convertToFahrenheit() -> Double {
        return (self * 1.8) + 32
    }


}

//This is where I make the URL
func makeURL(icon: String) -> String {
    return "http://www.openweathermap.org/img/w/" + icon + ".png"
}

//Function to allow the app to send notifications
func askPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
        if granted {
        } else {
            print(error?.localizedDescription as Any)
        }
    })
}

//schedule the notifications
func launchNotification(){
    let localNotification = UNMutableNotificationContent()
    localNotification.title = "Weather forecast"
    localNotification.body = "It looks like it will rain tomorrow ☔️"
    
    let chronoTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "myNotification", content: localNotification, trigger: chronoTrigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        if error != nil{
        print("error")
        } else {
        print("notification scheduled")
        }
    })
}


//Function to decompose the date and set the time at 8 am
func makeDateTime(date: Date) -> DateComponents {
    var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    dateComponents.hour =  8
    dateComponents.minute = 0
    return dateComponents
}

//schedule the notifications
func launchNotification(notificationDate: Date){
    let localNotification = UNMutableNotificationContent()
    localNotification.title = "Weather forecast"
    localNotification.body = "It looks like it will rain today ☔️"
    
    let chronoTrigger = UNCalendarNotificationTrigger(dateMatching: makeDateTime(date: notificationDate), repeats: false)
    
    let request = UNNotificationRequest(identifier: "myNotification", content: localNotification, trigger: chronoTrigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        if error != nil{
            print("error")
        } else {
            print("notification scheduled")
        }
    })
}
