//
//  ViewController.swift
//  ClassQuote
//
//  Created by Simon Dahan on 14/09/2020.
//  Copyright © 2020 Simon Dahan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToQuoteLabel()
        // Do any additional setup after loading the view.
    }
    
    private func addShadowToQuoteLabel() {
        quoteLabel.layer.shadowColor = UIColor.black.cgColor
        quoteLabel.layer.shadowOpacity = 0.9
        quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    @IBAction func tappedNewQuoteButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        
        QuoteService.shared.getQuote { (success, quote) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let quote = quote {
                self.quoteLabel.text = quote.text
                self.authorLabel.text = quote.author
            } else {
                let alertVC = UIAlertController(title: "Erreur", message: "Une erreur c'est produite !", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        newQuoteButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
}

