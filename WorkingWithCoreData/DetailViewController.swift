//
//  DetailViewController.swift
//  WorkingWithCoreData
//
//  Created by Justin Richardson on 2018-11-07.
//  Copyright © 2018 Justin Richardson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    var name: String = ""
    var age: Int16 = 0
    var indexPath: Int = 0
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        ageLabel.text = String(age)
    }
    
    // MARK: - Functions
    func performUpdate() {
        if let nameString = nameLabel.text, let ageString = ageLabel.text {
            name = nameString
            guard let ageInt = Int16(ageString) else { return }
            age = ageInt
        }
    }

}
