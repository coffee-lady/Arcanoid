local PaymentsUseCases = {
    GetShownProductsUseCase = require('src.scripts.use_cases.payments.store.GetShownProductsUseCase'),
    StartOfferUseCase = require('src.scripts.use_cases.payments.special_offer.StartOfferUseCase'),
    FinishOfferUseCase = require('src.scripts.use_cases.payments.special_offer.FinishOfferUseCase'),
    FindProductUseCase = require('src.scripts.use_cases.payments.store.FindProductUseCase'),
}

return PaymentsUseCases
