//
//  ViewController.swift
//  Vertragsmanager
//
//  Created by Tim Meyerdiercks on 11.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contractTableView: UITableView!
    
    var category: [String] = ["Auto", "Telefon", "Haus", "Versicherungen"]
    var images = ["car", "telefon", "home", "versicherungen"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNewContractButton_Tapped(_ sender: UIBarButtonItem) {
        let chooseCategoryAction = UIAlertController(title: "Kategorie", message: "Bitte wähle eine Kategorie aus.", preferredStyle: .alert)
        
        for index in 0..<category.count {
            chooseCategoryAction.addAction(createAlertAction(category: category[index]))
        }
        
        self.present(chooseCategoryAction, animated: true, completion: nil)
    }
    
    
    func createAlertAction(category: String) -> UIAlertAction {
        let action = UIAlertAction(title: category, style: .default) { (action) in
            let CategoryAsString = action.title!
            
            self.createAlertForUserData(category: CategoryAsString)
        } 
        
        return action
    }
    
    
    func createAlertForUserData(category: String) {
        let alert = UIAlertController(title: "Vertrag hinzufügen", message: nil, preferredStyle:    .alert)
        
        // Name
        alert.addTextField { (nameTextField) in
            
        }
        
        // Preis
        alert.addTextField { (priceTextField) in
            
        }
        
        // Start vom Vertrag
        alert.addTextField { (startTextField) in
            
        }
        
        // Dauer vom Vertrag
        alert.addTextField { (durationTextField) in
            
        }
        
        // Ende vom Vertrag
        alert.addTextField { (endTextField) in
            
        }
        
        let saveAction = UIAlertAction(title: "Speichern", style: .default) { (saveAction) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .default) { (cancelAction) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.count(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        return cell
    }
    
    
    // Angeben wie viele sectionen wir brauchen. Den Rest (wie die sectionen alle aussehen sollen macht dann die UITableViewDataSource function.)
    func numberOfSections(in tableView: UITableView) -> Int {
        return category.count
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238 / 255, green: 92 / 255, blue: 66 / 255, alpha: 0.8)
        
        // Bild erstellen und in den Header jeder Section einfügen
        let image = UIImage(named: images[section])
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        view.addSubview(imageView)
        
        // Label erstellen und zum View hinzufügen
        let label = UILabel()
        label.text = category[section]
        label.font = UIFont(name: "Din Alternate", size: 25)
        label.frame = CGRect(x: 40, y: 5, width: 200, height: 30)
        view.addSubview(label)
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

