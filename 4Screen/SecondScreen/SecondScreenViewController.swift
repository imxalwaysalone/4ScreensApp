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
class SecondScreenViewController: UIViewController {

    @IBOutlet weak var factsTableView: UITableView! {
        didSet {
            factsTableView.dataSource = self
            factsTableView.delegate = self
        }
    }
    var model = [Facts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.factsTableView.reloadData()
    }
    
    @IBAction func requestButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/facts") else { return }
        var request = URLRequest(url: url)
        request.setValue("a0C9XF9QzLaLK1Yhv7j2Dg==TuWBml33JlnSrqQo", forHTTPHeaderField: "X-Api-Key")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                let decoder = JSONDecoder()
                let fact = try decoder.decode([Facts].self, from: data)
                self.model = fact
            } catch {
               print(error)
            }
        }.resume()
    }
}
extension SecondScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if let dCell = tableView.dequeueReusableCell(withIdentifier: "dCell") {
            cell = dCell
        } else {
            cell = UITableViewCell()
        }
        cell.textLabel?.text = model[indexPath.row].fact
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
