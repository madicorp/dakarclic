// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require mustache
//= require meanmenu
//= require jquery.nivo.slider
//= require wow.min
//= require owl.carousel.min
//= require jquery.countdown.min
//= require jquery.fancybox.pack
//= require jquery.elevateZoom-3.0.8.min
//= require main
//= require auction_websocket
$(document).on('page:change',function (event) {
    (function ($) {
        "use strict";

        //---------------------------------------------
        //Nivo slider
        //---------------------------------------------
        $('#ensign-nivoslider').nivoSlider({
            effect: 'random',
            slices: 15,
            boxCols: 8,
            boxRows: 4,
            animSpeed: 500,
            pauseTime: 5000,
            startSlide: 0,
            directionNav: true,
            controlNavThumbs: true,
            pauseOnHover: true,
            manualAdvance: false
        });

        $('#ensign-nivoslider-2').nivoSlider({
            effect: 'random',
            slices: 15,
            boxCols: 8,
            boxRows: 4,
            animSpeed: 500,
            pauseTime: 5000,
            startSlide: 0,
            directionNav: true,
            controlNavThumbs: true,
            pauseOnHover: true,
            manualAdvance: false
        });

        $('#ensign-nivoslider-3').nivoSlider({
            effect: 'random',
            slices: 15,
            boxCols: 8,
            boxRows: 4,
            animSpeed: 500,
            pauseTime: 5000,
            startSlide: 0,
            directionNav: true,
            controlNavThumbs: false,
            pauseOnHover: true,
            manualAdvance: false
        });
    })(jQuery);
});




