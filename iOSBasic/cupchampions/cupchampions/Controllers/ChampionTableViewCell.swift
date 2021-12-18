//
//  ChampionTableViewCell.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 20/11/21.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var lbWinner: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(worldCup: WorldCup){
        
        ivWinner.image = UIImage(named: worldCup.winner)
        lbWinner.text = worldCup.winner
        
    }

}
