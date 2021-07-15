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
        // Create Context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        // Load Contracts
        loadContractItems()
    }
    
    func getContractItem(section: Int, row: Int) -> Vertrag {
        switch section {
        case 0: return carContractCategory[row]
        case 1: return phoneContractCategory[row]
        case 2: return homeContractCategory[row]
        default:
            return insuranceContractCategory[row]
        }
    }
    
    func removeContractItem(section: Int, row: Int) {
        
        // Remove from the container
        context.delete(getContractItem(section: section, row: row))
        
        // Save
        saveContext()
        
        // Remove Data from the Array
        switch section {
        case 0: carContractCategory.remove(at: row)
        case 1: phoneContractCategory.remove(at: row)
        case 2: homeContractCategory.remove(at: row)
        default:
            insuranceContractCategory.remove(at: row)
        }
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
    
    func addNewVertragItem(category: String, name: String, price: String, contractBegin: String, contractDuration: String, contractEnd: String) {
        
        // Load ContractObject
        let contract = NSEntityDescription.insertNewObject(forEntityName: "Vertrag", into: context) as! Vertrag
        
        contract.category = category
        contract.name = name
        contract.price = price
        contract.start = contractBegin
        contract.duration = contractDuration
        contract.end = contractEnd
        
        // Speichern
        saveContext()
        
        switch category {
        case "Auto": carContractCategory.append(contract)
        case "Haus": homeContractCategory.append(contract)
        case "Telefon": phoneContractCategory.append(contract)
        case "Versicherungen": insuranceContractCategory.append(contract)
        default:
            break
        }
    }
    
    // Speichern
    func saveContext() {
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    // Load Data
    func loadContractItems() {
        let request: NSFetchRequest<Vertrag> = NSFetchRequest<Vertrag>(entityName: "Vertrag")
        
        do {
            let contractItemArray = try context.fetch(request)
            
            for item in contractItemArray {
                switch item.category {
                case "Auto": carContractCategory.append(item)
                case "Telefon": phoneContractCategory.append(item)
                case "Haus": homeContractCategory.append(item)
                case "Versicherungen": insuranceContractCategory.append(item)
                default:
                    break
                }
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}

