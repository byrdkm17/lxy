KM.addMod(function() {
    var self = KM.mod('auth.user', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        user: {

             tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td>${username}</td>',
                    '<td class="center">${lastlog}</td>',
                    '<td class="center">${type}</td>',
                    '<td class="center">$${state|user_tr_state}</td>', 
                    '<td><div class="action center">',                      
                        '<a href="#" rel="tooltip" title="编辑" class="edit">编辑</a>',
                        '<a href="#" rel="tooltip" title="删除" class="delete">删除</a>',
                    '</div></td>',
                '</tr>'
            ].join('')),

            _reg: (function() {

                juicer.register('user_tr_state', function(data) {
                    return ['<span class="green">正常</span>', '<span class="red">禁用</span>'][data];
                });

            })()

        }

    }

    var fn = {
        loadData: function(url, params, callback, region) {

            url = url || self.path + 'json.asp?action=user';
            url += '&_dc=' + +new Date();
            params = params || {};
            callback = callback || fn.render
            region = region || window;

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        postData: function(url, params, callback, region) {

            url = url || self.path + 'do.asp?action=user';
            region = region || w;

            $.post(url, params, function() {
                callback.apply(region, arguments);
            });
        },

        chechSession: function(callback) {
            $.get(self.path + 'json.asp?action=session&_dc=' + +new Date(), {}, function(data) {
                if(data === 'false') {
                    location.href = location.href;
                } else {
                    callback();
                }
            });
        },

        render: function(data) {

            $('div.edit').hide();
            $('table').show();

            var $tbody = $('tbody');

            $tbody.empty();

            $.each(data, function() {
                $tbody.append(tpl.user.tr.render(this));
                $tbody.find('tr:last').data('source', this);
            });

            $tbody.find('a.edit').click(function(e) {
                e.preventDefault();
                fn.editClick.call(this, e);
            });
            $tbody.find('a.delete').click(function(e) {
                e.preventDefault();
                fn.deleteClick.call(this, e);
            });


        },

        editClick: function() {

            var $tr = $(this).closest('tr');

            

            var $tr = $(this).closest('tr'),
                name = $tr.data('source').username + ' (编辑)';

            $('.breadcrumb').find('li.active')
                .removeClass('active')
                .wrapInner('<a href="#" />')
                .append('<span class="divider">/</span>')
                .after('<li class="active">' + name + '</li>');

            $('.breadcrumb').find('li.active').prev().find('a').click(function(e) {
                e.preventDefault();
                fn.navClick.call(this, e);
            });

            $('.breadcrumb').find('li.list').hide();
            $('.breadcrumb').find('li.single').show();

            fn.loadData(false, {edit: 1, id: $tr.data('source').id}, function(data) {
                fn.showEdit(data);
            });

        },

        deleteClick: function() {
            var $tr = $(this).closest('tr');
            fn.postData(false, {is_del: 1, id: $tr.data('source').id}, function(data) {
                $('.breadcrumb').find('a.refresh').click();
            }, self);
        },

        navClick: function() {            

            var $li = $(this).closest('li');
            
            $(this).next().remove();
            $li.nextAll(':not(.pull-right)').remove().end().addClass('active').text($(this).text());

            $('.breadcrumb').find('li.single').hide();
            $('.breadcrumb').find('li.list').show();
            fn.loadData();

        },

        showEdit: function(data) {
            data = $.isArray(data) ? (data[0] || {}) : (data || {});

            var $edit = $('.edit');

            $edit.find('#username').val(data.username || '');
            $edit.find('#type').val(data.type || 0);
            $edit.find('#state').val(data.state || 0);
            $edit.find('#id').val(data.id || null);

            $('table').hide();
            $edit.show();

        }
    }

    self.init.add(function() {      
        var $ul =  $('.breadcrumb');

        fn.loadData();

        $('.closem').click(function(e) {
            e.preventDefault();
            $ul.find('li.single').hide();
            $ul.find('li.list').show();
            $ul.find('li.active').prev().find('a').click();                        
        });

        $('.savem').click(function() {
            var $edit = $(this).closest('.edit'),
                params = {}, 
                pass = true;

            $edit.find('.submitValue').each(function() {
                if($(this).hasClass('required') && String($(this).val()) === "") {
                    $(this).focus();
                    pass = false;
                    return pass;
                } else {
                    params[$(this).attr('name')] = $(this).val();
                }
            });

            if(pass) {
                fn.postData(false, params, function() {
                    $ul.find('.closem').click();
                }, this);
                
            }
        });

        $ul.find('a.refresh').click(function(e) {
            e.preventDefault();            
            fn.loadData();
        });

        $('.addm').click(function(e) {
            e.preventDefault();
            fn.chechSession(function() {
                var params = {};

                $('.breadcrumb').find('li.active')
                    .removeClass('active')
                    .wrapInner('<a href="#" />')
                    .append('<span class="divider">/</span>')
                    .after('<li class="active">新增</li>');

                $('.breadcrumb').find('li.active').prev().find('a').click(function(e) {
                    e.preventDefault();
                    fn.navClick.call(this, e);
                });

                $ul.find('li.single').show();
                $ul.find('li.list').hide();
                fn.showEdit(params);
            });
        });

    });

    self.init.fireWith(self);
});