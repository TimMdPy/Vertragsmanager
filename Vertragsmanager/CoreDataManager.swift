//
//  CoreDataManager.swift
//  Vertragsmanager
//
//  Created by Tim Meyerdiercks on 12.07.21.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    // Pro Sektion / Kategorie ein Array
    var carContractCategory = [Vertrag]()
    var phoneContractCategory = [Vertrag]()
    var homeContractCategory = [Vertrag]()
    var insuranceContractCategory = [Vertrag]()
    
    var context: NSManagedObjectContext!
    
    // Singleton Pattern (programmieren dass nur eine instanz der Klasse erstellt wird.)
    static let shared = CoreDataManager()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func count(section: Int) -> Int {
        var count = 0
        switch section {
        case 0:
            count = carContractCategory.count
        case 1:
            count = phoneContractCategory.count
        case 2:
            count = homeContractCategory.count
        case 3:
            count = insuranceContractCategory.count
        default:
            break
        }
        
        return count
    }
    
}

