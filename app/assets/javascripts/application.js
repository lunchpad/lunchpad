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
// require turbolinks
//= require_tree .

//var datesArr = [];
//
//datesArr.push(new Date ('Mon Aug 27 00:00:00 EDT 2014'));

$(document).on("page:load ready", function(){
    var today = new Date();
    var y = today.getFullYear();
    $('#datepicker').multiDatesPicker({
        beforeShowDay: $.datepicker.noWeekends,
        numberOfMonths: 1,
        defaultDate: today,
        dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
//        addDates: datesArr
    });
});


$(document).on('click', '.menu-icon', function() {
    if($('#dropdown').hasClass('dropdown-nav')){
        $('.dropdown-nav').toggleClass('dropdown-nav-visible');
    }
    else {
        $('.dropdown-nav-visible').toggleClass('dropdown-nav');
    }
});

$(document).ready(function(){
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
