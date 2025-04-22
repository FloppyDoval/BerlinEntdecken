//
//  InfoViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//

import UIKit


class InfoViewController: UIViewController {
    // Properties
    var landmarkTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = landmarkTitle
    }
}
