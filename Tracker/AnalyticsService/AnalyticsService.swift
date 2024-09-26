//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Дмитрий Жуков on 9/26/24.
//

import Foundation
import YandexMobileMetrica

final class AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: AnalyticKey.key.rawValue) else { return }

        YMMYandexMetrica.activate(with: configuration)
    }

    func report(event: AnaliticEvent, params : [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
