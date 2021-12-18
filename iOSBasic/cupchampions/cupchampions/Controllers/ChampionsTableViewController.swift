//
//  ChampionsTableViewController.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 20/11/21.
//

import UIKit

class ChampionsTableViewController: UITableViewController {
    
    var worldCups: [WorldCup] = []
    var allWorldCups: [WorldCup] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        worldCups = Reader.loadWorldCups()
        allWorldCups = worldCups
        worldCups = worldCups.uniqued()
        worldCups.sort(by: { (lhs, rhs) -> Bool in
            return lhs.winner < rhs.winner
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return worldCups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChampionTableViewCell

        let worldCup = worldCups[indexPath.row]
        cell.prepare(worldCup: worldCup)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let winner = worldCups[tableView.indexPathForSelectedRow!.row]
        
        //nome do vencedor selecionado
        //numero de copas conquistadas
        //quais foram as conquistas
        
        let selectedWinner = winner.winner
        let whichWins = allWorldCups.filter { (worldCup) -> Bool in
            return worldCup.winner == winner.winner
        }
        let howManyWins = whichWins.count
        
        if let vc = segue.destination as? ChampionViewController {
            vc.champion = selectedWinner
            vc.totalAchievements = String(howManyWins)
            vc.worldCups = whichWins
        }
    }

}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
