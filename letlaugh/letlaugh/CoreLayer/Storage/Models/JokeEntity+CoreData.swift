import Foundation
import CoreData

@objc(JokeEntity)
public class JokeEntity: NSManagedObject { }

extension JokeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeEntity> {
        return NSFetchRequest<JokeEntity>(entityName: "JokeEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var text: String?

}
