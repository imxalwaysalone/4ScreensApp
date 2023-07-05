//
//  ViewModel.swift
//  4Screen
//
//  Created by Владимир Дроздов on 4.07.23.
//

import Foundation

class ViewModel {
    let defaults = UserDefaults.standard
    
    static let shared = ViewModel()
    struct UserData:Codable {
        var savedText: String
        var name:String {
            return "\(savedText)"
        }
    }
        
        var savedData:[UserData] {
            
            get {
                if let data = defaults.value(forKey: "savedData") as? Data {
                    return try! PropertyListDecoder().decode([UserData].self, from: data)
                } else {
                    return [UserData]()
                }
            }
            set {
                if let data = try? PropertyListEncoder().encode(newValue) {
                    defaults.set(data, forKey: "savedData")
                }
            }
        }
        
        func saveText(savedText:String) {
            let text = UserData(savedText: KeysDefaults.keyText)
            savedData.insert(text, at: 0)
        }
    }
