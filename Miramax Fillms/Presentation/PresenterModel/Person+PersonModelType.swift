//
//  Person+PersonModelType.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 20/09/2022.
//

import Foundation

extension Person: PersonModelType {
    var personModelProfileURL: URL? {
        return profileURL
    }
    
    var personModelName: String? {
        return name
    }
}
