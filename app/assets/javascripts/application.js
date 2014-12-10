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
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui.multidatespicker
//= require turbolinks
//= require_tree .


$(document).on('click', '.menu-icon', function() {
    if($('#dropdown').hasClass('dropdown-nav')){
        $('.dropdown-nav').toggleClass('dropdown-nav-visible');
    }
    else {
        $('.dropdown-nav-visible').toggleClass('dropdown-nav');
    }
});

$(document).on("page:load ready", function(){
    $(".dropdown-button").click(function() {
        $(".dropdown-menu").toggleClass("show-menu");
        $(".dropdown-menu > li").click(function(){
            $(".dropdown-menu").removeClass("show-menu");
        });
        $(".dropdown-menu.dropdown-select > li").click(function() {
            $(".dropdown-button").html($(this).html());
        });
    });
});

$(document).on("page:load ready", function() {
    $(".payment-drop").hide();
    $("#payment-trigger").click(function() {
        $(".payment-drop").toggle("fast");
    });
});

$(document).on("page:load ready", function(){
    $(".hide-notes").hide();
    $(".order-item-notes").hide();
    $(".note-trigger").click(function() {
        var id = this.id;
        if($('#' + id).hasClass("inactive")) {
            $(this).removeClass("inactive").addClass("active");
            $("." + id + ".show-notes").hide();
            $("." + id + ".hide-notes").show();
        } else {
            $(this).removeClass("active").addClass("inactive");
            $("." + id + ".hide-notes").hide();
            $("." + id + ".show-notes").show();
        }
        $("." + id + ".order-item-notes").toggle("fast");
    });

    $(".close").click(function() {
        $(this).parent().hide();
    });

    var dates = [];

    $(".date-panel-simple").click(function() {
        console.log(this.id);
        if(!$(this).hasClass("selected") && !$(this).hasClass("off-day") && !$(this).hasClass("past")) {
            $(this).addClass("selected");
            dates.push(this.id.replace("date_panel_", ""));
        } else {
            $(this).removeClass("selected");
        }
        $("#datepicker").val(dates);
        console.log(dates);
    });

});


