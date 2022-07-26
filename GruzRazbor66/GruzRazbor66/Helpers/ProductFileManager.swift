//
//  ProductFileManager.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import Foundation
import RealmSwift
struct ProductFileManager {
    func saveProduct(product: Product) {
        guard let realm = try? Realm() else { return }
        
        try! realm.write {
            realm.add(product.entity)
        }
    }
    
    func deleteProduct(product: Product) {
        guard let realm = try? Realm() else { return }
        
        try! realm.write {
            realm.delete(realm.objects(ProductInfoEntity.self).filter("id=%@",product.id))
        }
    }
    
    func loadProducts() -> [Product] {
        guard let realm = try? Realm() else { return [Product]()}
        
        return realm.objects(ProductInfoEntity.self).models
    }
}
