//
//  LanguageUserDefaultsHelper.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation


enum UserDefaultsKeys: String {
    case selectedLanguage
}

class LanguageUserDefaultsHelper {
    
    private init() { }
    static let manager = LanguageUserDefaultsHelper()
    
    func saveSelectedLanguage(language: String) {
        UserDefaults.standard.setValue(language, forKey: UserDefaultsKeys.selectedLanguage.rawValue)
    }
    
    func getSelectedLanguage() -> String? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.selectedLanguage.rawValue) as? String
    }

}
