/**
 * Created by a621275 on 07/06/2016.
 */
$(document).ready(function () {
    /*----------------------------
     jQuery MeanMenu
     ------------------------------ */
    jQuery('nav#dropdown').meanmenu();
});
$(document).on('page:change', function(event) {

    //    toggle class
    $(".buy-btn span").on("click", function() {
        $(".header-top-area").toggleClass("btn-none");
    });

    /*---------------------
     tooltip
     --------------------- */
    $('[data-toggle="tooltip"]').tooltip({
        animated: 'fade',
        placement: 'top',
        container: 'body'
    });
    /*----------------------------
     wow js active
     ------------------------------ */
    new WOW().init();
    /*----------------------------
     Countdown active
     ------------------------------ */
    $('[data-countdown]').each(function() {
        var $this = $(this),
            finalDate = $(this).data('countdown');
        $this.countdown(finalDate, function(event) {
            $this.html(event.strftime('<span class="cdown days"><span class="time-count">%-D<span>J</span></span></span><span class="cdown hour"><span class="time-count">%-H<span>H</span></span></span><span class="cdown minutes"><span class="time-count">%M<span>M</span></span></span> <span class="cdown second"><span class="time-count">%S<span>S</span></span></span>'));
        });
    });

    /*----------------------------
     owl active
     ------------------------------ */
    $(".total-product-slide").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        pagination: false,
        navigation: true,
        items: 3,
        /* transitionStyle : "fade", */
        /* [This code for animation ] */
        navigationText: false,
        itemsDesktop: [1199, 3],
        itemsDesktopSmall: [980, 3],
        itemsTablet: [768, 2],
        itemsMobile: [479, 1],
    });
    /*----------------------------
     owl active (total-tab-product)
     ------------------------------ */
    $(".total-tab-product").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        pagination: false,
        navigation: true,
        items: 5,
        itemsCustom : [
            [0, 1],
            [450, 2],
            [480, 2],
            [600, 2],
            [700, 3],
            [768, 3],
            [992, 4],
            [1199, 5]
        ],
        /* transitionStyle : "fade", */
        /* [This code for animation ] */
        navigationText: false,
    });

    /*----------------------------
     owl active
     ------------------------------ */
    $(".slide-blog" ).owlCarousel({
        autoPlay: false,
        slideSpeed:2000,
        pagination:false,
        navigation:true,
        items: 3,
        itemsCustom : [
            [0, 1],
            [450, 1],
            [480, 1],
            [600, 1],
            [700, 1],
            [768, 2],
            [992, 2],
            [1199, 3]
        ],
        /* transitionStyle : "fade", */    /* [This code for animation ] */
        navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
    });

    $(".new-arri-total").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 1,
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        itemsDesktop: [1199, 1],
        itemsDesktopSmall: [979, 1],
        itemsTablet: [768, 1]
    });
    /*----------------------------
     scrollUp
     ------------------------------ */
    // $.scrollUp({
    //     scrollText: '<i class="fa fa-angle-up"></i>',
    //     easingType: 'linear',
    //     scrollSpeed: 900,
    //     animation: 'fade'
    // });

    /*----------------------------
     Zoom carsoule active
     ------------------------------ */
    $("#gallery_01").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 3,
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        itemsDesktop: [1199, 3],
        itemsDesktopSmall: [979, 3],
        itemsTablet: [768, 2],
        itemsMobile: [480, 3]
    });


    /*----------------------------
     cart-plus-minus-button
     ------------------------------ */
    $(".cart-plus-minus")
    $(".qtybutton").on("click", function() {
        var $button = $(this);
        var oldValue = $button.parent().find("input").val();
        if ($button.text() == "+") {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            // Don't allow decrementing below zero
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
            }
        }
        $button.parent().find("input").val(newVal);
    });

    /*----------------------------
     fancybox active
     ------------------------------ */
    $(document).ready(function() {
        $('.fancybox').fancybox();
    });
    /*----------------------------
     Elevate Zoom active
     ------------------------------ */
    $("#zoom_03").elevateZoom({
        constrainType: "height",
        zoomType: "lens",
        containLensZoom: true,
        gallery: 'gallery_01',
        cursor: 'pointer',
        galleryActiveClass: "active"
    });

    //pass the images to Fancybox
    $("#zoom_03").bind("click", function(e) {
        var ez = $('#zoom_03').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });
    /*----------------------------
     menu click function
     ------------------------------ */
    $(".first").on('click', function() {
        $(this).toggleClass('clicked');
        $(".masud").slideToggle();
    });


});
