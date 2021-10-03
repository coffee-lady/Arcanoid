local PaymentsUseCases = {
    StorePurchaseUseCase = require('src.scripts.use_cases.payments.store.StorePurchaseUseCase'),
    StoreGetShownProductsUseCase = require('src.scripts.use_cases.payments.store.StoreGetShownProductsUseCase'),
    StoreApplyProductUseCase = require('src.scripts.use_cases.payments.store.StoreApplyProductUseCase'),
    ShowOfferUseCase = require('src.scripts.use_cases.payments.special_offer.ShowOfferUseCase'),
    StartOfferUseCase = require('src.scripts.use_cases.payments.special_offer.StartOfferUseCase'),
    FinishOfferUseCase = require('src.scripts.use_cases.payments.special_offer.FinishOfferUseCase'),
    OfferOnInterstitialViewUseCase = require('src.scripts.use_cases.payments.special_offer.OfferOnInterstitialViewUseCase'),
    StoreFindProductUseCase = require('src.scripts.use_cases.payments.store.StoreFindProductUseCase'),
}

return PaymentsUseCases
