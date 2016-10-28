//
//  TableViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

/* API http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b */

import UIKit

class TableViewController: UITableViewController {
    
    let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b"
    var forecasts = [weatherForecast]()
    let weather = obtainForecast()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableViewAutomaticDimension
        weather.callAlamo(url: apiURL)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
