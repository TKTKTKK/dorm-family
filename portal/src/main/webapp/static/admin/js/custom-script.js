/**
 * Created by admin on 15-8-18.
 */
    // Pricing table remove emphasis on hover for Table 1-1 to Table 1-3

$('.pricing-option').mouseenter(function() {
    $(this).closest('.pricing').find('.pricing-option').removeClass('active');
    $(this).addClass('active');
});


// Pricing table remove emphasis on hover for Table 2-1 to Table 2-3

//  $('.plan').mouseenter(function() {
//      $(this).closest('.pricing').find('.plan').removeClass('featured');
//      $(this).addClass('featured');
//  });




// Pricing table remove emphasis on hover for Table 3-1 to Table 3-4

$('.pricing-box').mouseenter(function() {
    $(this).closest('.pricing').find('.pricing-box').removeClass('pricing-active');
    $(this).addClass('pricing-active');
});
