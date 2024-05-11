//
//  Core Data .swift
//  Up Sklad
//
//  Created by Марат Хасанов on 10.05.2024.
//

import CoreData
import UIKit

class CoreData {
    
    //MARK: - Сохранить
    // Сохранять данные в Product
    func saveProduct(id: String, name: String, price: Double, categoryID: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context) as! Product

        product.id = id
        product.name = name
        product.price = price
        product.categoryID = categoryID

        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Сохранять данные в Order
    func saveOrder(id: String, date: Date, userID: String, total: Double) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let order = NSEntityDescription.insertNewObject(forEntityName: "Order", into: context) as! Order

        order.id = id
        order.date = date
        order.userID = userID
        order.total = total

        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Сохранять данные в User
    func saveUser(id: String, name: String, email: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context) else {
            print("Error: Failed to find the entity description for 'User'")
            return
        }

        let user = User(entity: userEntity, insertInto: context)
        user.id = id
        user.name = name
        user.email = email

        do {
            try context.save()
            print("User saved successfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }


    //MARK: - Получить
    // Получать данные из Product
    func fetchProducts() -> [Product] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")

        do {
            let products = try context.fetch(fetchRequest)
            return products
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Получать данные из Order
    func fetchOrders() -> [Order] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Order>(entityName: "Order")

        do {
            let orders = try context.fetch(fetchRequest)
            return orders
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Получать данные из User
    func fetchUsers() -> [User] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")

        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    //MARK: - Обновить
    // Обновить данные из Product
    func updateProduct(id: String, newName: String, newPrice: Double) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let test = try context.fetch(fetchRequest)

            if let objectToUpdate = test[0] as? Product {
                objectToUpdate.name = newName
                objectToUpdate.price = newPrice
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or save. \(error), \(error.userInfo)")
        }
    }
    
    // Обновить данные из Order
    func updateOrder(id: String, newDate: Date, newTotal: Double) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let results = try context.fetch(fetchRequest)
            if let orderToUpdate = results.first as? Order {
                orderToUpdate.date = newDate
                orderToUpdate.total = newTotal
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or save. \(error), \(error.userInfo)")
        }
    }
    
    // Обновить данные из User
    func updateUser(id: String, newName: String, newEmail: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let results = try context.fetch(fetchRequest)
            if let userToUpdate = results.first as? User {
                userToUpdate.name = newName
                userToUpdate.email = newEmail
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or save. \(error), \(error.userInfo)")
        }
    }

    //MARK: - Удалить
    // Удалить данные из Product
    func deleteProduct(id: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let test = try context.fetch(fetchRequest)

            if let objectToDelete = test[0] as? Product {
                context.delete(objectToDelete)
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or delete. \(error), \(error.userInfo)")
        }
    }
    
    // Удалить данные из Order
    func deleteOrder(id: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let results = try context.fetch(fetchRequest)
            if let orderToDelete = results.first as? Order {
                context.delete(orderToDelete)
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or delete. \(error), \(error.userInfo)")
        }
    }
    
    // Удалить данные из User
    func deleteUser(id: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let results = try context.fetch(fetchRequest)
            if let userToDelete = results.first as? User {
                context.delete(userToDelete)
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch or delete. \(error), \(error.userInfo)")
        }
    }
}
