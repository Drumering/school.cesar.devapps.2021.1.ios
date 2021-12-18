//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Anderson Mendes de Almeida on 18/12/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "YOUR_CLIENT_ID")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // let signInConfig = GIDConfiguration.init(clientID: "com.googleusercontent.apps.133536822916-657e6ppe8vd5fu7o6b30ap38e3ugv2rh")
        
    }

    @IBAction func signIn(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
          }
    }
    
    @IBAction func correctGSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
        }
    }
    
    
}

