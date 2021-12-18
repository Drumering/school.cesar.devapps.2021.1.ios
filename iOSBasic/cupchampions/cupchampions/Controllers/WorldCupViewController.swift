//
//  WorldCupViewController.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 06/11/21.
//

import UIKit

class WorldCupViewController: UIViewController {
    
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var ivVice: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbWinner: UILabel!
    @IBOutlet weak var lbVice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var worldCup: WorldCup?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let worldCup = worldCup {
            title = "WorldCup \(worldCup.year)"
            ivWinner.image = UIImage(named: worldCup.winner)
            ivVice.image = UIImage(named: worldCup.vice)
            lbScore.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
            lbWinner.text = worldCup.winner
            lbVice.text = worldCup.vice
        }
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

extension WorldCupViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Total de secoes disponiveis
        return worldCup?.matches.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Numero de linhas para a secao
        return worldCup?.matches[section].games.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // recuperando o Game que se encontra em algum Match (oitavas de final, quartas, semi...)
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        
        if let match = worldCup?.matches[indexPath.section] {
            let game = match.games[indexPath.row]
            cell.prepare(with: game)
        }
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO opcional: obter um nome para secao
        return worldCup?.matches[section].stage ?? " "
    }
}
