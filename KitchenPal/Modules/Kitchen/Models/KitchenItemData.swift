// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let kitchenItemData = try KitchenItemData(json)

import Foundation

protocol JSONEndcoding {
    init(with json: JSONDATA)
    func encodeAsJson() -> JSONDATA
}

class JSONNull {
    static func nilToNull<T>(object: T?) -> Any {
        if object == nil {
            return NSNull()
        }
        
        return object!
    }
}

// MARK: - KitchenItemData
struct KitchenItemData: JSONEndcoding {
    
    let product: Product?
    let quantity: Int?
    let history: [JSONDATA]?
    let expiryDate: Int?
    let defaultStorage: DefaultStorage?
    let ingredient: JSONDATA?
    let unit: String?
    let id: Int?
    let updatedAt: Int?
    let userId, createdAt: Int?
    let name, type: String?
    let recipeId, fromQuantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case product, quantity, history, expiryDate, defaultStorage, ingredient, unit, id, updatedAt
        case userID
        case createdAt, name, type
        case recipeID
        case fromQuantity
    }
    
    init(with json: JSONDATA) {
        if let productJson = json["product"] as? JSONDATA {
            product = Product(with: productJson)
        } else {
            product = nil
        }
        quantity = json["quantity"] as? Int
        history = json["history"] as? [JSONDATA]
        expiryDate = json["expiryDate"] as? Int
        
        if let defaultStorageJson = json["defaultStorage"] as? JSONDATA {
            defaultStorage = DefaultStorage(with: defaultStorageJson)
        } else {
            defaultStorage = nil
        }
        
        ingredient = json["ingredient"] as? JSONDATA
        unit = json["unit"] as? String
        id = json["id"] as? Int
        updatedAt = json["updatedAt"] as? Int
        userId = json["userId"] as? Int
        createdAt = json["createdAt"] as? Int
        name = json["name"] as? String
        type = json["type"] as? String
        recipeId = json["recipeId"] as? Int
        fromQuantity = json["fromQuantity"] as? Int
    }
    
    func encodeAsJson() -> JSONDATA {
        return [
            :
        ]
    }
    
    //external
    var defaultStorageId: Int {
        return defaultStorage?.id ?? -1
    }
    
    var defaultImage: String? {
        return "https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg"
//        return product?.defaultImage
    }
    
    static func objects(with jsons:[JSONDATA]) -> [KitchenItemData] {
        var objects = [KitchenItemData]()
        for json  in jsons {
            objects.append(KitchenItemData(with: json))
        }
        return objects;
    }
    
}


// MARK: - DefaultStorage
struct DefaultStorage: JSONEndcoding {
    
    let id: Int?
    let name: String?
    
    init(with json: JSONDATA) {
        id = json["id"] as? Int
        name = json["name"] as? String
    }
    
    func encodeAsJson() -> JSONDATA {
        return [
            :
        ]
    }
}

// MARK: - Product
struct Product: JSONEndcoding {
    let associatedIngredient: Int?
    let memberId: Int?
    let language: String?
    let sodium: Int?
    let brands: [Brand]?
    let memberPicture: [JSONDATA]?
    let nova: Int?
    let picturesValidated, calories: Int?
    let lastModified: String?
    let approval: Int?
    let images: [JSONDATA]?
    let sugar: Int?
    let fat: Int?
    let nutriscore: String?
    let associationId: Int?
    let assimilatedAt: String?
    let id, quantity, langConfidence, sourceId: Int?
    let memberList: [JSONDATA]?
    let pictureStatus: Int?
    let unit: String?
    let informationStatus: Int?
    let barcode, productName: String?
    let fibers: Int?
    let addedAt: String?
    let defaultImage, genericName: String?
    let carbs: Int?
    
    enum CodingKeys: String, CodingKey {
        case associatedIngredient
        case memberId
        case language, sodium, brands, memberPicture, nova, picturesValidated, calories, lastModified, approval, images, sugar, fat, nutriscore
        case associationId
        case assimilatedAt, id, quantity, langConfidence
        case sourceId
        case memberList, pictureStatus, unit, informationStatus, barcode, productName, fibers, addedAt, defaultImage, genericName, carbs
    }
    
    init(with json: JSONDATA) {
        associatedIngredient = json["associatedIngredient"] as? Int
        memberId = json["memberId"] as? Int
        language = json["language"] as? String
        sodium = json["sodium"] as? Int
        brands = Brand.objects(with: json["brands"] as? [JSONDATA])
        memberPicture = json["memberPicture"] as? [JSONDATA]
        nova = json["nova"] as? Int
        picturesValidated = json["picturesValidated"] as? Int
        calories = json["calories"] as? Int
        lastModified = json["lastModified"] as? String
        approval = json["approval"] as? Int
        images = json["images"] as? [JSONDATA]
        sugar = json["sugar"] as? Int
        fat = json["fat"] as? Int
        nutriscore = json["nutriscore"] as? String
        associationId = json["associationId"] as? Int
        assimilatedAt = json["assimilatedAt"] as? String
        id = json["id"] as? Int
        quantity = json["quantity"] as? Int
        langConfidence = json["langConfidence"] as? Int
        sourceId = json["sourceId"] as? Int
        memberList = json["memberList"] as? [JSONDATA]
        pictureStatus = json["pictureStatus"] as? Int
        unit = json["unit"] as? String
        informationStatus = json["informationStatus"] as? Int
        barcode = json["barcode"] as? String
        productName = json["productName"] as? String
        fibers = json["fibers"] as? Int
        addedAt = json["addedAt"] as? String
        defaultImage = json["defaultImage"] as? String
        genericName = json["genericName"] as? String
        carbs = json["carbs"] as? Int
    }
    
    func encodeAsJson() -> JSONDATA {
        return [
            :
        ]
    }
}

// MARK: - Brand
struct Brand: JSONEndcoding {
    
    let id: Int?
    let brandName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case brandName
    }
    
    init(with json: JSONDATA) {
        id = json["id"] as? Int
        brandName = json["brandName"] as? String
    }
    
    func encodeAsJson() -> JSONDATA {
        return [
            "id": JSONNull.nilToNull(object:id),
            "brandName": JSONNull.nilToNull(object: brandName)
        ]
    }
    
    static func objects(with jsons: [JSONDATA]?) -> [Brand]? {
        guard let jsons = jsons else {
            return nil
        }
        var brands = [Brand]()
        for json in jsons {
            brands.append(Brand(with: json))
        }
        return brands
    }
}
