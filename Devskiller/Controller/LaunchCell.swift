//
//  LaunchCell.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {
    
    @IBOutlet weak var patchImage: UIImageView!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var launchState: UIImageView!
    @IBOutlet weak var missionDateAndTime: UILabel!
    @IBOutlet weak var rocketNameAndType: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    let identifier = "LaunchCell"
    let cache = DataCache()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with launch: Launch) {
        missionName.text = launch.name
        launchState.image = (launch.success ?? false) ? UIImage(named: "success") : UIImage(named: "failure")
        
        missionDateAndTimeHandler(launch: launch)
        launchDateHandler(launch: launch)
        patchImageHandler(launch: launch)
        
        //Bring rocket data
        if let rocketData: Rocket = cache.load(key: launch.rocket!) {
            rocketNameAndType.text = "\(rocketData.name) / \(rocketData.type)"
            print("used cached Rocket data!")
        } else {
            fetchRocket(rocketID: launch.rocket!)
            print("used API Rocket data!")
        }
    }
}

extension LaunchCell {
    
    func missionDateAndTimeHandler(launch: Launch) {
        // Separate Date and Time to be displayed under missionDateAndTime label
        if let separatedComponents = Constants().separateDateAndTime(from: launch.date_utc!) {
            let date = separatedComponents.date
            let time = separatedComponents.time
            
            missionDateAndTime.text = "\(date) at \(time)"
        } else {
            print("Invalid date and time string")
        }
    }
    
    func launchDateHandler(launch: Launch) {
        let (days, prefix) = Constants().calculateDays(from: launch.date_utc!)
        
        if let days = days {
            launchDate.text = "\(days)"
            launchDateLabel.text = prefix
        } else {
            print("Failed to calculate the number of days")
        }
    }
    
    func patchImageHandler(launch: Launch) {
        //Load the launch image from the provided url
        if let imageURL = launch.links?.patch?.small {
            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.patchImage.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    func fetchRocket(rocketID: String) {
        APIRequest(from: Constants().BASE_URL.appendingPathComponent(Constants().rocketUrl), rocketID: rocketID) { [weak self] (result: Result<Rocket, Error>) in
            switch result {
                case .success(let rocket):
                DispatchQueue.main.async {
                    self?.rocketNameAndType.text = "\(rocket.name) / \(rocket.type)"
                    self?.cache.save(key: rocketID, data: rocket)
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
