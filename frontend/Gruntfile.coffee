module.exports = (grunt) ->

  pkg = require './package.json'

  grunt.initConfig
    pkg: pkg

    coffee:
      compile:
        files: [
          expand: true
          dest: 'temp/'
          cwd: 'src'
          src: '**/*.coffee'
          ext: '.js'
        ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default', ['coffee']
