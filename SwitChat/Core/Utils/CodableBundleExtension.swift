//
//  CodableBundleExtension.swift
//  SwitChat
//
//  Created by Max Ward on 06/04/2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String, of type: T.Type) -> T  {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }
        
        return loaded
    }
}

extension Encodable {
    
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to dictionary"])
        }
        return dictionary
    }
    
    func convert<T: Codable>(to: T.Type) throws -> T {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
