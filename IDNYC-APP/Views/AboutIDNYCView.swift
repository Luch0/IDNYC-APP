//
//  AboutIDNYCView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class AboutIDNYCView: UIView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var fullContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 1
        view.layer.shadowColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0).cgColor
        return view
    }()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana", size: 21)
        label.numberOfLines = 0
        label.text = """
        New York City residents are now able to sign up for IDNYC – a government-issued identification card that is available to all City residents age 14 and older. Immigration status does not matter. Mayor Bill de Blasio announced this initiative in his State of the City address in January 2014 and less than one year later proudly launched the largest municipal identification card program in the nation.
        
        All New York City residents age 14 and older can get an IDNYC card. Applicants must complete an application and submit it at an IDNYC Enrollment Center. Applicants are also required to present proof of identity and residency in New York City. Many types of documents are accepted, all of which are listed on the documentation page. You must submit your application and proof of identity and residency in person at an IDNYC Enrollment Center or an IDNYC Pop-Up Enrollment Center, which travels to neighborhoods across the City. After you apply for the card, it will be sent to you in the mail.
        
        The IDNYC card is free for all New Yorkers who apply through December 31, 2018. Cards are valid for five years from the date the application is approved. The application process is accessible to people with limited English proficiency and people with disabilities.
        
        The IDNYC card is an accessible and secure document that enables residents to access City services and grant admission to City buildings, such as schools. In addition, the card can be presented as proof of identification for interacting with the police and is an accepted form of identification for opening a banking account at select financial institutions.
        
        You are able to use your IDNYC card at any public library in New York. The card can be integrated with your account at the New York, Brooklyn, and Queens Public Library Systems. This is the first time a single card can be utilized across all three systems. To use your IDNYC card at a library, ask a librarian or a library clerk at your local branch to connect your IDNYC card with your library account or sign up for a new library account and use your IDNYC card as your library card.
        
        Furthermore, a number of additional benefits are available to IDNYC cardholders including the opportunity to sign up for free one-year memberships at 40 of the city's leading museums, zoos, concert halls, and botanical gardens. The IDNYC card offers a full package of exciting benefits that includes discounts on movie tickets, sporting events, prescription drugs, fitness and health centers, supermarkets, and New York City attractions. The card is also accepted at a number of banks and credit unions in the city to open a bank account.
        """
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        setupScrollView()
        setupContentView()
        setupDescriptionLabel()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(fullContentView)
        fullContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullContentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            fullContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            fullContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            fullContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            fullContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
    }
    
    private func setupDescriptionLabel() {
        fullContentView.addSubview(descriptionText)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: fullContentView.topAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: fullContentView.leadingAnchor, constant: 8),
            descriptionText.trailingAnchor.constraint(equalTo: fullContentView.trailingAnchor, constant: -8),
            descriptionText.bottomAnchor.constraint(equalTo: fullContentView.bottomAnchor, constant: -8),
            ])
    }

}
