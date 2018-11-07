//
//  PersonCell.swift
//  WorkingWithCoreData
//
//  Created by Justin Richardson on 2018-11-01.
//  Copyright © 2018 Justin Richardson. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK: - Functions
    func configure(with person: Person) {
        self.nameLabel.text = person.name
        self.ageLabel.text = String(person.age)
    }

}
