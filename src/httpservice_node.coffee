NodeHttpService = {

    oembedRequest: (url, callback_ok, callback_error) ->
        request = require("request")
        request(url, (error, response, body) ->
            if error
                callback_error(error)
            else
                json = JSON.parse(body)
                callback_ok(json)
        )

}

try
    exports.NodeHttpService = NodeHttpService
catch e
    null
