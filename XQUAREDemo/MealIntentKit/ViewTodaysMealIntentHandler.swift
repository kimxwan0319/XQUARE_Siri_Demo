//
//  ViewTodaysMealIntentHandler.swift
//  MealIntentKit
//
//  Created by 김수완 on 2021/06/15.
//

import UIKit

public class ViewTodaysMealIntentHandler: NSObject, ViewTodaysMealIntentHandling {
    public func confirm(intent: ViewTodaysMealIntent, completion: @escaping (ViewTodaysMealIntentResponse) -> Void) {
        completion(ViewTodaysMealIntentResponse(code: .ready, userActivity: nil))
    }
    public func handle(intent: ViewTodaysMealIntent, completion: @escaping (ViewTodaysMealIntentResponse) -> Void) {
        completion(ViewTodaysMealIntentResponse(code: .success, userActivity: nil))
    }
}
