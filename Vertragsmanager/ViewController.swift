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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

