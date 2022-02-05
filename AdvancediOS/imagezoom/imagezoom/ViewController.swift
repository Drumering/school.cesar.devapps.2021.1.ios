//
//  ViewController.swift
//  imagezoom
//
//  Created by Anderson Mendes de Almeida on 05/02/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var ivToZoom: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivToZoom
    }


}

