local UseCases = {
    App = require('src.scripts.use_cases.app.app_use_cases'),
    Ads = require('src.scripts.use_cases.ads.ads_use_cases'),
    Leaderboards = require('src.scripts.use_cases.leaderboards.leaderboards_use_cases'),
    Feedback = require('src.scripts.use_cases.feedback.feedback_use_cases'),
    Payments = require('src.scripts.use_cases.payments.payments_use_cases'),
}

return UseCases
