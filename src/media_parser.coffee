MediaParser = {

    services: []

    init: (http_service) ->
        @http_service = http_service or NodeHttpService

        @services.push(MediaServices.parseImgly)
        @services.push(MediaServices.parseInstagram)
        @services.push(MediaServices.parseFlickr)
        @services.push(MediaServices.parseTwitpic)
        @services.push(MediaServices.parseYfrog)
        @services.push(MediaServices.parseDeviantArt)
        @services.push(MediaServices.parseHulu)
        @services.push(MediaServices.parseJustin)
        @services.push(MediaServices.parseScreenr)
        @services.push(MediaServices.parseRdio)
        @services.push(MediaServices.parseSoundCloud)
        @services.push(MediaServices.parseSpotify)
        @services.push(MediaServices.parseTed)
        @services.push(MediaServices.parseVimeo)
        @services.push(MediaServices.parseYoutube)
        @services.push(MediaServices.parseSlideshare)

    parse: (cnt, callback, timeout) ->
        if !MediaParser.http_service
            MediaParser.init()

        for service in MediaParser.services
            has_match = service(cnt, callback, timeout)
            if has_match
                return true

        callback(null)

    extractURLs: (content) ->
        pattern = MediaServices.getProvidersPattern()
        return content.match(pattern) or []

}
