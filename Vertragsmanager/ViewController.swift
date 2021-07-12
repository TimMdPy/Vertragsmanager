//
//  ViewController.swift
//  Vertragsmanager
//
//  Created by Tim Meyerdiercks on 11.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contractTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

