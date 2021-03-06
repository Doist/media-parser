MediaTypes = {

    imageEntity: (callback, opts) ->
        return callback({
            'underlying_type': opts.underlying_type
            'sizes': opts.sizes
            'content_url': opts.match[0]
            'get_thumbnail_url': (size) ->
                best_size = MediaParserUtils.getBestSize(opts.sizes, size)
                if best_size
                    width = opts.sizes[best_size]
                    url = MediaParserUtils.format(opts.url_template, best_size, opts.match[1])
                    return [url, width, width]
        })

    genericOemebed: (cnt, callback, reg_exp, oembed_template, timeout, underlying_type) ->
        match = cnt.match(reg_exp)

        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'underlying_type': underlying_type
                'timeout': timeout
                'match': match
                'oembed_template': oembed_template
            })
            return true

    oembedImageEntitiy: (callback, opts) ->
        content_url = opts.match[0]
        req_url = MediaParserUtils.format(opts.oembed_template, content_url)

        cb_ok = (json) ->
            result = {
                'get_thumbnail_url': (size) ->
                    # Custom
                    if opts.custom_thumbnail_url
                        best_size = MediaParserUtils.getBestSize(opts.sizes, size)
                        if best_size
                            width = opts.sizes[best_size]
                            turl = json.thumbnail_url
                            custom_turl = opts.custom_thumbnail_url(turl, best_size, json)
                            custom_turl[0] = custom_turl[0].replace('http:', 'https:')
                            return custom_turl

                    # Default
                    turl = json.thumbnail_url
                    twidth = json.thumbnail_width or 100
                    theight = json.thumbnail_height or twidth
                    if turl
                        return [turl.replace('http:', 'https:'), twidth, theight]
            }

            if json.url
                result.content_url = json.url

            if opts.sizes
                result.thumbnail_sizes = opts.sizes

            result.title = json.title or ''
            result.raw = json
            result.underlying_type = opts.underlying_type

            # Resolve content type
            if result.content_url
                cb_head = (head_res) ->
                    if head_res
                        content_type = head_res.headers and head_res.headers['content-type']

                        if content_type
                            result.content_type = content_type
                        else
                            result.content_type = 'application/octet-stream'

                    callback(result)
                MediaParser.http_service.headRequest(result.content_url, opts.timeout, cb_head)
            else
                callback(result)

        cb_error = (json, err) ->
            callback(null)

        MediaParser.http_service.oembedRequest(req_url, cb_ok, cb_error,
                                               content_url, opts.timeout)

}
