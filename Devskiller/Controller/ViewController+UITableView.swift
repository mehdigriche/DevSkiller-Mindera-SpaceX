//
//  ViewController+UITableView.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = launchesTableView.dequeueReusableCell(withIdentifier: LaunchCell().identifier, for: indexPath) as! LaunchCell
        
        let launch = launches[indexPath.row]
        cell.configure(with: launch)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Deselect the row after it is selected
        launchesTableView.deselectRow(at: indexPath, animated: true)
        //Show Alert
        showAlert(launch: launches[indexPath.row])
    }
}
