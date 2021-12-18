//
//  ConsolesManager.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 04/12/21.
//

import CoreData
class ConsolesManager {
    
    static let shared = ConsolesManager()
    var consoles: [Console] = []
    
    private init() {
        
    }
    
    func loadConsoles(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            consoles = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteConsole(index: Int, context: NSManagedObjectContext) -> Bool {
        let console = consoles[index]
        context.delete(console)
        
        do {
            try context.save()
            consoles.remove(at: index)
            return true
        } catch  {
            print(error.localizedDescription)
            return false
        }
    }
}
