//
//  CoreDataHelper.swift
//  Gamepedia
//
//  Created by Dayton on 02/09/21.
//

import UIKit
import CoreData

class CoreDataHelper {

  static func saveFavoriteGame(game: GameDetail, completion: @escaping (Result<Void, APIServiceError>) -> Void) {
    let context = CoreDataStack.shared.context()

    context.performAndWait {
      if let favorite = NSEntityDescription.entity(forEntityName: "CDFavorite", in: context) {
        let newFavorite = NSManagedObject(entity: favorite, insertInto: context)
        newFavorite.setValue(game.detail.description, forKey: "gameDesc")
        newFavorite.setValue(game.detail.genres?.compactMap { $0.name }, forKey: "genres")
        newFavorite.setValue(game.general.idGame, forKey: "idGame")
        newFavorite.setValue(game.general.image, forKey: "image")
        newFavorite.setValue(game.general.name, forKey: "name")
        newFavorite.setValue(game.general.rating, forKey: "rating")
        newFavorite.setValue(game.general.released, forKey: "released")
      }
      if context.hasChanges {
        do {
          try context.save()
          completion(.success(()))
        } catch let error {
          completion(.failure(APIServiceError.custom(error)))
        }
      }
    }
  }

  static func getAllFavoriteList(completion: @escaping (Result<[GameResult], APIServiceError>) -> Void) {
    let context = CoreDataStack.shared.context()
    context.perform {
      var gameResult = [GameResult]()
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFavorite")

      do {
        guard let fetchedGame = try context.fetch(fetchRequest) as? [CDFavorite] else { return }
        fetchedGame.forEach { result in
          let game = GameResult(
            idGame: Int(result.idGame),
            name: result.name,
            image: result.image,
            released: result.released,
            rating: result.rating
          )
          gameResult.append(game)
        }
        completion(.success(gameResult))
      } catch let error {
        completion(.failure(APIServiceError.custom(error)))
      }
    }
  }

  static func getFavoriteGame(_ id: Int, completion: @escaping (Result<GameDetail, APIServiceError>) -> Void) {
    let context = CoreDataStack.shared.context()
    context.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFavorite")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = Predicate.favorite(id: id).query

      do {
        guard let result = try context.fetch(fetchRequest).first as? CDFavorite else { return }
        let gameDetail = GameDetail(
          GameResult(
            idGame: Int(result.idGame),
            name: result.name,
            image: result.image,
            released: result.released,
            rating: result.rating),
          GameDetailModel(
            description: result.gameDesc,
            genres: result.genres?.compactMap { Genre(name: $0) })
        )
        completion(.success(gameDetail))
      } catch let error {
        completion(.failure(APIServiceError.custom(error)))
      }
    }
  }

  static func deleteFavoriteGame(_ id: Int, completion: @escaping (Result<Void, APIServiceError>) -> Void) {
    let context = CoreDataStack.shared.context()
    context.performAndWait {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorite")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = Predicate.favorite(id: id).query

      do {
        guard let result = try context.fetch(fetchRequest).first as? CDFavorite else { return }
        context.delete(result)

        if context.hasChanges {
          try context.save()
          completion(.success(()))
        }
      } catch let error {
        completion(.failure(APIServiceError.custom(error)))
      }
    }
  }

  static func isFavorited(id: Int, completion: @escaping (Result<Bool, APIServiceError>) -> Void) {
    let context = CoreDataStack.shared.context()
    context.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFavorite")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = Predicate.favorite(id: id).query
      do {
        if try context.fetch(fetchRequest).first != nil {
          completion(.success(true))
        } else {
          completion(.success(false))
        }
      } catch {
        completion(.failure(APIServiceError.custom(error)))
      }
    }
  }
}
