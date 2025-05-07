//
//  LocalDataManager.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 28/04/25.
//

import Foundation
import SwiftData

protocol HasUUID {
  var uuid: UUID { get }
}

final class LocalDataManager {
  
  // MARK: Shared
  
  static var shared = LocalDataManager()
  
  // MARK: Private Methods
  
  private init() {}
  
  private func saveContext(_ context: ModelContext) {
    do {
      try context.save()
    } catch {
      LogManager.shared.log(error)
    }
  }
  
  // MARK: SwiftData Methods
  
  // MARK: Save Methods
  
  func save<T: PersistentModel>(_ object: T, context: ModelContext) {
    context.insert(object)
    saveContext(context)
  }
  
  func saveAll<T: PersistentModel>(_ objectList: [T], context: ModelContext) {
    objectList.forEach { context.insert($0) }
    saveContext(context)
  }
  
  // MARK: Fetch Methods
  
  func fetchAll<T: PersistentModel>(_ model: T.Type, context: ModelContext) -> [T] {
    let descriptor = FetchDescriptor<T>()
    do {
      return try context.fetch(descriptor)
    } catch {
      LogManager.shared.log(error)
      return []
    }
  }
  
  func fetchByID<T: PersistentModel & HasUUID>(_ model: T.Type, uuid: UUID, context: ModelContext) -> T? {
    let descriptor = FetchDescriptor<T>(
      predicate: #Predicate { $0.uuid == uuid }
    )
    
    do {
      return try context.fetch(descriptor).first
    } catch {
      LogManager.shared.log(error)
      return nil
    }
  }
  
  // MARK: Delete Methods
  
  func delete<T: PersistentModel>(_ object: T, context: ModelContext) {
    context.delete(object)
    saveContext(context)
  }
  
  func deleteAll<T: PersistentModel>(_ model: T.Type, context: ModelContext) {
    let all = fetchAll(model, context: context)
    all.forEach { context.delete($0) }
    saveContext(context)
  }
}

// MARK: UserDefaults Methods

extension LocalDataManager {
  
  func saveToUD<T: Codable>(_ object: T, forKey key: String) {
    do {
      let data = try JSONEncoder().encode(object)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      LogManager.shared.log("Error encoding object to UserDefaults - \(error)")
    }
  }
  
  func getFromUD<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
    guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
    do {
      return try JSONDecoder().decode(type, from: data)
    } catch {
      LogManager.shared.log("Error encoding object to UserDefaults - \(error)")
      return nil
    }
  }
  
  func deleteFromUD(forKey key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }
}
