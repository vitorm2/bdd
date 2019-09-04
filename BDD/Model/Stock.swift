//
//  Stock.swift
//  BDD
//
//  Created by Leonardo Reis on 03/09/19.
//  Copyright © 2019 LeonardoBSR. All rights reserved.
//

import Foundation

// MARK: - Stock
struct Stock: Codable {
    let symbol, name, currency, price: String?
    let priceOpen, dayHigh, dayLow, theWeekHigh: String?
    let theWeekLow, dayChange, changePct, closeYesterday: String?
    let marketCap, volume, volumeAvg, shares: String?
    let stockExchangeLong, stockExchangeShort, timezone, timezoneName: String?
    let gmtOffset, lastTradeTime: String?
    enum CodingKeys: String, CodingKey {
        case symbol, name, currency, price
        case priceOpen = "price_open"
        case dayHigh = "day_high"
        case dayLow = "day_low"
        case theWeekHigh = "52_week_high"
        case theWeekLow = "52_week_low"
        case dayChange = "day_change"
        case changePct = "change_pct"
        case closeYesterday = "close_yesterday"
        case marketCap = "market_cap"
        case volume
        case volumeAvg = "volume_avg"
        case shares
        case stockExchangeLong = "stock_exchange_long"
        case stockExchangeShort = "stock_exchange_short"
        case timezone
        case timezoneName = "timezone_name"
        case gmtOffset = "gmt_offset"
        case lastTradeTime = "last_trade_time"
    }
}
