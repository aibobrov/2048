//
//  TileModel+CoreDataProperties.swift
//  2048
//
//  Created by Artem Bobrov on 25.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//
//

import Foundation
import CoreData


extension TileModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TileModel> {
        return NSFetchRequest<TileModel>(entityName: "TileModel")
    }

    @NSManaged public var position: Int16
    @NSManaged public var value: Int64
}
