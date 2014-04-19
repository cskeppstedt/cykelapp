module.exports = (grunt) ->

  pkg = require './package.json'

  grunt.initConfig
    pkg: pkg

    clean: ['temp', 'dist/js/']

    coffee:
      compile:
        files: [
          expand: true
          dest: 'dist/src/'
          cwd: 'src/'
          src: '**/*.coffee'
          ext: '.js'
        ]

    less:
      dist:
        options:
          cleancss: true,
        files:
          'dist/styles.css': ['src/styles/**/*.less']

    processhtml:
      dist:
        files:
          "dist/index.html": ["index.html"]
    copy:
      dist:
        files: [
          { src: "vendor/**", dest: "dist/" }
        ]
    
    connect:
      server:
        options:
          open: true
          base: 'dist'
          hostname: 'localhost'

    watch:
      options:
        livereload: true
      src:
        files: ['src/**/*.coffee','src/**/*.less']
        tasks: ['default']

    requirejs:
      dist:
        options:
          mainConfigFile: "dist/src/config.js"
          generateSourceMaps: true
          include: ["main"]
          out: "dist/source.min.js"
          optimize: "uglify2"

          # Since we bootstrap with nested `require` calls this option allows
          # R.js to find them.
          findNestedDependencies: true

          # Include a minimal AMD implementation shim.
          name: "almond"

          # Setting the base url to the distribution directory allows the
          # Uglify minification process to correctly map paths for source maps.
          baseUrl: "dist/src"

          # Wrap everything in an IIFE.
          wrap: true
          preserveLicenseComments: false
  

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-processhtml'
  grunt.loadNpmTasks 'grunt-bbb-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', [
    'clean', 'coffee', 'less', 'copy', 'requirejs', 'processhtml'
  ]

  grunt.registerTask 'dev', [
    'default', 'connect', 'watch'
  ]