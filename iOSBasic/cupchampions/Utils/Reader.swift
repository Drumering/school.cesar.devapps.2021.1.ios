//
//  Reader.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 20/11/21.
//

import Foundation

struct Reader {
    
    static func loadWorldCups() -> [WorldCup] {
          let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
          let jsonData = try! Data(contentsOf: fileURL)
           
          do {
            return try JSONDecoder().decode([WorldCup].self, from: jsonData)
          } catch  {
              print(error.localizedDescription)
          }
        
        return []
    }
}
