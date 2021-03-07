//
//  DetailViewController.swift
//  Covid-19App
//
//  Created by Rahul Muthuswamy on 2/28/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var covidStateModel: StateCovidModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print(covidStateModel?.stateName ?? "")
    }
    
    
    
}
