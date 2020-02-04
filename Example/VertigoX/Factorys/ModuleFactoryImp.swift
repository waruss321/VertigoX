//
//  ModuleFactoryImp.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import PanModal
import Signals
import VertigoX

final class ModuleFactoryImp { }

extension ModuleFactoryImp: LoginModuleFactory {
    func makeLoginModule() -> LoginModule {
        return LoginVC()
    }
}

extension ModuleFactoryImp: ShopModuleFactory {
    func makeShopModule() -> ShopModule {
        return ShopVC(viewModel: ShopVM())
    }
}

extension ModuleFactoryImp: AddItemModuleFactory {
    func makeAddItemModule() -> AddItemModule {
        return AddItemVC()
    }
}

extension ModuleFactoryImp: ItemDetailsModuleFactory {
    func makeItemDetailsModule() -> ItemDetailsModule {
         return ItemDetailsVC()
    }
    
    func makeEditItemDetailsModule() -> EditItemDetailsModule {
        return EditItemDetailsViewController()
    }
}
