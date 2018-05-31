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

extension Notification.Name {
    static let english = Notification.Name("English")
    static let spanish = Notification.Name("Spanish")
}

class SettingsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    let settingsView = SettingsView()
    let languagePickerView = UIPickerView()
    var dummyTextField: UITextField!
    var currentLanguage: String!
    
    let options:[String] = ["Change Language","About IDNYC", "Feedback", "Visit Official Site"]
    let options_es:[String] = ["Cambiar Idioma","Sobre IDNYC", "Opiniónes", "Visitar el Sitio Oficial"]
    let languages: [String] = ["English", "Español"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLanguage = LanguageUserDefaultsHelper.manager.getSelectedLanguage() ?? "English"
        dummyTextField = UITextField(frame: .zero)
        view.addSubview(dummyTextField)
        view.addSubview(settingsView)
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
        languagePickerView.delegate = self
        languagePickerView.delegate = self
        setupLanguagePickerViewToolbar()
        setupNavBar()
    }

    private func setupNavBar() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage()! == "English" {
            navigationItem.title = "Settings"
        } else {
            navigationItem.title = "Opciones"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)! ]
    }
    
    private func setupLanguagePickerViewToolbar() {
        languagePickerView.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(pickerDonePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerPressed))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dummyTextField.inputView = languagePickerView
        dummyTextField.inputAccessoryView = toolBar
    }
    
    @objc private func pickerDonePressed() {
        print("Done")
        let indexPicked = languagePickerView.selectedRow(inComponent: 0)
        currentLanguage = languages[indexPicked]
        LanguageUserDefaultsHelper.manager.saveSelectedLanguage(language: currentLanguage)
        dummyTextField.resignFirstResponder()
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage()! == "English" {
            navigationItem.title = "Settings"
            NotificationCenter.default.post(name: .english, object: nil)
        } else {
            navigationItem.title = "Opciones"
            NotificationCenter.default.post(name: .spanish, object: nil)
        }
        settingsView.settingsTableView.reloadData()
    }
    
    @objc private func cancelPickerPressed() {
        print("Cancel")
        dummyTextField.resignFirstResponder()
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = options[indexPath.row]
        switch selection {
        case "Change Language", "Cambiar Idioma":
            changeLanguagePressed()
        case "About IDNYC", "Sobre IDNYC":
            aboutIDNYCPressed()
        case "Feedback", "Opiniónes":
            feedbackPressed()
        case "Visit Official Site", "Visitar el Sitio Oficial":
            visitOfficialSitePressed()
        default:
            print("error")
        }
    }
    
    func changeLanguagePressed() {
        print("change language pressed")
        print(currentLanguage)
        dummyTextField.becomeFirstResponder()
//        UIView.animate(withDuration: 0.2) {
//            self.settingsView.languagePickerView.frame = CGRect(x: 0, y: self.view.bounds.size.height - self.settingsView.languagePickerView.bounds.size.height - (self.tabBarController?.tabBar.frame.size.height)!, width: self.settingsView.languagePickerView.bounds.size.width, height: self.settingsView.languagePickerView.bounds.size.height)
//        }
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
            print("Email not available")
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
        mailComposerVC.setMessageBody("", isHTML: false)
        
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
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage()! == "English" {
            cell.textLabel?.text = options[indexPath.row]
        } else {
            cell.textLabel?.text = options_es[indexPath.row]
        }
        return cell
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected: \(languages[row])")
    }
}
