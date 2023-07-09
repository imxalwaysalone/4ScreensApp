//
//  SecondScreenViewController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 5.07.23.
//

import UIKit

struct Facts : Decodable {
    var fact : String
}
enum NetworkingErrors: Error {
    case errorParsingJSON
    case noInternetConnection
    case dataReturnedNil
    case returnedError(Error)
    case invalidStatusCode(Int)
    case customError(String)
}

class SecondScreenViewController: UIViewController {
    @IBOutlet weak var factLabel: UILabel!
    
    var model = [Facts]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/facts") else {
            print( "Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("a0C9XF9QzLaLK1Yhv7j2Dg==TuWBml33JlnSrqQo", forHTTPHeaderField: "X-Api-Key")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print ("Network error: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Invalid status code: \(response.statusCode)")
                    return
                }
            }
            
            guard let data = data else {
                print ("Data returned nil")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                let decoder = JSONDecoder()
                let factsArray = try decoder.decode([Facts].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.factLabel.text = factsArray.first?.fact
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
    
}


