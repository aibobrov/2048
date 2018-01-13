//
//  TileModel+CoreDataClass.swift
//  2048
//
//  Created by Artem Bobrov on 13.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TileModel)
public class TileModel: NSManagedObject {
	var upTile: Tile?
	var rightTile: Tile?
	var bottomTile: Tile?
	var leftTile: Tile?
}
