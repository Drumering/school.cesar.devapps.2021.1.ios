//
//  ChampionViewController.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 22/11/21.
//

import UIKit

class ChampionViewController: UIViewController {
    
    @IBOutlet weak var ivChampion: UIImageView!
    @IBOutlet weak var lbTotalAchievements: UILabel!
    
    var champion: String = ""
    var totalAchievements: String = ""
    var worldCups: [WorldCup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivChampion.image = UIImage(named: champion)
        lbTotalAchievements.text = totalAchievements

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

extension ChampionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Total de secoes disponiveis
        return worldCups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Numero de linhas para a secao
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // recuperando o Game que se encontra em algum Match (oitavas de final, quartas, semi...)
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChampionDetailTableViewCell

        let worldCup = worldCups[indexPath.section]
        cell.prepare(with: worldCup)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO opcional: obter um nome para secao
        let worldCup = worldCups[section]
        return "\(worldCup.country), \(worldCup.year)"
    }
}
