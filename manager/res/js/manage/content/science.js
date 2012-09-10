KM.addMod(function() {
    var self = KM.mod('content.science', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        science: {

             tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td><span title="${title}">${title}</span></td>',
                    '<td>$${url|science_tr_url}</td>',
                    '<td class="center">${author}</td>',
                    '<td class="center">${create_time}</td>',                                
                    '<td><div class="action center">',                      
                        '<a href="#" rel="tooltip" title="编辑" class="edit">编辑</a>',
                        '<a href="#" rel="tooltip" title="删除" class="delete">删除</a>',
                    '</div></td>',
                '</tr>'
            ].join('')),

            _reg: (function() {

                juicer.register('science_tr_url', function(data) {
                    if(data.indexOf('http') == 0) {
                        return '<a href="' + data + '" target="_blank">' + data + '</a>';
                    } else {
                        return '<a href="http://' + data + '" target="_blank">' + data + '</a>';
                    }
                });

            })()

        }

    }

    var fn = {
        loadData: function(url, params, callback, region) {

            url = url || self.path + 'json.asp?action=science';
            url += '&_dc=' + +new Date();
            params = params || {};
            callback = callback || fn.render
            region = region || window;

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        postData: function(url, params, callback, region) {

            url = url || self.path + 'do.asp?action=science';
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
                $tbody.append(tpl.science.tr.render(this));
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
                name = $tr.data('source').title + ' (编辑)';

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
                $.ajax(self.path + 'json.asp?action=science&_dc=' + +new Date(), {
                    data: {content: 1, id: $tr.data('source').id},
                    success: function(content) {
                        fn.showEdit(data, content);
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

        showEdit: function(data, content) {
            data = $.isArray(data) ? (data[0] || {}) : (data || {});

            var $edit = $('.edit');

            $edit.find('#title').val(data.title || '');
            $edit.find('#url').val(data.url || '');
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
            var value = $('input.search').val();
            if(value) {
                fn.loadData(false, {title: value});
            } else {
                fn.loadData();
            }
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

                var $edit = $('.editArticle');
                $edit.find('div.c-g-img').hide();

                $ul.find('li.single').show();
                $ul.find('li.list').hide();
                fn.showEdit(params);
            });
        });

        KindEditor.ready(function(K) {
            self.editor = K.create('#editor', {
                cssPath : 'res/kindeditor/plugins/code/prettify.css',
                uploadJson : 'res/kindeditor/asp/upload_json.asp',
                fileManagerJson : 'res/kindeditor/asp/file_manager_json.asp',
                allowFileManager : true
            });
            prettyPrint();
        });

        $('button.search').click(function() {
            var value = $('input.search').val();
            fn.loadData(false, {title: value});
        });

        $('input.search').keydown(function(e) {
            if(e.keyCode === 13) {
                $('button.search').click();
            }
        });

    });

    self.init.fireWith(self);
});