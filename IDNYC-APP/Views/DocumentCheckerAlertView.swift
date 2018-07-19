//
//  DocumentCheckerAlertView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 7/18/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerAlertView: UIView {
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var successMessageLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
        self.insideView.layer.cornerRadius = 5
        self.insideView.layer.borderWidth = 1
        self.insideView.layer.borderColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0).cgColor
    }
}
