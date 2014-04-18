# Parse media easily
Simple JavaScript library to ease integration with media and oEmbed. Useful for obtaining direct links to media content and thumbnails. Uses a combination of oEmbed APIs and custom APIs.

You should see [media-embed-server](https://github.com/Doist/media-embed-server) for a server that provides this as a JSON/JSONP service.


## Installing the library
Installing the service is quite easy:
    
    npm install media-parser


## Parsing info about a resource

```js
// Signature (timeout is in milliseconds):
media_parser = require('media-parser')
media_parser.parse(content, callback, timeout=5000)
```

```js
// Example
media_parser = require('media-parser')
callback = function(obj) { 
    console.log(obj); 
    console.log(obj.get_thumbnail_url(55)); 
}
media_parser.parse('This is a test http://www.youtube.com/watch?v=9bZkp7q19f0', callback)

// Will print
{ 
    "get_thumbnail_url": [Function],
    "title": 'PSY - GANGNAM STYLE (강남스타일) M/V',
    "raw": { .. raw oEmbed data .. }
}
```


## Other useful functions

```js
// Extract supported URLs from content
media_parser.extractURLs(content)
```

```js
// Return an object of supported services:
media_parser.getProviders()
```

```js
// Return a pattern that can match supported services:
media_parser.getProvidersPattern()
```

## Running tests

Requires [buster](https://www.npmjs.org/package/buster):

    sh compile.sh; buster-test


## Adding a new service

It should be quite trivial to add a new service:

1) Add a new handler in `src/media_services.coffee`
2) Add the handler to `src/media_parser.coffee`
3) Add a test suite in `tests/test_core.coffee`
4) Test using `sh compile.sh; buster-test`

    
## Supported services
These services are supported:

- deviantart.com (oEmbed)
- flickr.com (oEmbed)
- hulu.com (oEmbed)
- justin.tv (oEmbed)
- rdio.com  (oEmbed)
- screenr.com  (oEmbed)
- slideshare.com (oEmbed)
- soundcloud.com (oEmbed)
- spotify.com (oEmbed)
- ted.com (oEmbed)
- vimeo.com (oEmbed)
- youtube.com (oEmbed)
- img.ly (custom)
- instagr.am (custom)
- twitpic.com (custom)
- yfrog.com (custom)


Related
=======
* [TodoistMediaParser](https://github.com/Doist/TodoistMediaParser) - similar version done in Java


Authors
=======
* [Amir Salihefendic](https://github.com/amix)
* [Gonçalo Silva](https://github.com/goncalossilva)
