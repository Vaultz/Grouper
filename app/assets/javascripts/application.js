// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  if($('#notice').html() == '') {
    $('#notice').removeClass('alert alert-success');
  } else {
    $('#notice').addClass('alert alert-success');
    setTimeout(function(){
      $('#notice').remove();
    }, 3000);
  }

  $('.nav_mobile').hide();

  $(window).resize(function () {
    var width = $(window).width();
    if (width > 550) {
      $('.nav_mobile').hide();
      $('.header ul li').not('.open_menu').show();
    } else {
      $('.header ul li').not('.open_menu').hide();
      $('.open_menu').show();
    }
  });

  $(document).on('click', '.fa-bars', function() {
    $('.nav_mobile').css('display', 'block');
  });

  $(document).on('click', '.fa-times-circle-o', function() {
    $('.nav_mobile').css('display', 'none');
  });

});
