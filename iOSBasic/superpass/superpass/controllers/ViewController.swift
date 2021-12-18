//
//  ViewController.swift
//  superpass
//
//  Created by Anderson Mendes de Almeida on 20/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    @IBOutlet weak var btnGeraSenha: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitches()
        setupNumberOfCharacters()
        setupTotalPasswords()
        setupBtnGerarSenha()
    }
    
    func alertHandler(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupBtnGerarSenha() {
        btnGeraSenha.addTarget(self, action: #selector(onClickBtnGerarSenha), for: .touchUpInside)
    }
    
    @objc func onClickBtnGerarSenha(_ button: UIButton) {
        if (tfTotalPasswords.text?.isEmpty ?? true) || (tfNumberOfCharacters.text?.isEmpty ?? true) {
            alertHandler(with: "Please, some fields were left empty, the default values were used")
        }
    }
    
    func setupNumberOfCharacters() {
        tfNumberOfCharacters.addTarget(self, action: #selector(onEditNumberOfCharacters), for: .editingDidEnd)
    }
    
    @objc func onEditNumberOfCharacters(_ textField: UITextField) {
        if (textField.text?.isEmpty ?? true) || (Int(textField.text ?? "1") ?? 0) > 16 {
            alertHandler(with: "Please, insert a value between 1 and 16.")
        }
    }
    
    func setupTotalPasswords() {
        tfTotalPasswords.addTarget(self, action: #selector(onEditTotalPassWords), for: .editingDidEnd)
    }
    
    @objc func onEditTotalPassWords(_ textField: UITextField){
        if (Int(textField.text!) ?? 1) <= 0 || (Int(textField.text!) ?? 1) > 99 {
            alertHandler(with: "Please, insert a value between 1 and 99. ")
        }
    }
    
    func setupSwitches() {
        // Do any additional setup after loading the view.
        
        swLetters.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
        
        swNumbers.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
        
        swSpecialCharacters.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
        
        swCaptitalLetters.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
    }
    
    @objc func onSwitchValueChanged(_ switch: UISwitch) {
        verifySwitches()
    }
    
    func verifySwitches() {
        if !swNumbers.isOn, !swLetters.isOn, !swCaptitalLetters.isOn, !swSpecialCharacters.isOn {
            btnGeraSenha.isHidden = true
            alertHandler(with: "Please, select an option to generate the password")
        } else {
            btnGeraSenha.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PasswordViewController
               
                if let numberOfPasswords = Int(tfTotalPasswords.text!) {
                    vc.numberOfPasswords = numberOfPasswords
                }
                if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
                    vc.numberOfCharacters = numberOfCharacters
                }
                vc.useNumbers = swNumbers.isOn
                vc.useCapitalLetters = swCaptitalLetters.isOn
                vc.useLetters = swLetters.isOn
                vc.useSpecialCharacters = swSpecialCharacters.isOn
        
        view.endEditing(true)
    }
}

