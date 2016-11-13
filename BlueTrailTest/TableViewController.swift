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
    
    let clocale = Locale.current.usesMetricSystem
    
    func convertirCaF(tcelsius: Double) -> Double {
        return (tcelsius * 1.8) + 32
    }
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            parseData(JSONData: response.data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.headerLabel.text = "Weather in " + city + ", " + country
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableViewAutomaticDimension
        callAlamo(url: apiURL)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")
        
        let dayLabel = cell?.viewWithTag(1) as! UILabel
        dayLabel.text =  days[indexPath.row].date
        
        let tempLabel = cell?.viewWithTag(2) as! UILabel
        if (clocale == true) {
        tempLabel.text = String(days[indexPath.row].temperature) + "°C"
        }
        else {
            tempLabel.text = String(format:"%.02f", convertirCaF(tcelsius: days[indexPath.row].temperature)) + "°F"
        }
        
        let statusLabel = cell?.viewWithTag(3) as! UILabel
        statusLabel.text = days[indexPath.row].state
        
        let maxLabel = cell?.viewWithTag(4) as! UILabel
        if (clocale == true) {
            maxLabel.text = "Max " + String(days[indexPath.row].max)
        }
        else {
            maxLabel.text = "Max " + String(format:"%.02f", convertirCaF(tcelsius: days[indexPath.row].max))
        }
        
        let minLabel = cell?.viewWithTag(5) as! UILabel
        if (clocale == true) {
            minLabel.text = "Min " + String(days[indexPath.row].min)
        }
        else {
            minLabel.text = "Min " + String(format:"%.02f", convertirCaF(tcelsius: days[indexPath.row].min))
        }
        
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
