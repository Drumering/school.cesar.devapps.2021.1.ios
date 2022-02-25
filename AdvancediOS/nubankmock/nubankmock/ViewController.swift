//
//  ViewController.swift
//  nubankmock
//
//  Created by Anderson Mendes de Almeida on 05/02/22.
//

import UIKit

class ViewController: UIViewController, ItemViewDelegate {
    
    var screenTitle: String?
    
    func buttonPressed() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SegundaTela") as! DetailViewController
        vc.screenTitle = screenTitle
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var firstOption: ItemView!
    @IBOutlet weak var secondOption: ItemView!
    @IBOutlet weak var thirdOption: ItemView!
    @IBOutlet weak var fourthOption: ItemView!
    @IBOutlet weak var fifthOption: ItemView!
    @IBOutlet weak var sixthOption: ItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.firstOption.delegate = self
        self.secondOption.delegate = self
        self.thirdOption.delegate = self
        self.fourthOption.delegate = self
        self.fifthOption.delegate = self
        self.sixthOption.delegate = self
        
        firstOption.button.setTitle("Credit Card", for: .normal)
        firstOption.button.setImage(UIImage(systemName: "tornado"), for: .normal)
        
        secondOption.button.setTitle("Investiments", for: .normal)
        thirdOption.button.setTitle("Buy Netflix", for: .normal)
        
        
        fourthOption.button.setTitle("See your cards", for: .normal)
        fourthOption.button.setImage(UIImage(systemName: "creditcard"), for: .normal)
        
        fifthOption.button.setTitle("Buy Amazon", for: .normal)
        sixthOption.button.setTitle("Last option", for: .normal)
    }

}

