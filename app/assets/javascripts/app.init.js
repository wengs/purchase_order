(function(window, document, $, undefined){

    if (typeof $ === 'undefined') { throw new Error('This application\'s JavaScript require jQuery'); }

    $(function(){

        // Restore body classes
        // ------------------------------
        var $body = $('body');
        new StateToggler().restoreState( $body );

        // enable settings toggle after restore
        $('#chk-fixed').prop('checked', $body.hasClass('layout-fixed') );
        $('#chk-collapsed').prop('checked', $body.hasClass('aside-collapsed') );
        $('#chk-boxed').prop('checked', $body.hasClass('layout-boxed') );
        $('#chk-float').prop('checked', $body.hasClass('aside-float') );
        $('#chk-hover').prop('checked', $body.hasClass('aside-hover') );

        // When ready display the offsidebar
        $('.offsidebar.hide').removeClass('hide');

    });
})(window, document, window.jQuery);