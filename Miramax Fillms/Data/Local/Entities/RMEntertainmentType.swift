//
//  RMEntertainmentType.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 25/09/2022.
//

import Foundation
import RealmSwift

enum RMEntertainmentType: String, PersistableEnum {
    case movie
    case tvShow
}

extension RMEntertainmentType: DomainConvertibleType {
    func asDomain() -> EntertainmentType {
        switch self {
        case .movie: return .movie
        case .tvShow: return .tvShow
        }
    }
}