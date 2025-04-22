//
//  PracticeViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//

import UIKit

// Enum for practice types
enum PracticeType {
    case nominativ
    case akkusativ
    case dativ
}

// MARK: - Practice View Controller
class PracticeViewController: UIViewController {
    // Properties
    var practiceType: PracticeType = .akkusativ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Practice \(practiceType)"
    }
}

