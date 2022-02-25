//
//  ItemView.swift
//  nubankmock
//
//  Created by Anderson Mendes de Almeida on 25/02/22.
//

import UIKit

protocol ItemViewDelegate {
    var screenTitle: String? { get set }
    func buttonPressed()
}

class ItemView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    var delegate: ItemViewDelegate?
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
    }
    
    func commonInit() {
         Bundle.main.loadNibNamed("ItemView",
                                owner: self,
                              options: nil)
         self.contentView.fixInView(self)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.screenTitle = sender.title(for: .normal)!
        self.delegate?.buttonPressed()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = true;
        self.frame = container.frame;
        container.addSubview(self);
    }
}
