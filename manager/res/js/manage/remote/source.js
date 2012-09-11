KM.addMod(function() {
    var self = KM.mod('remote.source', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        source: {

             tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td><a href="${url}" title="${url}">${url}</a></td>',
                    '<td class="center">${type|source_tr_type}</td>',
                    '<td class="center">$${auto|source_tr_auto}</td>',
                    '<td class="center">${cycle}</td>',
                    '<td class="center update_time">${update_time}</td>',                               
                    '<td><div class="action center">',
                        '<a href="#" rel="tooltip" title="抓取" class="get">抓取</a>',
                        '<a href="#" rel="tooltip" title="编辑" class="edit">编辑</a>',
                        '<a href="#" rel="tooltip" title="删除" class="delete">删除</a>',
                    '</div></td>',
                '</tr>'
            ].join('')),

             _reg: (function() {

                juicer.register('source_tr_type', function(data) {
                    return {notice: '西林公告', 'science': '科研动态'}[data];
                });

                juicer.register('source_tr_auto', function(data) {
                    return ['<span class="red">关闭</span>', '<span class="green">开启</span>'][data];
                });

            })()

        }

    }

    var fn = {
        loadData: function(url, params, callback, region) {

            url = url || self.path + 'json.asp?action=source';
            url += '&_dc=' + +new Date();
            params = params || {};
            callback = callback || fn.render
            region = region || window;

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        postData: function(url, params, callback, region) {

            url = url || self.path + 'do.asp?action=source';
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
                $tbody.append(tpl.source.tr.render(this));
                $tbody.find('tr:last').data('source', this);
            });

            $tbody.find('a.get').click(function(e) {
                e.preventDefault();
                fn.getClick.call(this, e);
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

        getClick: function() {
            var $tr = $(this).closest('tr');

            $tr.find('.update_time').text('正在抓取 ...');
            $.post(self.path + 'do.asp?action=get', {id: $tr.data('source').id}, function() {
                $('.breadcrumb').find('a.refresh').click();
            });
        },

        editClick: function() {      

            var $tr = $(this).closest('tr'),
                name = $tr.data('source').url + ' (编辑)';

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
                $.ajax(self.path + 'json.asp?action=source&_dc=' + +new Date(), {
                    data: {pattern: 1, id: $tr.data('source').id},
                    success: function(pattern) {
                        fn.showEdit(data, pattern);
                    }
                });
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

        showEdit: function(data, pattern) {
            data = $.isArray(data) ? (data[0] || {}) : (data || {});

            var $edit = $('.edit');

            $edit.find('#url').val(data.url || '');                      
            $edit.find('#type').val(data.type || 'notice');
            $edit.find('#auto').val(data.auto || 0);
            $edit.find('#cycle').val(data.cycle || 86400);
            $edit.find('#pattern').val(pattern || '');
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