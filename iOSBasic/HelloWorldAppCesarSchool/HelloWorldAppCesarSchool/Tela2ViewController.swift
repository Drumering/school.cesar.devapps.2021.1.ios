//
//  Tela2ViewController.swift
//  HelloWorldAppCesarSchool
//
//  Created by Anderson Mendes de Almeida on 05/11/21.
//

import UIKit

class Tela2ViewController: UIViewController {

    @IBOutlet weak var isHappyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(String(describing: self)) - viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(String(describing: self)) - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(String(describing: self)) - viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(String(describing: self)) - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(String(describing: self)) - viewDidDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        print("\(String(describing: self)) - didReceiveMemoryWarning")
    }
    
    @IBAction func fecharTela(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func isHappy(_ sender: Any) {
        if let switchButton = sender as? UISwitch {
            isHappyLabel.text = switchButton.isOn ? "acionado 😀" : "Liga ae mano!"
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
