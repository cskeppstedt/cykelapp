module.exports = (grunt) ->

  pkg = require './package.json'

  grunt.initConfig
    pkg: pkg

    clean: ['dist']

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

    watch:
      options:
        livereload: true
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['reload']
      gruntfile:
        files: ['Gruntfile.coffee']
        tasks: ['reload']
      html:
        files: ['index.html']
        tasks: ['reload']
      less:
        files: ['src/less/**/*.less']
        tasks: ['reload']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-preprocess'

  grunt.registerTask 'build',   ['clean','coffee','less','preprocess','copy']
  grunt.registerTask 'reload',  ['build']
  grunt.registerTask 'default', ['build','connect', 'watch']