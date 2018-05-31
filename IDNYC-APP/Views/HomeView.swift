//
//  HomeView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    lazy var IDNYCHomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "IDNYCHome")
        return imageView
    }()
    
    lazy var whatIsIDNYCButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        button.setTitle("What is IDNYC?", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var documentCheckerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        button.setTitle("Document Checker", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var benefitsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        button.setTitle("Benefits", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        button.layer.cornerRadius = 10
        return button
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
        setupIDNYCImageView()
        setupWhatIsIDNYCButton()
        setupDocumentCheckerButton()
        setupBenefitsButton()
    }
    
    private func setupIDNYCImageView() {
        addSubview(IDNYCHomeImageView)
        let desiredImageWidth: CGFloat = 0.8
        IDNYCHomeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            IDNYCHomeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            IDNYCHomeImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: desiredImageWidth),
            IDNYCHomeImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: (300/660)*desiredImageWidth),
            IDNYCHomeImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    
    private func setupWhatIsIDNYCButton() {
        addSubview(whatIsIDNYCButton)
        whatIsIDNYCButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whatIsIDNYCButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            whatIsIDNYCButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.13),
            whatIsIDNYCButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            whatIsIDNYCButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupDocumentCheckerButton() {
        addSubview(documentCheckerButton)
        documentCheckerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            documentCheckerButton.topAnchor.constraint(equalTo: whatIsIDNYCButton.bottomAnchor, constant: 16),
            documentCheckerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            documentCheckerButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.13),
            documentCheckerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupBenefitsButton() {
        addSubview(benefitsButton)
        benefitsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            benefitsButton.topAnchor.constraint(equalTo: documentCheckerButton.bottomAnchor, constant: 16),
            benefitsButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            benefitsButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.13),
            benefitsButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    func setEnglish() {
        whatIsIDNYCButton.setTitle("What is IDNYC?", for: .normal)
        documentCheckerButton.setTitle("Document Checker", for: .normal)
        benefitsButton.setTitle("Benefits", for: .normal)
    }
    
    func setSpanish() {
        whatIsIDNYCButton.setTitle("¿Que es IDNYC?", for: .normal)
        documentCheckerButton.setTitle("Chequeo de Documentos", for: .normal)
        benefitsButton.setTitle("Beneficios", for: .normal)
    }
    
}
