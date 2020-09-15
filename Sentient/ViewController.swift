//
//  ViewController.swift
//  Sentient
//
//  Created by StartupBuilder.INFO on 9/15/20.
//  Copyright © 2020 StartupBuilder.INFO. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    
    let classifier = TweetSentimentClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func predict(_ sender: UIButton) {
        if let text = textInput.text {
            let prediction = try! classifier.prediction(text: text)
            let sentiment = SentimentResult(rawValue: prediction.label)
            resultLabel.text = sentiment?.face
        }
    }
    
}

enum SentimentResult: String {
    case pos = "Pos", neutral = "Neutral", neg = "Neg"
}

extension SentimentResult {
    
    var face: String {
        switch self {
        case .neg:
            return "🤬"
        case .pos:
            return "😻"
        case .neutral:
            return "😑"
        }
    }
}
