$(document).on('ready page:load', function () {
    if ($("#promo").length > 0) {
        k$.growl({
            title: 'GeekHub',
            text: 'Get practical knowledge of IT.',
            delay: 5000
        })
    }
});