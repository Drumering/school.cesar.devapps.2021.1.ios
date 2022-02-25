//
//  ViewController.swift
//  SeparatedXibs
//
//  Created by Anderson Mendes de Almeida on 23/02/22.
//

import UIKit

class ViewController: UIViewController, FirstScreenDelegate {
    
    func buttonPressed() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SegundaTela") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }

    @IBOutlet weak var firstScreen: FirstScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.firstScreen.delegate = self
    }


}

