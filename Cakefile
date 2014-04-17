{spawn, exec} = require 'child_process'

option '-p', '--prefix [DIR]', 'set the installation prefix for `cake install`'

task 'build', 'build media-parser package', ->
  compile = spawn 'sh', ['compile.sh']
  compile.stdout.on 'data', (data) -> console.log data.toString().trim()
