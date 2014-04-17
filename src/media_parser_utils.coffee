MediaParserUtils = {

    format: ->
        s = arguments[0]
        for i in [0..arguments.length-1]
            reg = new RegExp("\\{" + i + "\\}", "gm")
            s = s.replace(reg, arguments[i + 1])
        return s

    getBestSize: (sizes, size_width) ->
        sizes_sorted = []

        for key, value of sizes
            sizes_sorted.push([key, value])

        sizes_sorted = sizes_sorted.sort((a, b) ->
            return a[1] - b[1]
        )

        for pair in sizes_sorted
            key = pair[0]
            value = pair[1]
            if value >= size_width
                return key
        return key

}
