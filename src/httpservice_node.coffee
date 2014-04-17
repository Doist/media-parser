NodeHttpService = {

    oembedRequest: (url, callback_ok, callback_error,
                    content_url, timeout) ->
        request = require("request")
        timeout = timeout or 5000
        args = {"url": url, "timeout": timeout}

        request(args, (error, response, body) ->
            if error
                callback_error(error)
            else
                try
                    json = JSON.parse(body)
                    callback_ok(json)
                catch e
                    callback_error('Unknown error happened')
        )

    headRequest: (url, timeout, callback) ->
        request = require("request")
        timeout = timeout or 5000
        args = {"url": url, "timeout": timeout}

        request.head(args, (error, response, body) ->
            callback(response)
        )


}
