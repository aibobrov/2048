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
		case currentScore(for: Int)

		var key: String {
			switch self {
				case .highScore(let dimention):
					return "HighScore \(dimention)"
				case .currentScore(let dimention):
					return "CurrentScore \(dimention)"
			}

		}
	}

	static let shared = ModelController()

	func save(currentScore: Int, for dimention: Int) {
		UserDefaults.standard.set(currentScore, forKey: Key.currentScore(for: dimention).key)
	}

	func loadCurrentScore(for dimention: Int) -> Int {
		return UserDefaults.standard.integer(forKey: Key.currentScore(for: dimention).key)
	}


	func save(highScore: Int, for dimention: Int) {
		UserDefaults.standard.set(highScore, forKey: Key.highScore(for: dimention).key)
	}

	func loadHighScore(for dimention: Int) -> Int {
		return UserDefaults.standard.integer(forKey: Key.highScore(for: dimention).key)
	}


	func save(dimension: Int, tiles: [Tile]) {
		deleteAllTiles()
		for tile in tiles {
			let tileModel = TileModel(context: ResistanceService.context)
			tileModel.positionX = Int16(tile.position.x)
			tileModel.positionY = Int16(tile.position.y)
			tileModel.tileValue = Int32(tile.value ?? 0)
			ResistanceService.saveContext()
		}
	}


	func loadTiles(dimension: Int) -> [Tile] {
		let fetchRequest: NSFetchRequest<TileModel> = TileModel.fetchRequest()
		var tiles = [Tile]()
		do {
			let tileModels = try ResistanceService.context.fetch(fetchRequest)
			for tileModel in tileModels {
				if tileModel.tileValue == 0 {
					tiles.append(Tile(position: Position(Int(tileModel.positionX), Int(tileModel.positionY)), value: nil))
				} else {
					tiles.append(Tile(position: Position(Int(tileModel.positionX), Int(tileModel.positionY)), value: Int(tileModel.tileValue)))
				}
			}
		} catch {}

		return tiles
	}

	func deleteAllTiles() {
		let context = ResistanceService.context
		let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TileModel")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
		do {
			try context.execute(deleteRequest)
			try context.save()
		}
		catch{}
	}

}
