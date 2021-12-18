//
//  GameViewController.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 03/12/21.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var ivConsoleCover: UIImageView!
    @IBOutlet weak var ctHeightIvConsoleCover: NSLayoutConstraint!
    @IBOutlet weak var ctWidthIvConsoleCover: NSLayoutConstraint!
    
    var game: Game?
    var console: Console?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let game = game {
            setupItem(with: game)
            return
        } else if let console = console {
            setupItem(with: console)
        }
    }
    
    //MARK: - Functions
    
    func setupItem(with item: Game) {
        lbTitle.text = item.title
        lbConsole.text = "Console: \(item.console?.name ?? "Sem registro")"
        ivConsoleCover.image = item.console?.cover as? UIImage
        if let releaseDate = item.releaseDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbReleaseDate.text = "Lançamento: " + formatter.string(from: releaseDate)
        }

        if let image = item.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }

    func setupItem(with item: Console) {
        lbTitle.text = item.name
        lbConsole.isHidden = true
        ctWidthIvConsoleCover.constant = 0
        ctHeightIvConsoleCover.constant = 0
        if let releaseDate = item.releaseDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbReleaseDate.text = "Lançamento: " + formatter.string(from: releaseDate)
        }

        if let image = item.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? AddEditViewController {
            if let game = game {
                vc.game = game
                vc.state = States.editingGame
            } else if let console = console {
                vc.console = console
                vc.state = States.editingConsole
            }
        }
    }
    

}
