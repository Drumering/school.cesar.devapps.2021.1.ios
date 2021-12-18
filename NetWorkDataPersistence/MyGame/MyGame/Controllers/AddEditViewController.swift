//
//  AddEditViewController.swift
//  MyGame
//
//  Created by Anderson Mendes de Almeida on 03/12/21.
//

import UIKit
import Photos

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfConsole: UITextField!
    @IBOutlet weak var ctHeightTfConsole: NSLayoutConstraint!
    @IBOutlet weak var dpReleaseDate: UIDatePicker!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btCover: UIButton!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game?
    var console: Console?
    
    var state: States?
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    var consolesManager = ConsolesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        consolesManager.loadConsoles(with: context)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareDataLayout()
    }
    
    func prepareDataLayout() {
        switch state {
        case .editingGame:
            title = "Editar jogo"
            btAddEdit.setTitle("ALTERAR", for: .normal)
            tfTitle.text = game?.title
            
            // tip. alem do console pegamos o indice atual para setar o picker view
            if let console = game?.console, let index = consolesManager.consoles.firstIndex(of: console) {
                tfConsole.text = console.name
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            ivCover.image = game?.cover as? UIImage
            if let releaseDate = game!.releaseDate {
                dpReleaseDate.date = releaseDate
            }
            if game!.cover != nil {
                btCover.setTitle(nil, for: .normal)
            }
        case .editingConsole:
            title = "Editar console"
            ctHeightTfConsole.constant = 0
            btAddEdit.setTitle("ALTERAR", for: .normal)
            tfTitle.text = console?.name
            ivCover.image = console?.cover as? UIImage
            if let releaseDate = console!.releaseDate {
                dpReleaseDate.date = releaseDate
            }
            if console!.cover != nil {
                btCover.setTitle(nil, for: .normal)
            }
        case .addingConsole:
            title = "Adicionar novo console"
            ctHeightTfConsole.constant = 0
            tfTitle.placeholder = "Nome do console"
        default:
            print("Test editing")
        }
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        // tip. faz o text field exibir os dados predefinidos pela picker view
        tfConsole.inputView = pickerView
        tfConsole.inputAccessoryView = toolbar
    }
    
    @objc func cancel() {
        tfConsole.resignFirstResponder()
    }
    
    @objc func done() {
        tfConsole.text = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)].name
        cancel()
    }

    
    //MARK: - Actions
    
    @IBAction func AddEditCover(_ sender: UIButton) {
        // para adicionar uma imagem da biblioteca
        
        print("para adicionar uma imagem da biblioteca")
        
        
        let alert = UIAlertController(title: "Selecinar capa", message: "De onde você quer escolher a capa?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addEditGame(_ sender: UIButton) {
        // acao salvar novo ou editar existente
        
        switch state {
        case .addingGame:
            game = Game(context: context)
            prepareGame(with: game!)
        case .addingConsole:
            console = Console(context: context)
            prepareConsole(with: console!)
        case .editingGame:
            prepareGame(with: game!)
        case .editingConsole:
            prepareConsole(with: console!)
        default:
            print("Test adding")
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        // Back na navigation
        navigationController?.popViewController(animated: true)
    }
    
    func prepareGame(with game: Game){
        game.title = tfTitle.text
        game.releaseDate = dpReleaseDate.date
        
        if !tfConsole.text!.isEmpty {
            let console = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)]
            game.console = console
        }
        game.cover = ivCover.image
    }
    
    func prepareConsole(with console: Console){
        console.name = tfTitle.text
        console.releaseDate = dpReleaseDate.date
        console.cover = ivCover.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.chooseImageFromLibrary(sourceType: sourceType)
                    
                } else {
                    
                    print("unauthorized -- TODO message")
                }
            })
        } else if photos == .authorized {
            
            self.chooseImageFromLibrary(sourceType: sourceType)
        } else  if photos == .denied {
            print("Sugerir para usuario dar permissao")
        }
    }
    
    func chooseImageFromLibrary(sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.tintColor = UIColor(named: "main")
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consolesManager.consoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let console = consolesManager.consoles[row]
        return console.name
    }
}

extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // ImageView won't update with new image
            // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.ivCover.image = pickedImage
                self.ivCover.setNeedsDisplay()
                self.btCover.setTitle(nil, for: .normal)
                self.btCover.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
