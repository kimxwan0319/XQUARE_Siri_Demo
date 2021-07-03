//
//  ViewTodaysMealIntentHandler.swift
//  MealIntentKit
//
//  Created by 김수완 on 2021/06/15.
//

import UIKit

public class ViewTodaysMealIntentHandler: NSObject, ViewTodaysMealIntentHandling {
    
    private var timePart: String!
    private var mealStr: String!
    
    public init(timePart: String, mealStr: String) {
        super.init()
        self.timePart = timePart
        self.mealStr = mealStr
    }
    
    public func confirm(intent: ViewTodaysMealIntent, completion: @escaping (ViewTodaysMealIntentResponse) -> Void) {
        completion(ViewTodaysMealIntentResponse(code: .ready, userActivity: nil))
    }
    public func handle(intent: ViewTodaysMealIntent, completion: @escaping (ViewTodaysMealIntentResponse) -> Void) {
        completion(ViewTodaysMealIntentResponse.success(timePart: timePart, meal: mealStr))
    }
}
