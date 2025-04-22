//
//  SavedWordsViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//
import UIKit

class WordDetailViewController: UIViewController {
    // Properties
    var word: String = ""
    var translation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = word
    }
}

