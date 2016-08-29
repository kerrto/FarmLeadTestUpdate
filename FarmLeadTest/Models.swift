//
//  OnboardingModels.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//



struct CommodityUnit {

let name : String!
let nameRaw: String!
let defaultVal: Int
let nameShort: String!
let order: Int
    let id: Int
    

    init(name: String, nameRaw: String, defaultVal: Int, nameShort: String, order: Int, id: Int) {
    self.name = name
    self.nameRaw = nameRaw
    self.defaultVal = defaultVal
    self.nameShort = nameShort
    self.order = order
    self.id = id

}

}

struct City {
    let id : Int
    let name : String
    let provinceId: Int
    let provinceName: String
    
    init(id : Int, name: String, provinceId: Int, provinceName: String) {
        self.id = id
        self.name = name
        self.provinceId = provinceId
        self.provinceName = provinceName
    }
}