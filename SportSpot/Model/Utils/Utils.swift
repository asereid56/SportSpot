//
//  Utils.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation
import UIKit

struct Utils {
    
    static func convertTo<T: Decodable>(from data: Data)-> T?{
        do {
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(T.self, from: data)
            return result
            
        } catch let error{
            print(error)
            return nil
        }
    }
    
    static func showAlert(title: String, message:String , view : UIViewController , isCancelled :Bool, complitionHandler : @escaping ()->() ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let ok = UIAlertAction(title: "ok", style: .default) { action in
            complitionHandler()
         }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        if isCancelled {
            alert.addAction(cancel)
        }
         
        view.present(alert, animated: true)
    }
    
}

enum SportType: String {
    case football
    case basketball
    case tennis
    case cricket
}

enum MethodName: String {
    case Countries
    case Leagues
    case Fixtures = "Fixtures&leagueId="
    case H2H
    case Livescore
    case Standings = "Standings&leagueId="
    case Topscorers = "Topscorers&leagueId="
    case Teams = "Teams&teamId="
    case Players = "Players&playerId="
    case Videos = "Videos&eventId="
    case Odds = "Odds&matchId="
    case Probabilities = "Probabilities&matchId="
    case OddsLive
    case Comments = "Comments&matchId="
}



