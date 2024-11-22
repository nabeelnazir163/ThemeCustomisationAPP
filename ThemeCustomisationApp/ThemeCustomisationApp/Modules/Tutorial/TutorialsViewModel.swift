//
//  TutorialsViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Foundation
import UIKit

class TutorialsViewModel {
    enum TutorialState: Int {
        case first = 0, second, third, skip
    }
    private(set) var state: Bindable<TutorialState> = Bindable(.first)
    let tutorialList = [
        Tutorial(image: .tutorialItem0,
                 title: "Welcome to Your Personal Style Hub",
                 description: "Discover over hundreds of beautiful wallpapers and icons to make your device truly yours.",
                 state: .first),
        Tutorial(image: .tutorialItem1,
                 title: "Effortless \nCustomization",
                 description: "Enjoy easy installation and tutorials to quickly refresh your screen’s look.",
                 state: .second),
        Tutorial(image: .tutorialItem2,
                 title: "Unlock the Full \nCollection",
                 description: "Access exclusive designs with a subscription and elevate your device’s style.",
                 state: .third),
        
    ]

    func getNextButtonBG() -> UIImage {
        switch state.value {
        case .first:
            return UIImage(resource: .nextButton0)
        case .second:
            return UIImage(resource: .nextButton1)
        case .third, .skip:
            return UIImage(resource: .nextButton2)
        }
    }
    
    func updateState(to state: TutorialState) {
        self.state.value = state
    }
}


