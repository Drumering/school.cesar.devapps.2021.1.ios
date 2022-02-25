//
//  DetailViewController.swift
//  nubankmock
//
//  Created by Anderson Mendes de Almeida on 25/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    var screenTitle: String?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = screenTitle

        // Do any additional setup after loading the view.
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
