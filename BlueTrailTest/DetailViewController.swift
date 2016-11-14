//
//  DetailViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 13/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var eveningLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    
    var weatherForecast: WeatherForecast!
    
    override func viewDidLoad() {

        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .full
        dateLabel.text = dateFormatter.string(from: weatherForecast.date)
        
        if (clocale == true) {
            tempLabel.text = String(weatherForecast.temperature) + "°C"
            statusLabel.text = weatherForecast.state
            maxLabel.text = "Max " + String(weatherForecast.max)
            minLabel.text = "Min " + String(weatherForecast.min)
            
        }
        else {
            tempLabel.text = String(format:"%.00f", weatherForecast.temperature) + "°F"
            statusLabel.text = weatherForecast.state
            maxLabel.text = "Max " + String(format:"%.00f", weatherForecast.max)
            minLabel.text = "Min " + String(format:"%.00f", weatherForecast.min)
        }
        
        morningLabel.text = "Morning " + String(format:"%.02f", weatherForecast.morn)
        eveningLabel.text = "Evening " + String(format:"%.02f", weatherForecast.eve)
        nightLabel.text = "Night " + String(format:"%.02f", weatherForecast.night)
        
        humidityLabel.text = "Humidity " + String(weatherForecast.humidity) + "%"
        pressureLabel.text = "Pressure " + String(weatherForecast.pressure) + " hPa"
        cloudsLabel.text = "Clouds " + String(weatherForecast.clouds)
        speedLabel.text = "Speed " + String(weatherForecast.speed)
        
        
    }
    
}
