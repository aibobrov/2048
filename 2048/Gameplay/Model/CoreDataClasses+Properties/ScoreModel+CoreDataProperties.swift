//
//  ScoreModel+CoreDataProperties.swift
//  2048
//
//  Created by Artem Bobrov on 13.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//
//

import Foundation
import CoreData


extension ScoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreModel> {
        return NSFetchRequest<ScoreModel>(entityName: "ScoreModel")
    }

    @NSManaged public var value: Int64

}
