cat src/media*.coffee src/httpservice_* src/exports.coffee > lib/media-parser.coffee
coffee -cb lib/media-parser.coffee 
rm lib/media-parser.coffee 
