//
//  ModuleFactoryImp.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

final class ModuleFactoryImp { }

extension ModuleFactoryImp: LoginModuleFactory {
    func makeLoginModule() -> LoginModule {
        return LoginVC()
    }
}

extension ModuleFactoryImp: ShopModuleFactory {
    func makeAddItemModule() -> AddItemModule {
        return AddItemVC()
    }
    
    func makeShopModule() -> ShopModule {
        return ShopVC()
    }
}
