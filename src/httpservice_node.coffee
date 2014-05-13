NodeHttpService = {

    oembedRequest: (url, callback_ok, callback_error,
                    content_url, timeout) ->
        needle = require("needle")
        timeout = timeout or 5000
        args = {"timeout": timeout}

        needle.get(url, args, (error, response) ->
            if error or response.statusCode != 200
                callback_error(error)
            else
                try
                    body = response.body
                    if typeof(body) == 'string'
                        json = JSON.parse(body)
                    else
                        json = body
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
