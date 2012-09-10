KM.addMod(function() {
    var self = KM.mod('login', true);

    $(':input').keydown(function(e) {
        if(e.keyCode === 13) {
            var tab = +$(this).attr('tabindex') + 1,
            $next = $(':input[tabindex="' + tab + '"]');
            
            if($next.length) {
                $next.focus();
            } else {
                $('#doLogin').click();
            }
        }
    });

    $('#doLogin').click(function(e) {
        $('form').submit();
    });

    self.init.fireWith(self);
});