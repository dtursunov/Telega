//
//  BookEntityModel.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import Foundation
import CoreData

@objc(BookEntityModel)
public class BookEntityModel: NSManagedObject {
    

}
//
extension BookEntityModel {
    
    @NSManaged var authors: String?
    @NSManaged var detail: String?
    @NSManaged var id: String?
    @NSManaged var imageURL: String?
    @NSManaged var name: String?
    @NSManaged var publishedYear: String?
}
