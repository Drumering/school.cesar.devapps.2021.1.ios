//
//  ConsoleTableViewCell.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 06/12/21.
//

import UIKit

class ConsoleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbConsole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with console: Console) {
        lbConsole.text = console.name ?? ""
        if let image = console.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
    }

}
