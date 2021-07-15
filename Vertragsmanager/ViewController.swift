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
    
    // MARK: Variablen
    var startTextField = UITextField()
    let datePicker = UIDatePicker()
    var endTextField = UITextField()
    
    
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
            nameTextField.placeholder = "Name"
            
        }
        
        // Preis
        alert.addTextField { (priceTextField) in
            priceTextField.placeholder = "Preis in € pro Monat"
            priceTextField.keyboardType = .decimalPad
            
            // Add Target to this TextField
            priceTextField.addTarget(self, action: #selector(self.priceTextFieldChange(_:)), for: .editingDidEnd)
            
            priceTextField.addTarget(self, action: #selector(self.priceTextFieldChange2(_:)), for: .editingDidBegin)
            
        }
        
        // Start vom Vertrag
        alert.addTextField { (startTextField) in
            startTextField.placeholder = "Vertragsbeginn"
            startTextField.addTarget(self, action: #selector(self.openCalendarFunction(_:)), for: .touchDown)

        }
        
        // Dauer vom Vertrag
        alert.addTextField { (durationTextField) in
            durationTextField.placeholder = "Vertragsdauer in Monaten"
            durationTextField.keyboardType = .numberPad
            
            durationTextField.addTarget(self, action: #selector(self.calculateEndDate(_:)), for: .editingDidEnd)
        }
        
        // Ende vom Vertrag
        alert.addTextField { (endTextField) in
            self.endTextField = endTextField
            endTextField.placeholder = "Vertrags Ende"
                
        }
        
        let saveAction = UIAlertAction(title: "Speichern", style: .default) { (saveAction) in
            let name = self.checkUserInput(value: alert.textFields![0].text)
            let price = self.checkUserInput(value: alert.textFields![1].text)
            let contractBegin = self.checkUserInput(value: alert.textFields![2].text)
            let contractDurationTime = self.checkUserInput(value: alert.textFields![3].text)
            let contractend = self.checkUserInput(value: alert.textFields![4].text)
            
            CoreDataManager.shared.addNewVertragItem(category: category, name: name, price: price, contractBegin: contractBegin, contractDuration: contractDurationTime, contractEnd: contractend)
            
            self.contractTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .default) { (cancelAction) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

    }
    
    
    @objc func priceTextFieldChange(_ textfield: UITextField) {
        if !(textfield.text!.isEmpty) {
            textfield.text = textfield.text! + "€ im Monat"
        }
    }
    
    @objc func priceTextFieldChange2(_ textfield: UITextField) {
        textfield.text = ""
    }
    

    @objc func openCalendarFunction(_ textField: UITextField) {
        startTextField = textField
        datePicker.datePickerMode = .date
        textField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.addTarget(self, action: #selector(self.handleDatePicker(_:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(_ uiDatePickerView: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale(identifier: "de_DE")
        let dateAsString = dateFormatter.string(from: uiDatePickerView.date)
        
        startTextField.text = dateAsString
    }
    
    @objc func calculateEndDate(_ textField: UITextField) {
        if !(textField.text!.isEmpty) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = Locale(identifier: "de_DE")
            
            let days = Int(textField.text!)! * 30
            
            let date = datePicker.date.addingTimeInterval(TimeInterval(60*60*24*days))
            
            endTextField.text = dateFormatter.string(from: date)
                        
        }
    }
    
    func checkUserInput(value: String?) -> String {
        if let input = value {
            return input
        }else {
            return "Kein Wert vorhanden."
        }
    }
    
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.count(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        let contract = CoreDataManager.shared.getContractItem(section: indexPath.section, row: indexPath.row)
        
        cell.nameLabel.text = contract.name
        cell.priceLabel.text = contract.price
        cell.startLabel.text = contract.start
        cell.durationLabel.text = contract.duration
        cell.endLabel.text = contract.end
        
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the persistent data and the local data in the section arrays.
            CoreDataManager.shared.removeContractItem(section: indexPath.section, row: indexPath.row)
            
            // Interne function von TableView wo man bei with: eine animation mitgeben kann und wo dann die zeile gelöscht oder (weiß man nicht) einfach tableview.reloadData() ausgeführt wird.
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
        
    }
}

