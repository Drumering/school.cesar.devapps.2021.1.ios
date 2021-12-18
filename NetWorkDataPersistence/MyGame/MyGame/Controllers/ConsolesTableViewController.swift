//
//  ConsolesTableViewController.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 03/12/21.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        label.text = "Você não tem jogos cadastrados"
        label.textAlignment = .center
        
        loadConsoles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadConsoles()
    }
    
    func loadConsoles() {
        ConsolesManager.shared.loadConsoles(with: context)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    /*
    @IBAction func addPlatform(_ sender: Any) {
        showAlert(with: nil)
    }
    
    func showAlert(with console: Console?) {
        let title = console == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Nome da plataforma"
            
            if let name = console?.name {
                textField.text = name
            }
        })
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            let console = console ?? Console(context: self.context)
            console.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsoles()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        
        present(alert, animated: true, completion: nil)
    }
 */
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = ConsolesManager.shared.consoles.count
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConsoleTableViewCell
        let console = ConsolesManager.shared.consoles[indexPath.row]
        cell.prepare(with: console)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if ConsolesManager.shared.deleteConsole(index: indexPath.row, context: context) {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let console = ConsolesManager.shared.consoles[indexPath.row]
        showAlert(with: console)
        
        // deselecionar atual cell
        tableView.deselectRow(at: indexPath, animated: false)
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
        if let vc = segue.destination as? ItemViewController {
            let console = ConsolesManager.shared.consoles[tableView.indexPathForSelectedRow!.row]
            vc.console = console
        } else if let vc = segue.destination as? AddEditViewController {
            vc.state = States.addingConsole
        }
    }
    

}
