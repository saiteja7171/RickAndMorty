//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/12/25.
//

import UIKit
final class RMCharacterInfoCollectionViewCellViewModel {
    private let type: `Type`

    private let value: String
    public var title: String {
        self.type.displayTitle
    }
    
//    public var displayValue: String {
//        if value.isEmpty {
//            return "None"
//        }
//        return value
//    }
    
    public var displayValue: String {
            switch type {
            case .created:
                guard !value.isEmpty else { return "None" }
                if let date = Self.iso8601Fractional.date(from: value) ?? Self.iso8601.date(from: value) {
                    return Self.createdDisplayFormatter.string(from: date)
                } else {
                    return value // fallback if parsing fails
                }
            default:
                return value.isEmpty ? "None" : value
            }
        }
    
    
    public var iconImageView: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status: return .systemRed
            case .gender: return .systemBlue
            case .type: return .systemCyan
            case .species: return .systemYellow
            case .origin: return .systemOrange
            case .location: return .systemMint
            case .created: return .systemPink
            case .episodeCount: return .systemBrown
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status: return UIImage(systemName: "bell")
            case .gender: return UIImage(systemName: "bell")
            case .type: return UIImage(systemName: "bell")
            case .species: return UIImage(systemName: "bell")
            case .origin: return UIImage(systemName: "bell")
            case .location: return UIImage(systemName: "bell")
            case .created: return UIImage(systemName: "bell")
            case .episodeCount: return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status: return "Status"
            case .gender: return "Gender"
            case .type: return "Type"
            case .species: return "Species"
            case .origin: return "Origin"
            case .location: return "Location"
            case .created: return "Created"
            case .episodeCount: return "Episode Count"
            }
        }
    }
    
    
    init( type: `Type`,value: String) {
        self.value = value
        self.type = type
    }
}

private extension RMCharacterInfoCollectionViewCellViewModel {
    // Rick & Morty API uses ISO 8601, sometimes with fractional seconds
    static let iso8601Fractional: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    static let iso8601: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()

    // Exactly "Nov 4, 2017 at 11:50AM" (no space before AM/PM)
    static let createdDisplayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX") // stable symbols/casing
        df.timeZone = .current                        // show in user’s local time
        df.dateFormat = "MMM d, yyyy 'at' h:mma"      // e.g., Nov 4, 2017 at 11:50AM
        return df
    }()
}
