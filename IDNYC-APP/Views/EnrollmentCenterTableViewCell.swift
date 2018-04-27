//
//  EnrollmentCenterTableViewCell.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/26/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class EnrollmentCenterTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 1
        container.layer.shadowColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0).cgColor
        return container
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana-Bold", size: 22)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()
    
    lazy var hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 14)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "center cell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setupNameLabel()
        setupAddressLabel()
        setupHoursLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
            ])
    }
    
    private func setupAddressLabel() {
        containerView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
            ])
    }
    
    private func setupHoursLabel() {
        containerView.addSubview(hoursLabel)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            hoursLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            hoursLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            hoursLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            ])
    }
    
    public func configureCel(center: IDNYCCenter) {
        nameLabel.text = center.name
        addressLabel.text = "\(center.address1), \(center.city), \(center.zip)"
        guard let hours = center.hours else {
            hoursLabel.text = "Hours not available"
            return
        }
        var formatedHours = hours.replacingOccurrences(of: "<br>", with: "\n").replacingOccurrences(of: "<b>", with: "\n").replacingOccurrences(of: "Mon, Tue, Wed, Thu, Fri", with: "Mon - Fri").replacingOccurrences(of: "Mon-Fri", with: "Mon - Fri").replacingOccurrences(of: "Monday - Friday", with: "Mon - Fri")
        if formatedHours.hasSuffix("\n") {
            formatedHours.removeLast()
        }
        hoursLabel.text = formatedHours
    }
}
