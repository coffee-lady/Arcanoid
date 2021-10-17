local PresentersGO = {
    balls_presenter = require('src.scripts.scenes.game_scene.presenters.BallsPresenter.BallsPresenter'),
    platform_presenter = require('src.scripts.scenes.game_scene.presenters.PlatformPresenter.PlatformPresenter'),
    walls_presenter = require('src.scripts.scenes.game_scene.presenters.WallsPresenter.WallsPresenter'),
    losing_zone_presenter = require('src.scripts.scenes.game_scene.presenters.LosingZonePresenter.LosingZonePresenter'),
    blocks_presenter = require('src.scripts.scenes.game_scene.presenters.BlocksPresenter.BlocksPresenter'),
}

return PresentersGO
