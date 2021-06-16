//
//  NSUserActivity+IntentData.swift
//  MealIntentKit
//
//  Created by 김수완 on 2021/06/15.
//

import Foundation
import Intents

extension NSUserActivity {

    public static let viewTodaysMealActivityType = "com.kimxwan0319.MealIntentKit.viewtodaysmeal"

    public static var viewTosaysMealActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: NSUserActivity.viewTodaysMealActivityType)

        userActivity.title = "View Today's Meal"
        userActivity.persistentIdentifier = NSUserActivityPersistentIdentifier(NSUserActivity.viewTodaysMealActivityType)
        userActivity.isEligibleForPrediction = true
        userActivity.suggestedInvocationPhrase = "View Today's Meal"
        
        return userActivity
    }
}
