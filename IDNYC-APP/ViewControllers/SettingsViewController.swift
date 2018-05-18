//
//  SettingsViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class SettingsViewController: UIViewController, SFSafariViewControllerDelegate {

    let settingsView = SettingsView()
    
    let options:[String] = ["Change Language","About IDNYC","Feedback", "Visit Official Site"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
        view.addSubview(settingsView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)! ]
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = options[indexPath.row]
        switch selection {
        case "Change Language":
            changeLanguagePressed()
        case "About IDNYC":
            aboutIDNYCPressed()
        case "Feedback":
            feedbackPressed()
        case "Visit Official Site":
            visitOfficialSitePressed()
        default:
            print("error")
        }
    }
    
    func changeLanguagePressed() {
        
    }
    
    func aboutIDNYCPressed() {
        let aboutIDNYCVC = AboutIDNYCViewController()
        navigationController?.pushViewController(aboutIDNYCVC, animated: true)
    }
    
    func feedbackPressed() {
        let mailComposeViewController = self.configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("This iPhone does not have email setup!")
        }
    }
    
    func visitOfficialSitePressed() {
        let IDNYCwebUrl = "http://www1.nyc.gov/site/idnyc/index.page"
        let sfSafariVC: SFSafariViewController = SFSafariViewController(url: URL(string: IDNYCwebUrl)!)
        sfSafariVC.delegate = self
        sfSafariVC.modalTransitionStyle = .crossDissolve
        sfSafariVC.modalPresentationStyle = .fullScreen
        present(sfSafariVC, animated: true, completion: nil)
    }
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["luiscalle@ac.c4q.nyc"])
        mailComposerVC.setSubject("Feedback")
        mailComposerVC.setMessageBody("Message", isHTML: false)
        
        return mailComposerVC
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings cell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Verdana", size: 18)!
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
