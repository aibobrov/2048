//
//  TileModel+CoreDataProperties.swift
//  2048
//
//  Created by Artem Bobrov on 13.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//
//

import Foundation
import CoreData


extension TileModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TileModel> {
        return NSFetchRequest<TileModel>(entityName: "TileModel")
    }

    @NSManaged public var positionX: Int16
    @NSManaged public var tileValue: Int32
    @NSManaged public var positionY: Int16

}
