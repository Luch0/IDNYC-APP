//
//  WhatISIDNYCView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/4/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class WhatIsIDNYCView: UIView {
    
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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What is IDNYC?"
        return label
    }()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana", size: 21)
        label.numberOfLines = 0
        label.text = """
        IDNYC is the new, free identification card for all New York City residents, which gives all of us the opportunity to show who we are—New Yorkers. As a government-issued photo identification card, IDNYC secures the peace of mind and access to City services that come from having recognized identification. IDNYC benefits every city resident, including the most vulnerable communities—the homeless, youth, the elderly, undocumented immigrants, the formerly incarcerated and others who may have difficulty obtaining other government-issued ID.
        
        IDNYC cardholders can access services and programs offered by the City as well as by businesses. IDNYC helps enhance public safety, by serving as a recognized ID for interacting with NYPD. It also helps New Yorkers gain access to all City buildings that provide services to the public and is accepted as a form of identification for accessing numerous City programs and services. IDNYC also provides a dynamic series of benefits to cardholders, including a free one-year membership at many of the City's leading museums, zoos, concert halls, and botanical gardens.
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
        //setupTitleLabel()
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
    
    func setSpanish() {
        descriptionText.text = """
        IDNYC es una tarjeta gratuita de identificación para todos los residentes de la Ciudad de Nueva York, lo que nos da a todos la oportunidad de mostrar lo que somos-Neoyorquinos. Como una tarjeta de identificación con foto emitida por el gobierno, IDNYC asegura la tranquilidad y el acceso a los servicios municipales que vienen de tener identificación reconocido. IDNYC beneficia a todos los residentes de la ciudad, incluidos los más vulnerables comunidades las personas sin hogar, los jóvenes, los ancianos, los inmigrantes indocumentados, el ex convicto y otros que pueden tener dificultades para obtener otro tipo de identificación emitida por el gobierno.
        
        los titulares de tarjetas IDNYC pueden acceder a los servicios y programas que ofrece la ciudad, así como por las empresas. IDNYC ayuda a mejorar la seguridad pública, al servir como un documento de identidad reconocido para interactuar con policía de Nueva York. También ayuda a los neoyorquinos a obtener acceso a todos los edificios municipales que proveen servicios al público y se acepta como una forma de identificación para el acceso a numerosos programas y servicios de la Ciudad. IDNYC también proporciona una serie dinámica de beneficios a los titulares de tarjetas, incluyendo una suscripción gratuita de un año en muchos de los principales museos de la ciudad, parques zoológicos, salas de conciertos, y los jardines botánicos.
        """
    }
    
    func setEnglish() {
        descriptionText.text = """
        IDNYC is the new, free identification card for all New York City residents, which gives all of us the opportunity to show who we are—New Yorkers. As a government-issued photo identification card, IDNYC secures the peace of mind and access to City services that come from having recognized identification. IDNYC benefits every city resident, including the most vulnerable communities—the homeless, youth, the elderly, undocumented immigrants, the formerly incarcerated and others who may have difficulty obtaining other government-issued ID.
        
        IDNYC cardholders can access services and programs offered by the City as well as by businesses. IDNYC helps enhance public safety, by serving as a recognized ID for interacting with NYPD. It also helps New Yorkers gain access to all City buildings that provide services to the public and is accepted as a form of identification for accessing numerous City programs and services. IDNYC also provides a dynamic series of benefits to cardholders, including a free one-year membership at many of the City's leading museums, zoos, concert halls, and botanical gardens.
        """
    }
    
}
