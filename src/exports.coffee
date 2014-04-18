try
    exports.init = MediaParser.init
    exports.parse = MediaParser.parse
    exports.extractURLs = MediaParser.extractURLs
catch e1
    null

try
    exports.getProviders = MediaServices.getProviders
    exports.getProvidersPattern = MediaServices.getProvidersPattern
catch e2
    null
