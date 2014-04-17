try
    window.WebHttpService = new GWebHttpService()
catch e
    null

try
    exports.MediaParser = MediaParser
catch e
    window.MediaParser = MediaParser

try
    exports.parse = MediaParser.parse
catch e1
    null

try
    exports.NodeHttpService = NodeHttpService
catch e
    null

