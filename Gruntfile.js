module.exports = function(grunt) {
  
  const sass = require('node-sass');

  grunt.initConfig({

    // Watches for changes and runs tasks
    // Livereload is setup for the 35729 port by default
    watch: {
      sass: {
        files: ['sass/**/*.scss'],
        tasks: ['sass:dev']
      },
      php: {
        files: ['**/*.php']
      },
      scripts: {
        files: ['js/*.js'],
        tasks: ['uglify']
      },
      options: {
        nospawn: true,
        livereload: 35729
      }
    },

    // Sass object
    sass: {
      dev: {
        options: {
          implementation: sass,
          compass: true
        },
        files: [
          {
            src: ['**/*.scss', '!**/_*.scss'],
            cwd: 'sass',
            dest: '',
            ext: '.css',
            expand: true
          }
        ]
      }
    },

    // Javascripts
    uglify: {
      options: {
        mangle: false,
        sourceMap: true
      },
      my_target: {
        files: {
          'js/application.min.js': [
            // Add your specfic JS files here
            'js/application.js', 
          ]
        }
      }
    }

  });

  // Default task
  grunt.registerTask('default', ['watch']);

  // Load up tasks
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');

};
