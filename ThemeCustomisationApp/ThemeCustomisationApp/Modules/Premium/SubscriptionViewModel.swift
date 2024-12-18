//
//  SubscriptionViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 18/12/2024.
//

import Foundation
import SubscriptionHandler
import StoreKit

final class SubscriptionViewModel {
    let config = Configuration(productIds: ["com.themesaver.app"])
    var subManager: SubscriptionManager?
    
    func onViewDidLoad() {
        subManager = SubscriptionManager(configurations: config)
        subManager?.fetchSubscriptionProducts()
        subManager?.delegate = self
    }
}

// MARK: - SubscriptionProtocol
extension SubscriptionViewModel: SubscriptionProtocol {
    func subscriptionManager(_ subscriptionManager: SubscriptionManager, productsFetched products: [SKProduct]) {
        
    }
}
