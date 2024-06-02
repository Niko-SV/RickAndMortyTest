//
//  Identifiable.swift
//  TestAppRickMorty
//
//  Created by NikoS on 02.06.2024.
//

import Foundation

public protocol Identifiable {
    var identifier: String { get }

    static var selectedValue: String { get }
}

extension Identifiable {

    public var identifier: String {
        return String(describing: self)
    }

    public static var selectedValue: String {
        return "selected"
    }
}

extension Identifiable where Self: RawRepresentable, RawValue == String {

    public var identifier: String {
        return rawValue
    }
}
