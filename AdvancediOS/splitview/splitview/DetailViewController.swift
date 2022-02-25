//
//  DetailViewController.swift
//  splitview
//
//  Created by Anderson Mendes de Almeida on 25/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var item: Item? {
        didSet { refreshUI() }
    }
    private func refreshUI() {
        loadViewIfNeeded()
        label.text = item?.description
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

extension DetailViewController: ItemSelectionDelegate {
    func itemSelected(_ newItem: Item) {
        item = newItem
    }
}
