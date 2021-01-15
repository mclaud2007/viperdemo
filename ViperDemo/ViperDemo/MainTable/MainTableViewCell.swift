//
//  UserTableViewCell.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    func configure(with user: User?) {
        fullName.text = user?.fullname ?? "-"
        phoneLabel.text = user?.phone ?? "-"
        companyLabel.text = user?.company?.name ?? "N/A"
    }
    
    override func prepareForReuse() {
        fullName.text = nil
        phoneLabel.text = nil
        companyLabel.text = nil
    }    
}
