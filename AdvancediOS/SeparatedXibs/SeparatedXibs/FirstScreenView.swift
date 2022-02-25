//
//  FirstScreenView.swift
//  SeparatedXibs
//
//  Created by Anderson Mendes de Almeida on 23/02/22.
//

import UIKit

protocol FirstScreenDelegate {
    func buttonPressed()
}

class FirstScreenView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var delegate: FirstScreenDelegate?
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
    }
    
    func commonInit() {
         Bundle.main.loadNibNamed("FirstScreenView",
                                owner: self,
                              options: nil)
         self.contentView.fixInView(self)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.delegate?.buttonPressed()
    }
    
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = true;
        self.frame = container.frame;
        container.addSubview(self);
    }
}
