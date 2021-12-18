//
//  GamesTableViewController.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 03/12/21.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {
    
    var fetchedResultController:NSFetchedResultsController<Game>!
    
    var label = UILabel()
    
    // tip. podemos passar qual view vai gerenciar a busca. Neste caso a própria viewController (logo usei nil)
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        label.text = "Você não tem jogos cadastrados"
        label.textAlignment = .center
        
        navigationItem.searchController = searchController
        
        // usando extensions
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        loadGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func loadGames(filtering: String = "") {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if !filtering.isEmpty {
            // usando predicate: conjunto de regras para pesquisas
            // contains [c] = search insensitive (nao considera letras identicas)
            let predicate = NSPredicate(format: "title contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
        
        // possui
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch  {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultController?.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: game)
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
            guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(game)
            
            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    //Mais opcoes com as funcoes de swipe
    /*
     override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
         guard let game = self.fetchedResultController.fetchedObjects?[indexPath.row] else {return}
         self.context.delete(game)
         
         do {
         try self.context.save()
         } catch  {
         print(error.localizedDescription)
         }
         }
         
         let inserItem = UIContextualAction(style: .normal, title: "Insert") { (UIContextualAction, view, boolValue) in
         print("Inserindo algo")
         }
         
         deleteItem.backgroundColor = .systemRed
         inserItem.backgroundColor = .systemBlue
         
         let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, inserItem])
         
         return swipeActions
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
            let game = fetchedResultController?.fetchedObjects?[tableView.indexPathForSelectedRow!.row]
            vc.game = game
        } else if let vc = segue.destination as? AddEditViewController {
            vc.state = States.addingGame
        }
    }
    

}

extension GamesTableViewController: NSFetchedResultsControllerDelegate {
    
    // sempre que algum objeto for modificado esse metodo sera notificado
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                
                // optamos por nao colocar a animacao da delecao aqui porque caso usemos
                // o modo de Rule Delete em Cascade na tabela games -> para propagar as exclusoes,
                // entao esse metodo nao é uma boa opcao porque pode ocorrer crashes.
                
                print("nao chamando a animacao porque temos mais de uma exclusao \(indexPath)")
            }
            break
        default:
            print("--> atualiza apos inserir dados <--")
            tableView.reloadData()
        }
    }
}

extension GamesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadGames()
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
