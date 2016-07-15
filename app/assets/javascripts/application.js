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

$( document ).ready(function() {

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

            //scroll to animation

            $("a[href^='#'][data-toggle!='modal']").click(function (e) {
                e.preventDefault();
                var margin = 50;
                if ($(document).scrollTop() <= 180)
                {
                    margin += 50;
                }
                var element = $(this).attr("href");
                $("html, body").delay(300).animate({scrollTop: $(element).offset().top - margin }, 2000);
                return false;
            });

            $(document).scroll(function(e){
                var scrollTop = $(document).scrollTop();
                if(scrollTop > 200){
                    $("#scrollUp").css("display","block");
                }else{
                    $("#scrollUp").css("display","none");
                }
                if(scrollTop >= 180){
                    $('.menu-area').removeClass('navbar-static-top').addClass('navbar-fixed-top');
                } else {
                    $('.menu-area').removeClass('navbar-fixed-top').addClass('navbar-static-top');
                }
            });
        })(jQuery);
    });

    //Spinner
    // hide spinner
    $(".bg_load").hide();


    // show spinner on AJAX start
    $(document).ajaxStart(function(){
        $(".bg_load").show();
    });

    // hide spinner on AJAX stop
    $(document).ajaxStop(function(){
        $(".bg_load").hide();
    });

    $(document).on("page:fetch", function(){
        $(".bg_load").show();
    });

    $(document).on("page:receive", function(){
        $(".bg_load").hide();
    });

});




