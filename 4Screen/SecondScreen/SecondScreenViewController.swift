//
//  SecondScreenViewController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 5.07.23.
//

import UIKit

class SecondScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("jopa")
        // Do any additional setup after loading the view.
    }
    @IBAction func requestButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/facts?limit=") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
               print(error)
            }
        }.resume()
    }
}
