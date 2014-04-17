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
                json = JSON.parse(body)
                callback_ok(json)
        )

}
