module.exports = (grunt) ->

  pkg = require './package.json'

  grunt.initConfig
    pkg: pkg

    clean: ['temp', 'dist/']

    coffee:
      compile:
        # options:
        #   sourceMap: true
        files: [
          expand: true
          dest: 'dist/js/'
          cwd: 'src/coffee/'
          src: '**/*.coffee'
          ext: '.js'
        ]

    less:
      dist:
        options:
          cleancss: true
        files:
          'dist/css/main.css': ['src/less/**/*.less']

    copy:
      fixtures:
        expand: true
        cwd:    'src/'
        src:    ['fixtures/**']
        dest:   'dist/'
      vendor:
        expand: true
        flatten: true
        cwd: 'vendor/bower/'
        dest: 'dist/js/vendor/'
        src: [
          'backbone-fixtures/backbone-fixtures.js'
          'almond/almond.js'
          'requirejs/require.js'
          'backbone/backbone.js'
          'underscore/underscore.js'
          'jquery/jquery.js'
          'typeahead.js/dist/typeahead.bundle.js'
        ]
      fontawesome:
        expand: true
        cwd: 'vendor/bower/components-font-awesome/'
        src: [
          'css/font-awesome.min.css'
          'fonts/**/*'
        ]
        dest: 'dist/css/vendor/font-awesome/'


    preprocess:
      options:
        context:
          DEBUG: true
      html:
        src:  'index.html'
        dest: 'dist/index.html'

    connect:
      server:
        options:
          base: 'dist'
          open: true
          hostname: 'localhost'
          port: 8001

    processhtml:
      dist:
        files:
          "dist/index.html": ["index.html"]

    watch:
      options:
        livereload: true
      src:
        files: ['src/**/*.coffee','src/**/*.less','Gruntfile.coffee','index.html']
        tasks: ['default']

    requirejs:
      dist:
        options:
          generateSourceMaps: true
          include: ["main"]
          out: "dist/js/cykelapp.min.js"
          optimize: "uglify2"

          # Since we bootstrap with nested `require` calls this option allows
          # R.js to find them.
          findNestedDependencies: true

          # Include a minimal AMD implementation shim.
          name: "main"

          # Setting the base url to the distribution directory allows the
          # Uglify minification process to correctly map paths for source maps.
          baseUrl: "dist/js"

          # Wrap everything in an IIFE.
          wrap: true
          preserveLicenseComments: false


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-processhtml'


  grunt.registerTask 'default', [
    'clean'
    'coffee'
    'less'
    'copy'
    #'requirejs'
    'processhtml'
  ]


  grunt.registerTask 'dev', [
    'default'
    'connect'
    'watch'
  ]
