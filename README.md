Simple JavaScript library to ease integration with media. Useful for obtaining direct links to media content and thumbnails.

## Example from node

    $ node
    > media_parser = require('./build/media_parser.js')
    > handle_fn = function(obj) { console.log(obj); console.log(obj.get_thumbnail_url(55)); }
    > media_parser.parse('This is a test http://www.youtube.com/watch?v=9bZkp7q19f0', handle_fn)
    > { content_url: 'http://www.youtube.com/watch?v=9bZkp7q19f0',
        get_thumbnail_url: [Function],
        title: 'PSY - GANGNAM STYLE (강남스타일) M/V',
        oemebed_result: 
         { thumbnail_height: 360,
           author_name: 'officialpsy',
           height: 270,
           provider_url: 'http://www.youtube.com/',
           title: 'PSY - GANGNAM STYLE (강남스타일) M/V',
           provider_name: 'YouTube',
           html: '<iframe width="480" height="270" src="http://www.youtube.com/embed/9bZkp7q19f0?feature=oembed" frameborder="0" allowfullscreen></iframe>',
           thumbnail_width: 480,
           type: 'video',
           thumbnail_url: 'http://i1.ytimg.com/vi/9bZkp7q19f0/hqdefault.jpg',
           version: '1.0',
           width: 480,
           author_url: 'http://www.youtube.com/user/officialpsy' } }
        [ 'https://i1.ytimg.com/vi/9bZkp7q19f0/hqdefault.jpg', 480 ]


## TODO
... More documentation will be added soon ...

    
## Supported services
These services are supported:

- deviantart.com
- flickr.com
- hulu.com
- img.ly
- instagr.am
- justin.tv
- rdio.com
- screenr.com
- slideshare.com
- soundcloud.com
- spotify.com
- ted.com
- twitpic.com
- vimeo.com
- yfrog.com
- youtube.com