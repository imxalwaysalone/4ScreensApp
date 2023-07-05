//
//  FirstScreenViewController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 4.07.23.
//

import UIKit

class FirstScreenViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var infoTableView: UITableView! {
        didSet {
            infoTableView.dataSource = self
            infoTableView.delegate = self
        }
    }
    @IBOutlet weak var propertiesOfButton: UIButton!
    @IBOutlet weak var textToSave: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToSave.text = defaults.string(forKey: KeysDefaults.keyText)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.infoTableView.reloadData()
    }
    @IBAction func saveButton(_ sender: Any) {
        let savedText = textToSave.text!
        
        if !savedText.isEmpty {
            ViewModel.shared.saveText(savedText: KeysDefaults.keyText)
        }
    }
}
extension FirstScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.shared.savedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if let dCell = tableView.dequeueReusableCell(withIdentifier: "dCell") {
            cell = dCell
        } else {
            cell = UITableViewCell()
        }
        cell.textLabel?.text = ViewModel.shared.savedData[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
