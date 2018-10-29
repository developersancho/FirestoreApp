//
//  SnapshotExtension.swift
//  FirestoreApp
//
//  Created by developersancho on 16.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        var documentJson = data()
        if includingId {
            documentJson!["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson!, options: [])
        let decodeObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodeObject
    }
}
