//
//  Entity.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation

struct Response: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let artistViewURL: String
    let screenshotUrls, ipadScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let supportedDevices, advisories: [String]
    let isGameCenterEnabled: Bool
    let features: [Feature]
    let kind: Kind
    let contentAdvisoryRating: Rating
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: Rating
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
    let formattedPrice: FormattedPrice
    let currentVersionReleaseDate: Date
    let releaseNotes, minimumOSVersion: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let description, sellerName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let primaryGenreName: String
    let primaryGenreID: Int
    let bundleID: String
    let currency: Currency
    let trackID: Int
    let trackName: String
    let releaseDate: Date
    let genreIDS: [String]
    let version: String
    let wrapperType: Kind
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case artistViewURL = "artistViewUrl"
        case screenshotUrls, ipadScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100, supportedDevices, advisories, isGameCenterEnabled, features, kind, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating, trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case formattedPrice, currentVersionReleaseDate, releaseNotes
        case minimumOSVersion = "minimumOsVersion"
        case artistID = "artistId"
        case artistName, genres, price, description, sellerName, isVppDeviceBasedLicensingEnabled, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case bundleID = "bundleId"
        case currency
        case trackID = "trackId"
        case trackName, releaseDate
        case genreIDS = "genreIds"
        case version, wrapperType, userRatingCount
    }
}

enum Rating: String, Codable {
    case the12 = "12+"
    case the17 = "17+"
    case the4 = "4+"
    case the9 = "9+"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Feature: String, Codable {
    case gameCenter = "gameCenter"
    case iosUniversal = "iosUniversal"
}

enum FormattedPrice: String, Codable {
    case free = "Free"
}

enum Kind: String, Codable {
    case software = "software"
}
