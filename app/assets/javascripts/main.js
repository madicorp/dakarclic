/**
 * Created by a621275 on 07/06/2016.
 */
$(document).on('ready page:load', function(event) {


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
    $("a[href^='#'][data-toggle!='modal'][data-toggle!='collapse']").click(function (e) {
        e.preventDefault();
        var margin = 50;
        if ($(document).scrollTop() <= 180)
        {
            margin += 50;
        }
        var element = $(this).attr("href");
        $("html, body").animate({scrollTop: $(element).offset().top - margin }, 2000);
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

    /*----------------------------
     jQuery MeanMenu
     ------------------------------ */
    jQuery('nav#dropdown').meanmenu();
    //    toggle class
    $(".buy-btn span").on("click", function() {
        $(".header-top-area").toggleClass("btn-none");
    });

    /*----------------------------
     wow js active
     ------------------------------ */
    new WOW().init();
    /*----------------------------
     Countdown active
     ------------------------------ */
    $('[data-countdown]').each(function() {
        finalDate = $(this).data('countdown');
        $(this).timeTo({
            timeTo: new Date(new Date( finalDate)),
            displayDays: 2,
            fontSize: 20,
        });

    });


    $(".slide-auction-closed" ).owlCarousel({
        navigation : true, // Show next and prev buttons
        slideSpeed : 300,
        paginationSpeed : 400,
        singleItem:true,
        /* transitionStyle : "fade", */    /* [This code for animation ] */
        navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
    });


    /*----------------------------
     cart-plus-minus-button
     ------------------------------ */
    $(".cart-plus-minus-box").bind("paste keyup",function () {
        var newVal = $(this).val();

        if( Number(newVal)!==parseInt(newVal)){
            newVal = 1;
            $(this).val(newVal);
        }
        var s_total = newVal * 100;
        $(".cart-total").find(".total").html(s_total  + " <em>F CFA</em>");
        $("#order_total_ttc").val(s_total);
    });
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
        var s_total = newVal * 100;
        $(".cart-total").find(".total").html(s_total +" <em>F CFA</em>");
        $("#order_total_ttc").val(s_total);
        $(".cart-plus-minus-box").trigger('input');
    });

    $(".cart-plus-minus-box").bind("input",function () {
        var link = $(".link_commande").attr("href").substr(0, $(".link_commande").attr("href").indexOf('?'));
        var qte = $(".cart-plus-minus-box").val();
        var total = (qte * 100);
        var new_link = link + "?qte="+qte+"&total="+total;
        $(".link_commande").attr("href",new_link);
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
