//
//  IntentViewController.swift
//  ViewTodaysMealUI
//
//  Created by 김수완 on 2021/06/15.
//

import IntentsUI
import MealIntentKit

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var timeTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setViewMaterial()
    }
    
    private func setViewMaterial() {
        if let view = self.view as? UIVisualEffectView {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        }
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        if interaction.intentHandlingStatus == .success {
            if let _ = interaction.intentResponse as? ViewTodaysMealIntentResponse {
            }
            //completion(false, parameters, self.desiredSize)
            completion(true, parameters, CGSize(width: 320, height: 150))
        }
        
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
