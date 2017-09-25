//
//  ModelController.swift
//  2048
//
//  Created by Artem Bobrov on 23.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import CoreData


class ModelController {

	enum Key {

		case highScore(for: Int)

		var key: String {
			switch self {
			case .highScore(let dimention):
				return "HighScore \(dimention)"
			}
		}
	}

	static let shared = ModelController()
	
	func save(highScore: Int, for dimention: Int) {
		UserDefaults.standard.set(highScore, forKey: Key.highScore(for: dimention).key)
	}

	func loadHighScore(for dimention: Int) -> Int {
		return UserDefaults.standard.integer(forKey: Key.highScore(for: dimention).key)
	}


	func save(dimension: Int, tiles: [Tile]) {
		deleteAllTiles()
		for tile in tiles {
			let tileModel = TileModel(context: context)
			tileModel.position = Int16(tile.position.x * dimension + tile.position.y)
			tileModel.value = Int64(tile.value ?? 0)
			saveContext()
		}
	}


	func loadTiles(dimension: Int) -> [Tile] {
		let fetchRequest: NSFetchRequest<TileModel> = TileModel.fetchRequest()
		var tiles = [Tile]()
		do {
			let tileModels = try context.fetch(fetchRequest)
			for tileModel in tileModels {
				let position : Int = Int(tileModel.position)
				let value: Int = Int(tileModel.value)
				if tileModel.value == 0 {
					tiles.append(Tile(position: Position(position / dimension, position % dimension), value: nil))
				} else {
					tiles.append(Tile(position: Position(position / dimension, position % dimension), value: value))
				}
			}

		} catch {}

		return tiles
	}

	func deleteAllTiles() {
		let context = self.context
		let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TileModel")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
		do {
			try context.execute(deleteRequest)
			try context.save()
		}
		catch{}
	}

	// MARK: - Core Data stack
	var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "_048")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	// MARK: - Core Data Saving support
	func saveContext () {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}

}
