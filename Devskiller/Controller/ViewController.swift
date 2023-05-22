//
//  ViewController.swift
//  Devskiller
//
//  Copyright © 2023 Mindera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var companyInfo: UITextView!
    @IBOutlet weak var launchesScrollView: UIScrollView!
    @IBOutlet weak var launchesTableView: UITableView!
    
    var launches : [Launch] = []
    var filteredLaunches: [Launch] = []
    
    let yearPicker = UIPickerView()
    var selectedYear: String?
    
    let cache = DataCache()
    var darkLightModeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        launchesTableView.delegate = self
        launchesTableView.dataSource = self
        launchesTableView.register(UINib(nibName: "LaunchCell", bundle: nil), forCellReuseIdentifier: LaunchCell().identifier)
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        navigationItem.title = "SpaceX"
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
        
        darkLightModeButton = UIBarButtonItem(image: UIImage(systemName: "sun.max.fill"), style: .plain, target: self, action: #selector(darkLightModeButtonTapped))
        navigationItem.leftBarButtonItem = darkLightModeButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        companyCacheDataChecker()
        launchesCacheDataChecker()
    }
    
    @objc func filterButtonTapped() {
        //Handle filter button tap event
        //Implement filter logic
        filterLaunches()
    }
    
    @objc func darkLightModeButtonTapped() {
        toggleDarkLightMode()
    }
    
}


extension ViewController {
    @objc private func filterLaunches() {
        let alertController = UIAlertController(title: "Filter Launches", message: "Select a year", preferredStyle: .alert)
        
        alertController.view.addSubview(yearPicker)
        yearPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearPicker.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 0),
            yearPicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: 0),
            yearPicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 20),
            yearPicker.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50),
            yearPicker.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        let sortOrderSegmentedControl = UISegmentedControl(items: ["Ascending", "Descneding"])
        sortOrderSegmentedControl.selectedSegmentIndex = 0
        alertController.view.addSubview(sortOrderSegmentedControl)
        sortOrderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortOrderSegmentedControl.leadingAnchor.constraint(equalTo: yearPicker.leadingAnchor, constant: 0),
            sortOrderSegmentedControl.trailingAnchor.constraint(equalTo: yearPicker.trailingAnchor, constant: 0),
            sortOrderSegmentedControl.topAnchor.constraint(equalTo: yearPicker.bottomAnchor, constant: -40),
            sortOrderSegmentedControl.widthAnchor.constraint(equalTo: yearPicker.widthAnchor, constant: 0)
        ])
        
        let filterAction = UIAlertAction(title: "Filter", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.filteredLaunches = self.launches
            if let selectedYear = self.selectedYear {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                self.filteredLaunches = self.filteredLaunches.filter { launch in
                    guard let launchDate = dateFormatter.date(from: launch.date_utc!) else { return false }
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year], from: launchDate)
                    return components.year == Int(selectedYear)
                }
            }
            
            let sortOrder: ComparisonResult = sortOrderSegmentedControl.selectedSegmentIndex == 0 ? .orderedAscending : .orderedDescending
            self.filteredLaunches.sort { launch1, launch2 in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                guard let datelaunch1 = dateFormatter.date(from: launch1.date_utc!),
                      let datelaunch2 = dateFormatter.date(from: launch2.date_utc!) else { return false }
                print(datelaunch1.compare(datelaunch2) == sortOrder)
                return datelaunch1.compare(datelaunch2) == sortOrder
            }
            
            self.filteredLaunches = self.filteredLaunches
            
            DispatchQueue.main.async {
                self.launchesTableView.reloadData()
            }
        }
        alertController.addAction(filterAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Year \(row + 2010)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = "\(row + 2010)"
    }
}
