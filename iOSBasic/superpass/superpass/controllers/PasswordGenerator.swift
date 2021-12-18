//
//  PasswordGenerator.swift
//  superpass
//
//  Created by Anderson Mendes de Almeida on 20/11/21.
//

import Foundation

class PasswordGenerator {
    var numberOfCharacters: Int = 0
    var useLetters: Bool
    var useNumbers: Bool
    var useCapitalLetters: Bool
    var useSpecialCharacters: Bool
    
    var passwords: [String] = []
    
    private let letters = "abcdefghijklmnopqrstuvwxyz"
    private let specialCharacters = "!@#$%^&*()_-+=~`|]}[{':;?/<>.,"
    private let numbers = "1234567890"
    
    init(numberOfCharacters: Int, useLetters: Bool, useNumbers: Bool, useCapitalLetters: Bool, useSpecialLetters: Bool) {
           
            var numchars = min(numberOfCharacters, 16)
            numchars = max(numchars, 1)
           
            self.numberOfCharacters = numchars
            self.useLetters = useLetters
            self.useNumbers = useNumbers
            self.useCapitalLetters = useCapitalLetters
            self.useSpecialCharacters = useSpecialLetters
    }
    
    func generate(total: Int) -> [String] {
        
            passwords.removeAll()
        
            var universe: String = ""
           
            if useLetters {
                universe += letters
            }
           
            if useNumbers {
                universe += numbers
            }
           
            if useSpecialCharacters {
                universe += specialCharacters
            }
           
            if useCapitalLetters {
                universe += letters.uppercased()
            }
           
            let universeArray = Array(universe)
            while passwords.count < total {
                var password = ""
                for _ in 1...numberOfCharacters {
                    // obtem um indice aleatorio do universo escolhido
                    let index = Int(arc4random_uniform(UInt32(universeArray.count)))
                    password += String(universeArray[index])
                }
                passwords.append(password)
            }
           
           
            return passwords
        }
}
