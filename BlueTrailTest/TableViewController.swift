//
//  TableViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b"
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            parseData(JSONData: response.data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.headerLabel.text = "Weather in " + city + ", " + country
            
            
            let imageView =  UIImageView(image: UIImage(named: days[0].iconID))
            self.tableView.backgroundView = imageView
            
            imageView.contentMode = .scaleAspectFill
            
            /*let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = imageView.bounds
            imageView.addSubview(blurView)*/
            
        })
    }
    
    override func viewDidLoad() {
        askPermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callAlamo(url: apiURL)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = .clear
            cell.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")
        
        let dayLabel = cell?.viewWithTag(1) as! UILabel
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("ed")
        dayLabel.text = dateFormatter.string(from: days[indexPath.row].date)
        
        let statusLabel = cell?.viewWithTag(3) as! UILabel
        statusLabel.text = days[indexPath.row].state
        
        let tempLabel = cell?.viewWithTag(2) as! UILabel
        if (clocale == true) {
        tempLabel.text = String(days[indexPath.row].temperature) + "°C"
        }
        else {
            tempLabel.text = String(format:"%.00f", days[indexPath.row].temperature) + "°F"
        }
        
        let maxLabel = cell?.viewWithTag(4) as! UILabel
        if (clocale == true) {
            maxLabel.text = "Max " + String(days[indexPath.row].max)
        }
        else {
            maxLabel.text = "Max " + String(format:"%.00f", days[indexPath.row].max)
        }
        
        let minLabel = cell?.viewWithTag(5) as! UILabel
        if (clocale == true) {
            minLabel.text = "Min " + String(days[indexPath.row].min)
        }
        else {
            minLabel.text = "Min " + String(format:"%.00f", days[indexPath.row].min)
        }
        
        let iconImage = cell?.viewWithTag(6) as! UIImageView
        iconImage.image = days[indexPath.row].icon
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let
            vc = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        if indexPath[1] != 6 {
            if days[((indexPath as NSIndexPath).row) + 1 ].id < 700  /*SEE http://openweathermap.org/weather-conditions FOR DETAILS */ {
                launchNotification(notificationDate: days[((indexPath as NSIndexPath).row) + 1 ].date)
            }
        }
        
        let forecast: WeatherForecast = days[(indexPath as NSIndexPath).row]
        vc.weatherForecast = forecast
    }

}
