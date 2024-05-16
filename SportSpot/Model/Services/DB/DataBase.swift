//
//  DataBase.swift
//  SportSpot
//
//  Created by Mac on 16/05/2024.
//

import Foundation
import CoreData

protocol LocalDB {
    func saveCoreData(league: League) -> Bool
    func searchFromCoreData(league: League) -> Bool
    func fetchCoreData() -> [League]
    func deleteFromCoreData(league: League) -> Bool
    
}

class DataBase: LocalDB{
    
    private var persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func saveCoreData(league: League) -> Bool{
        let context = persistentContainer.viewContext
        
        _ = convertToManagedObject(from: league, insertInto: context)
        
        do{
            try context.save()
            return true
        }catch let error{
            print(error)
        }
        return false
    }

    func searchFromCoreData(league: League) -> Bool {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Attribute.Entity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(Attribute.leagueId.rawValue) == %ld", league.leagueKey)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            if !fetchedResults.isEmpty{
                return true
            }
        }catch let error {
            print(error)
        }
        return false
    }
    
    func fetchCoreData() -> [League]{
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Attribute.Entity.rawValue)
        
        var leagues:[League] = []
        do{
            let response = try context.fetch(fetchRequest)
            for item in response{
                leagues.append(convertToLeague(from: item))
            }
        }catch let error{
            print(error)
        }
        return leagues
    }

    func deleteFromCoreData(league: League) -> Bool {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Attribute.Entity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(Attribute.leagueId.rawValue) == %ld", league.leagueKey)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            for object in fetchedResults {
                context.delete(object)
            }
            
            try context.save()
            return true
        }catch let error {
            print(error)
        }
        return false
    }

    func deleteAllCoreData()-> Bool{
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Attribute.Entity.rawValue)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            for object in fetchedResults {
                context.delete(object)
            }
            
            try context.save()
            return true
        }catch let error {
            print(error)
        }
        return false
    }

    
    enum Attribute: String {
        case Entity = "FavLeague"
        case leagueId, leagueLogo, leagueName, sportType
    }
    
    func convertToLeague(from:NSManagedObject) -> League{
        
        return League(leagueKey: from.value(forKey: Attribute.leagueId.rawValue) as! Int, leagueName: from.value(forKey: Attribute.leagueName.rawValue) as! String, countryKey: nil, countryName: nil, leagueLogo: URL(string: from.value(forKey: Attribute.leagueLogo.rawValue) as? String ?? ""), countryLogo: nil, leagueYear: nil, sportType: from.value(forKey: Attribute.sportType.rawValue) as? String)
    }

    func convertToManagedObject(from: League, insertInto context: NSManagedObjectContext) -> NSManagedObject{
        
        let entity = NSEntityDescription.entity(forEntityName: Attribute.Entity.rawValue, in: context)
        
        let league = NSManagedObject(entity: entity!, insertInto: context)
        league.setValue(from.leagueKey, forKey: Attribute.leagueId.rawValue)
        league.setValue(from.leagueName, forKey: Attribute.leagueName.rawValue)
        league.setValue(from.leagueLogo?.absoluteString, forKey: Attribute.leagueLogo.rawValue)
        league.setValue(from.sportType, forKey: Attribute.sportType.rawValue)
        
        context.detectConflicts(for: league)
        return league
    }

}
