MediaServices = {

    # --- Imgly
    parseImgly: (cnt, callback) ->
        match = cnt.match(/https?:\/\/(?:www\.)?img\.ly\/(\w+)\/?/i)
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
        match = cnt.match(/https?:\/\/(?:www\.)?(?:instagr\.am|instagram\.com)\/p\/([\w-]+)\/?/i)
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
        match = cnt.match(/https?:\/\/(?:www\.)?twitpic\.com\/(\w+)\/?/i)
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
        match = cnt.match(/https?:\/\/(?:www\.)?(?:\w+\.)?yfrog\.com\/(\w+)\/?/i)
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
    parseFlickr: (cnt, callback) ->
        match = cnt.match(/https?:\/\/(?:www\.)?(?:flic\.kr\/p|flickr.com\/photos)\/[^\s]+\/?/i)
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'media_type': 'image'
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
    parseDeviantArt: (cnt, callback) ->
        reg_exp = "https?://(?:www\\.)?" +
                  "(?:[\\w-]+\\.deviantart\\.com/(?:art/|[^/]+#/d)|fav\\.me/|sta\\.sh/)" +
                  "[\\w-]+/?"
        return MediaTypes.genericOemebed(cnt, callback,
                                         reg_exp,
                                         'https://backend.deviantart.com/oembed?url={0}&format=json',
                                         'image')


    # --- Hulu
    parseHulu: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?hulu\\.com/watch/[\\w\\-/]+",
                                         'http://www.hulu.com/api/oembed?url={0}&format=json',
                                         'video')

    # --- Justin
    parseJustin: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?justin\\.tv/[\\w\\-]+/?",
                                         'http://api.justin.tv/api/embed/from_url.json?url={0}',
                                         'video')

    # --- Screenr
    parseScreenr: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?screenr\\.com/\\w+/?",
                                         "http://www.screenr.com/api/oembed.json?url={0}",
                                         'video')

    # --- Rdio
    parseRdio: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?rdio\\.com/artist/[\\w\\-/]+",
                                         "http://www.rdio.com/api/oembed/?url={0}&format=json",
                                         'audio')
    # --- Soundcloud
    parseSoundCloud: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?soundcloud\\.com/[\\w\\-/]+",
                                         "https://soundcloud.com/oembed?url={0}&format=json",
                                         'audio')

    # --- Spotify
    parseSpotify: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www|open|play)\\.?spotify\\.com/(?:artist|track)/[\\w\\-/]+",
                                         "https://embed.spotify.com/oembed/?url={0}&format=json",
                                         'audio')

    # --- Ted
    parseTed: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?ted\\.com/talks/[\\w]+",
                                         "http://www.ted.com/talks/oembed.json?url={0}",
                                         'video')

    # --- Vimeo
    parseVimeo: (cnt, callback) ->
        match = cnt.match(new RegExp("https?://(?:www\\.)?vimeo\\.com/(?:album/\\w+/video/|groups/\\w+/videos/)?\\w+/?", 'i'))
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'media_type': 'video'
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
    parseSlideshare: (cnt, callback) ->
        match = cnt.match(new RegExp("https?://(?:www\\.)?slideshare\\.net/[\\w\\-]+/[\\w\\-]+", 'i'))
        if match
            MediaTypes.oembedImageEntitiy(callback, {
                'sizes': {
                    '3': 240,
                    '4': 576
                }
                'match': match
                'oembed_template': "http://www.slideshare.net/api/oembed/2?url={0}&format=json"
                'custom_thumbnail_url': (turl, best_size, json) ->
                    turl = json.thumbnail
                    return turl.replace(/thumbnail(?:-\d)?\.jpg/, "thumbnail-" + best_size + ".jpg")
            })
            return true

    # --- Youtube
    parseYoutube: (cnt, callback) ->
        return MediaTypes.genericOemebed(cnt, callback,
                                         "https?://(?:www\\.)?(?:youtube\\.com/watch\\?v=|youtu\\.be/)[\\w-]+/?",
                                         "http://www.youtube.com/oembed?url={0}&format=json",
                                         'video')


}
