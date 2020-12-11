local EventObservationLib = {
    observable = require('src.libs.event_observation.observable'),
    fork_join = require('src.libs.event_observation.operators.fork_join'),
}

return EventObservationLib
