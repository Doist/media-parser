buster = require 'buster'

media_parser = require "../lib/media-parser.js"


buster.testCase "basic",

    'img.ly': ->
        result = media_parser.parse('This http://img.ly/yAqP Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 75)
        )
        buster.assert.equals(result, true)

    'instagram': ->
        result = media_parser.parse('This http://instagram.com/p/mu9zN9KjJL/ Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 150)
        )
        buster.assert.equals(result, true)

    'twitpic': ->
        result = media_parser.parse('This http://twitpic.com/1vm850 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 75)
        )
        buster.assert.equals(result, true)

    'yfrog': ->
        result = media_parser.parse('This http://yfrog.com/jukynnj Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 100)
        )
        buster.assert.equals(result, true)


buster.testCase "oembed_images",

    'flickr': ->
        result = media_parser.parse('This https://www.flickr.com/photos/muzuto/10624912815/ Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 75)
        )
        buster.assert.equals(result, true)

        result = media_parser.parse('This http://flic.kr/p/hTVoH1 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(400)[1], 550)
        )
        buster.assert.equals(result, true)

    'deviant_art': ->
        result = media_parser.parse('This http://www.deviantart.com/art/Growing-Bird-441918288 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 150)
        )
        buster.assert.equals(result, true)

        result = media_parser.parse('This http://fav.me/d4klbrc Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 300)
        )
        buster.assert.equals(result, true)

    'hulu': ->
        result = media_parser.parse('This http://www.hulu.com/watch/609104 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 145)
        )
        buster.assert.equals(result, true)

    'justin': ->
        result = media_parser.parse('This http://www.justin.tv/deepellumonair Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 150)
        )
        buster.assert.equals(result, true)

    'screenr': ->
        result = media_parser.parse('This http://www.screenr.com/NTHH Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 100)
        )
        buster.assert.equals(result, true)

    'rdio': ->
        result = media_parser.parse('This http://www.rdio.com/artist/The_Black_Keys/album/Brothers/ Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 200)
        )
        buster.assert.equals(result, true)

    'slideshare': ->
        result = media_parser.parse('This http://www.slideshare.net/goncalossilva/ruby-an-introduction Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 240)
        )
        buster.assert.equals(result, true)

    'soundcloud': ->
        result = media_parser.parse('This https://soundcloud.com/sizzlebird Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 100)
        )
        buster.assert.equals(result, true)

    'ted': ->
        result = media_parser.parse('This http://www.ted.com/talks/ken_robinson_says_schools_kill_creativity Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 480)
        )
        buster.assert.equals(result, true)

    'vimeo': ->
        result = media_parser.parse('This http://vimeo.com/album/2642665/video/74622970 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 100)
        )
        buster.assert.equals(result, true)

    'youtube': ->
        result = media_parser.parse('This http://www.youtube.com/watch?v=9bZkp7q19f0 Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 480)
        )
        buster.assert.equals(result, true)

    'youtube_bug': ->
        result = media_parser.parse('This http://www.youtube.com/watch?v=9bZkp7q19f0/ Test', (obj) ->
            buster.assert.equals(obj.get_thumbnail_url(55)[1], 480)
        )
        buster.assert.equals(result, true)
