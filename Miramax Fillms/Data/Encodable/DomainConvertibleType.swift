//
//  DomainConvertibleType.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 13/09/2022.
//

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}
