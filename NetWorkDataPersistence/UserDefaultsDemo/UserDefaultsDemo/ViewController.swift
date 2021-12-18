//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Anderson Mendes de Almeida on 18/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbexample: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set("Coding Explorer", forKey: "key")
    }
    
    @IBAction func btnRecuperarValor(_ sender: UIButton) {
        if let valorRecuperado = UserDefaults.standard.string(forKey: "key"){
            lbexample.text = valorRecuperado
        } else {
            lbexample.text = "User Default Sample"
        }
    }

    @IBAction func btnRemoverValor(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "key")
    }
    
}

