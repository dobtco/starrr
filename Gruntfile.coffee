module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-release')

  grunt.initConfig
    pkg: '<json:package.json>'

    coffee:
      all:
        src: 'starrr.coffee',
        dest: 'starrr.js',
        options:
          bare: true

    sass:
      all:
        files:
          'starrr.css': 'starrr.scss'

    cssmin:
      dist:
        files:
          'starrr.min.css': 'starrr.css'

    uglify:
      dist:
        files:
          'starrr.min.js': 'starrr.js'

    watch:
      all:
        files: ['starrr.coffee', 'starrr.scss']
        tasks: 'default'

    release:
      options:
        file: 'bower.json'
        npm: false

  grunt.registerTask 'default', ['coffee:all', 'sass:all', 'cssmin:dist', 'uglify:dist']
