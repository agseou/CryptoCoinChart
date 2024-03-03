//
//  RealmRepository.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/29.
//

import Foundation
import RealmSwift

class RealmRepository {
    
    private let realm = try! Realm()
    
    func toggleFavorite(coinID: String) {
        if let isExist = realm.objects(Favorite.self).filter("coinID == %@", coinID).first {
            deleteItem(isExist)
        } else {
            if canAddFavorite() {
                CoinAPIManager.shared.request(type: [Market].self, api: .Market(ids: coinID)) { data in
                    let item = Favorite(coinID: data[0].id, name: data[0].name, symbol: data[0].symbol, image: data[0].image, current_price: data[0].current_price, price_change_percentage: data[0].price_change_percentage_24h)
                    self.createItem(item)
                }
            }
        }
    }
    
    // CREATE
    func createItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm create")
            }
        } catch {
            print(error)
        }
        print(realm.configuration.fileURL!)
    }
    
    // CREATE LIST
    func createList<T: Object>(_ item: [T]) {
        do {
            try realm.write {
                realm.add(item, update: .all)
                print("Realm create")
            }
        } catch {
            print(error)
        }
        print(realm.configuration.fileURL!)
    }
    
    // DELETE
    func deleteItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    // DELETE ALL
    func deleteAllItem<T: Object>(ofType type: T) {
        do {
            try realm.write {
                realm.delete(realm.objects(T.self))
            }
        } catch {
            print(error)
        }
    }
    
    // 데이터 주기
    func fetchItem<T: Object>(ofType type: T.Type) -> Results<T> {
        print(realm.configuration.fileURL!)
        return realm.objects(T.self)
    }
    
    // 즐겨찾기 되어있는지 유무 확인
    func isFavorite(coinID: String) -> Bool {
        return realm.objects(Favorite.self).filter("coinID == %@", coinID).isEmpty
    }
    
    // 저장 가능한지 유무 함수
    func canAddFavorite() -> Bool {
         let favoritesCount = realm.objects(Favorite.self).count
         return favoritesCount < 10 // 최대 10개까지 저장 가능
     }
    
}
