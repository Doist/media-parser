class GWebHttpService

    timeout: 5000 # 5sec
    uniq_fn_id: 1
    callbacks: {}

    oembedRequest: (url, ok_callback, error_callback, content_url) =>
        # Reference structure
        uniq_fn_id = @uniq_fn_id++
        callback_id = "callback_#{uniq_fn_id}"

        callback_data = @callbacks[callback_id] = {
            'ok': ok_callback,
            'error': error_callback,
            'timeout': null
            'script': null
        }

        # Callback
        callback = @[callback_id] = (data) =>
            callback_data = @callbacks[callback_id]

            if callback_data
                if data and !data.error
                    callback_data.ok(data)
                else
                    callback_data.error(data)

                # Clean state
                delete @[callback_id]
                delete @callbacks[callback_id]

                callback_data.script.parentNode.removeChild(script)
                clearTimeout(callback_data.timeout)

        callback_data.timeout = setTimeout(->
            callback({'error': 'Tiemout'})
        , @timeout)

        # Urls
        enc_url = encodeURIComponent(content_url.replace('https', 'http'))
        onem_url = "https://noembed.com/embed?url=#{enc_url}&callback=WebHttpService.#{callback_id}"

        # Add the script tag to body
        callback_data.script = script = document.createElement('script')
        script.setAttribute('src', onem_url)
        script.setAttribute('type', 'text/javascript')
        document.getElementsByTagName("head")[0].appendChild(script)

try
    window.WebHttpService = new GWebHttpService()
catch e
    null
