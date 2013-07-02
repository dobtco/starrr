module.exports = function(grunt) {

  var path = require('path');
  var exec = require('child_process').exec;
  var tasks = ['coffee', 'sass', 'uglify'];

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.initConfig({

    pkg: '<json:package.json>',

    coffee: {
      all: {
        src: 'coffee/jquery.starrr.coffee',
        dest: 'js/jquery.starrr.js',
        options: {bare: true}
      },
    },

    sass: {
      all: {
        files: {
          'css/jquery.starrr.css': 'scss/jquery.starrr.scss',
          'css/demo.css': 'scss/demo.scss'
        }
      }
    },

    uglify: {
      options: {},
      all: {
        files: {
          'dist/jquery.starrr.min.js': 'js/jquery.starrr.js'
        }
      }
    },

    watch: {
      app: {
        files: ['./coffee/*.coffee', './scss/*.scss'],
        tasks: tasks
      }
    }
  });

  grunt.registerTask('default', tasks);

};
