//
//  ChampionDetailTableViewCell.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 23/11/21.
//

import UIKit

class ChampionDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepare(with worldCup: WorldCup) {
        ivWinner.image = UIImage(named: worldCup.winner)
        ivVice.image = UIImage(named: worldCup.vice)
        lbScore.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
    }
    
}
