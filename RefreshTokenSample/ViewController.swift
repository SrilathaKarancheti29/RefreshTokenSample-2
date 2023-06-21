//
//  ViewController.swift
//  RefreshTokenSample
//
//  Created by Srilatha Karancheti on 2023-06-20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestDataFromAPI()
    }
    
    func requestDataFromAPI() {
        AppServices.shared.apiProvider.request(.logout) { result in
            //Code
        }
    }
}

