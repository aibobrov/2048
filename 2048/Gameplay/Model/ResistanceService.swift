//
//  ResistanceService.swift
//  2048
//
//  Created by Artem Bobrov on 13.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation
import CoreData

class ResistanceService {

	private init() {}

	static var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	static var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "_048")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	static func saveContext () {
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
