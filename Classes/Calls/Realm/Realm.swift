//
//  Realm.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/2/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    typealias Transaction = (Realm) -> ()
    
    static func write(transaction: @escaping Transaction,
                      _ errorClosure: ErrorClosure? = nil) {
        tryCatch({
            try autoreleasepool(invoking: {
                let realm = try Realm()
                if realm.isInWriteTransaction {
                    transaction(realm)
                    realm.refresh()
                } else {
                    try realm.write({
                        transaction(realm)
                        realm.refresh()
                    })
                }
            })
        }, errorClosure)
    }
    
    static func read(transaction: @escaping Transaction,
                     _ errorClosure: ErrorClosure? = nil) {
        tryCatch({
            try autoreleasepool(invoking: {
                let realm = try Realm()
                realm.refresh()
                transaction(realm)
            })
        }, errorClosure)
    }
}
