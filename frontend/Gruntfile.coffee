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
      backbonefixtures:
        expand: true
        cwd:    'vendor/bower/backbone-fixtures/'
        src:    'backbone-fixtures.js'
        dest:   'dist/vendor/'
      almond:
        expand: true
        cwd:    'vendor/bower/almond/'
        src:    'almond.js'
        dest:   'dist/vendor/'
      requirejs:
        expand: true
        cwd:    'vendor/bower/requirejs/'
        src:    'require.js'
        dest:   'dist/vendor/'
      backbone:
        expand: true
        cwd:    'vendor/bower/backbone/'
        src:    'backbone.js'
        dest:   'dist/vendor/'
      jquery:
        expand: true
        cwd:    'vendor/bower/jquery/'
        src:    'jquery.js'
        dest:   'dist/vendor/'
      underscore:
        expand: true
        cwd:    'vendor/bower/underscore/'
        src:    'underscore.js'
        dest:   'dist/vendor/'

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

    processhtml:
      dist:
        files:
          "dist/index.html": ["index.html"]

    watch:
      options:
        livereload: true
      src:
        files: ['src/**/*.coffee','src/**/*.less','Gruntfile.coffee']
        tasks: ['default']

    requirejs:
      dist:
        options:
          mainConfigFile: "dist/js/config.js"
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
    'clean', 'coffee', 'less', 'copy', 'requirejs', 'processhtml'
  ]

  grunt.registerTask 'dev', [
    'default', 'connect', 'watch'
  ]
