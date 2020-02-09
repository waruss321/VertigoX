//
//  ModuleFactoryImp.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

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
    
    func makeMoreInfo() -> MoreInfoModule {
        return MoreInfoVC()
    }
}

extension ModuleFactoryImp: ItemDetailsModuleFactory {
    func makeItemDetailsModule() -> WorkoutViewModule {
         return WorkoutViewVC(viewModel: WorkoutViewVM(headerHeight: 100))
    }
    
    func makeEditItemDetailsModule() -> EditItemDetailsModule {
        return EditItemDetailsViewController()
    }
}


extension ModuleFactoryImp: PushTestModuleFactory {
    func makePushTestModule() -> PushTestModule {
        return PushTestVC()
    }
}
