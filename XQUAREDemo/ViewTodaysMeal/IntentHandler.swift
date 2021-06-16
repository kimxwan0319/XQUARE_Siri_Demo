//
//  IntentHandler.swift
//  ViewTodaysMeal
//
//  Created by 김수완 on 2021/06/15.
//

import Intents
import MealIntentKit

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is ViewTodaysMealIntent {
            return ViewTodaysMealIntentHandler()
        }
        
        fatalError("Unhandled intent type: \(intent)")
    }
    
}
