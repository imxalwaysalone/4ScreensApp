//
//  ThirdScreenViewController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 5.07.23.
//

import UIKit

class ThirdScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionButton(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "isWebViewShown")
        let vc = FourthScreenViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
