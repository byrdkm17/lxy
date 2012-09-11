function Kami() {
    var instance, 
        callbacks = $.Callbacks('once');

    Kami = function Kami() {
        return instance;
    }

    Kami.prototype.start_time = +new Date();

    Kami.prototype.regMethod = function(name, fn, override) {
        override = override || false;
        if(override || instance[name] === undefined) {            
            instance[name] = fn;
        }
    }

    instance = new Kami();

    instance.Mods = {};

    // 添加模块
    instance.regMethod('addMod', function(callback) {
        callbacks.add(callback);
    });

    // 添加命名空间
    instance.regMethod('mod', function(name, create) {
        create = create || false;

        if(instance.Mods[name] === undefined && create) {
            instance.Mods[name] = {
                init: $.Callbacks('once')
            };
        }

        return instance.Mods[name] || create;

    });

    // 初始化
    instance.regMethod('init', function() {
        callbacks.fireWith(instance);
    });

    return instance;
}

/********************************************************************/

var KM = new Kami();

$(document).ready(function() {
    KM.init();

    $('*[rel="tooltip"]').tooltip();
});

KM.addMod(function() {
    var self = KM.mod('header', true);

    var updateMenu = function() {
        var cur = location.search.split('&')[0].split('=');

        if(cur[0] === '?nav') {
            cur = cur[1];
        } else {
            cur = 'home';
        }

        $('.navbar-fixed-top .nav > li').removeClass('active');

        if(cur) {
            $('.navbar-fixed-top .nav > li > a[data-nav="' + cur + '"]').parent().addClass('active');
        }
      
    }

    // 注册初始化方法
    self.init.add(updateMenu);

    self.init.add(function() {
        $.post(location.href.split("/manager/")[0] + '/manager/do.asp?action=asyn');
    });

    self.updateMenu = updateMenu;

    self.init.fireWith(self);
});