MediaServices = {

    providers: {
        'Imgly': /https?:\/\/(?:www\.)?img\.ly\/(\w+)\/?/i
        'Instagram': /https?:\/\/(?:www\.)?(?:instagr\.am|instagram\.com)\/p\/([\w-]+)\/?/i
        'Twitpic': /https?:\/\/(?:www\.)?twitpic\.com\/(\w+)\/?/i
        'Yfrog': /https?:\/\/(?:www\.)?(?:\w+\.)?yfrog\.com\/(\w+)\/?/i
        'Flickr': /https?:\/\/(?:www\.)?(?:flic\.kr\/p|flickr.com\/photos)\/[^\s]+\/?/i
        'DevaiantArt': new RegExp("https?://(?:www\\.)?" +
                       "(?:[\\w-]+\\.deviantart\\.com/(?:art/|[^/]+#/d)|fav\\.me/|sta\\.sh/)" +
                       "[\\w-]+/?", 'i')
        'Hulu': new RegExp("https?://(?:www\\.)?hulu\\.com/watch/[\\w\\-/]+", 'i')
        'JustinTv': new RegExp("https?://(?:www\\.)?justin\\.tv/[\\w\\-]+/?", 'i')
        'Screenr': new RegExp("https?://(?:www\\.)?screenr\\.com/\\w+/?", 'i')
        'Rdio': new RegExp("https?://(?:www\\.)?rdio\\.com/artist/[\\w\\-/]+", 'i')
        'Soundcloud': new RegExp("https?://(?:www\\.)?soundcloud\\.com/[\\w\\-/]+", 'i')
        'Spotify': new RegExp("https?://(?:www|open|play)\\.?spotify\\.com/(?:artist|track)/[\\w\\-/]+", 'i')
        'Ted': new RegExp("https?://(?:www\\.)?ted\\.com/talks/[\\w]+", 'i')
        'Vimeo': new RegExp("https?://(?:www\\.)?vimeo\\.com/(?:album/\\w+/video/|groups/\\w+/videos/)?\\w+/?", 'i')
        'Slideshare': new RegExp("https?://(?:www\\.)?slideshare\\.net/[\\w\\-]+/[\\w\\-]+", 'i')
        'Youtube': new RegExp("https?://(?:www\\.)?(?:youtube\\.com/watch\\?v=|youtu\\.be/)[\\w-]+/?", 'i')
    }
    providers_cached: null
    providers_cached_reg_exp: null

    getProviders: ->
        if !MediaServices.providers_cached
            providers = MediaServices.providers

            reg_exps = []
            for key, reg_exp of providers
                reg_exps.push('(?:' + reg_exp.source.replace(/\\/g, '\\\\') + ')')

            MediaServices.providers_cached = {
                'pattern': reg_exps.join('|')
                'providers': providers
            }
        return MediaServices.providers_cached

    getProvidersPattern: ->
        if !MediaServices.providers_cached_reg_exp
            reg_exps = []
            for key, reg_exp of MediaServices.providers
                reg_exps.push('(?:' + reg_exp.source + ')')
            MediaServices.providers_cached_reg_exp = new RegExp(reg_exps.join('|'), 'ig')
        return MediaServices.providers_cached_reg_exp

    # --- Imgly
    parseImgly: (cnt, callback) ->
        match = cnt.match(MediaServices.providers.Imgly)
        if match
            MediaTypes.imageEntity(callback, {
                'sizes': {
                    'thumb': 50,
                    'mini': 75,
                    'medium': 240,
                    'large': 550,
                    'full': -1
                }
                'match': match
                'url_template': 'https://img.ly/show/{0}/{1}'
            })
            return true

    # --- Instagram
    parseInstagram: (cnt, callback) ->
        match = cnt.match(MediaServices.providers.Instagram)
        if match
            MediaTypes.imageEntity(callback, {
                'sizes': {
                    't': 150,
                    'm': 306,
                    'l': -1
                }
                'match': match
                'url_template': 'https://instagram.com/p/{1}/media/?size={0}'
            })
            return true

    # --- Twitpic
    parseTwitpic: (cnt, callback) ->
        match = cnt.match(MediaServices.providers.Twitpic)
        if match
            MediaTypes.imageEntity(callback, {
                'sizes': {
                    'mini': 75,
                    'thumb': 50,
                    'large': -1
                }
                'match': match
                'url_template': 'https://twitpic.com/show/{0}/{1}'
            })
            return true

    # --- Yfrog
    parseYfrog: (cnt, callback) ->
        match = cnt.match(MediaServices.providers.Yfrog)
        if match
            MediaTypes.imageEntity(callback, {
                'sizes': {
                    'small': 100,
                    'medium': 640
                }
                'match': match
                'url_template': 'https://yfrog.com/{1}:{0}'
            })
            return true

    # --- Flickr
    parseFlickr: (cnt, callback, timeout) ->
        match = cnt.match(MediaServices.providers.Flickr)
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'timeout': timeout
                'sizes': {
                    't': 75,
                    'm': 150,
                    'n': 240,
                    'z': 550
                }
                'match': match
                'oembed_template': 'https://www.flickr.com/services/oembed?url={0}&format=json'
                'custom_thumbnail_url': (turl, best_size) ->
                    return turl.replace(/_[sqtmnzcbo]\.((?:jpg)|(?:gif)|(?:png))$/, "_" + best_size + '.$1')
            })
            return true

    # --- Devaiant Art
    parseDeviantArt: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.DevaiantArt,
                                         'https://backend.deviantart.com/oembed?url={0}&format=json',
                                         timeout)


    # --- Hulu
    parseHulu: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Hulu,
                                         'http://www.hulu.com/api/oembed?url={0}&format=json',
                                         timeout)

    # --- Justin
    parseJustin: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.JustinTv,
                                         'http://api.justin.tv/api/embed/from_url.json?url={0}',
                                         timeout)

    # --- Screenr
    parseScreenr: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Screenr,
                                         "http://www.screenr.com/api/oembed.json?url={0}",
                                         timeout)

    # --- Rdio
    parseRdio: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Rdio,
                                         "http://www.rdio.com/api/oembed/?url={0}&format=json",
                                         timeout)
    # --- Soundcloud
    parseSoundCloud: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Soundcloud,
                                         "https://soundcloud.com/oembed?url={0}&format=json",
                                         timeout)

    # --- Spotify
    parseSpotify: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Spotify,
                                         "https://embed.spotify.com/oembed/?url={0}&format=json",
                                         timeout)

    # --- Ted
    parseTed: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Ted,
                                         "http://www.ted.com/talks/oembed.json?url={0}",
                                         timeout)

    # --- Vimeo
    parseVimeo: (cnt, callback, timeout) ->
        match = cnt.match(MediaServices.providers.Vimeo)
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'timeout': timeout
                'sizes': {
                    '100': 100,
                    '200': 200,
                    '640': 640
                }
                'match': match
                'oembed_template': "http://vimeo.com/api/oembed.json?url={0}"
                'custom_thumbnail_url': (turl, best_size) ->
                    return turl.replace(/_\d+\.jpg$/i, "_" + best_size + ".jpg")
            })
            return true

    # --- Slideshare
    parseSlideshare: (cnt, callback, timeout) ->
        match = cnt.match(MediaServices.providers.Slideshare)
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'timeout': timeout
                'sizes': {
                    '3': 240,
                    '4': 576
                }
                'match': match
                'oembed_template': "http://www.slideshare.net/api/oembed/2?url={0}&format=json"
                'custom_thumbnail_url': (turl, best_size, json) ->
                    turl = json.thumbnail
                    turl = turl.replace(/thumbnail(?:-\d)?\.jpg/, "thumbnail-" + best_size + ".jpg")
                    if turl.indexOf('http') != 0
                        turl = 'http:' + turl
                    return turl
            })
            return true

    # --- Youtube
    parseYoutube: (cnt, callback, timeout) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         MediaServices.providers.Youtube,
                                         "http://www.youtube.com/oembed?url={0}&format=json",
                                         timeout)


}
