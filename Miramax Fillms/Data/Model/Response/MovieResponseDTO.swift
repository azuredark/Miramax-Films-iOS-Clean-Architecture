//
//  MovieResponseDTO.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 15/09/2022.
//

import ObjectMapper

struct MovieResponseDTO: Mappable {
    var page: Int!
    var results: [MovieDTO]!
    var totalPages: Int!
    var totalResults: Int!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
}

extension MovieResponseDTO: DomainConvertibleType {
    func asDomain() -> MovieResponse {
        return MovieResponse(
            page: page,
            results: results.map { $0.asDomain() },
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}
