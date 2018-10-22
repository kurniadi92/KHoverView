//
//  ViewController.swift
//  KHoverView
//
//  Created by Kurniadi on 14/10/18.
//  Copyright © 2018 Kurniadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func openTapped(_ sender: Any) {
        KHoverViewController.showHoverView(parent: self)
    }
    
}

