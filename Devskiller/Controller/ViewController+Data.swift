//
//  ViewController+Data.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func companyCacheDataChecker() {
        if let companyData: Company = cache.load(key: "company") {
            self.companyInfo.text = "\(companyData.name) was founded by \(companyData.founder) in \(companyData.founded). it has now \(companyData.employees) employees, \(companyData.launch_sites) launch sites, and is valued at \(Constants().formatAsCurrency(number: companyData.valuation, currencyCode: "USD") ?? "")"
            print("used cached Company data!")
        } else {
            fetchCompany()
            print("used API Company data!")
        }
    }
    
    func launchesCacheDataChecker() {
        if let launchesData: [Launch] = cache.load(key: "launches") {
            print("used cached Launches data!")
            self.launches = launchesData
            self.launchesTableView.reloadData()
        } else {
            fetchLaunch()
            print("used API Launches data!")
        }
    }
    
    func fetchCompany() {
        APIRequest(from: Constants().BASE_URL.appendingPathComponent(Constants().companyUrl)) { (result: Result<Company, Error>) in
            switch result {
                case .success(let company):
                DispatchQueue.main.async {
                    self.companyInfo.text = "\(company.name) was founded by \(company.founder) in \(company.founded). it has now \(company.employees) employees, \(company.launch_sites) launch sites, and is valued at \(Constants().formatAsCurrency(number: company.valuation, currencyCode: "USD") ?? "")"
                    self.cache.save(key: "company", data: company)
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchLaunch() {
        APIRequest(from: Constants().BASE_URL.appendingPathComponent(Constants().launchUrl)) { [weak self] (result: Result<[Launch], Error>) in
            switch result {
                case .success(let launches):
                DispatchQueue.main.async {
                    self?.launches = launches
                    self?.launchesTableView.reloadData()
                    self?.cache.save(key: "launches", data: launches)
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
