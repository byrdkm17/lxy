KM.addMod(function() {
    var self = KM.mod('content.article', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        article: {

            tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td><span title="${title}">${title}</span></td>',
                    '<td class="center">${author}</td>',
                    '<td class="center">${menu_name}</td>',
                    '<td class="center">$${img_url|article_tr_url}</td>',
                    '<td class="center">${create_time}</td>',
                    '<td><div class="action center">',                      
                        '<a href="#" rel="tooltip" title="编辑" class="edit">编辑</a>',
                        '<a href="#" rel="tooltip" title="删除" class="delete">删除</a>',
                    '</div></td>',
                '</tr>'
            ].join('')),

            _reg: (function() {

                juicer.register('article_tr_url', function(data) {
                    if(data) {
                        return '<a href="' + data + '" target="_blank">图片链接</a>';
                    } else {
                        return '<span class="disabled">无</span>';
                    }
                });

            })()

        }

    }

    var fn = {
        loadData: function(url, params, callback, region) {

            url = url || self.path + 'json.asp?action=article';
            url += '&_dc=' + +new Date();
            params = params || {all: 1};
            callback = callback || fn.render
            region = region || window;

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        postData: function(url, params, callback, region) {

            url = url || self.path + 'do.asp?action=article';
            region = region || window;

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
                $tbody.append(tpl.article.tr.render(this));
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
                $.ajax(self.path + 'json.asp?action=article&_dc=' + +new Date(), {
                    data: {content: 1, id: $tr.data('source').id},
                    success: function(content) {
                       fn.showEdit(data, content);
                    }
                });
            }, self, true);

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

            fn.navMenu(data.nav_id, $edit);
            fn.parentMenu(data.nav_id, data.menu_id, $edit);

            if(data.img_url) {
                $edit.find('#set_img').attr('checked', true);
                $edit.find('.c-g-img').show();
                $edit.find('#img_url').val(data.img_url);
            } else {
                $edit.find('#set_img').removeAttr('checked');
                $edit.find('.c-g-img').hide();
                $edit.find('#img_url').val('');
            }            
            self.editor.html(content || '');
            $edit.find('#id').val(data.id || null);

            $('table').hide();
            $edit.show();

        },

        parentMenu: function(nav_id, parent_id, $edit) {
            nav_id = nav_id || 1;
            parent_id = parent_id || 0;
            fn.loadData(self.path + 'json.asp?action=sub', {id: nav_id, type: 4}, function(data) {
                $edit.find('#menu_id').empty();
                $edit.find('#menu_id').append('<option value="0"></option>');
                $.each(data, function() {
                    $edit.find('#menu_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                });
                $edit.find('#menu_id').val(parent_id);
            }, this, true);
        },

        navMenu: function(nav_id, $edit) {
            fn.loadData(self.path + 'json.asp?action=menu', {type: 1}, function(data) {
                $edit.find('#nav_id').empty();
                $.each(data, function() {
                    $edit.find('#nav_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                });
                $edit.find('#nav_id').val(nav_id);
            }, this, true);
        }
    }

    self.init.add(function() {      
        var $ul =  $('.breadcrumb');

        fn.loadData();

        $('.edit').find('#type').change(function() {
            if($(this).val() == 2) {
                $(this).closest('.edit').find('div.c-g-link').show();
            } else {
                $(this).closest('.edit').find('div.c-g-link').hide().find('#link').val('');
            }
        });

        $('.edit').find('#nav_id').change(function() {
            fn.parentMenu($(this).val(), 0, $(this).closest('.edit'));
        });

        $('.edit').find('#set_img').click(function(e) {
            var $edit = $(this).closest('.edit');
            if($(this).attr('checked')) {
                $edit.find('.c-g-img').show();
            } else {
                $edit.find('.c-g-img').hide();
                $edit.find('#img_url').val('');
            }
        });

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
                    if($(this).attr('name') === 'menu_id' && $(this).val() === "0") {
                        $(this).focus();
                        pass = false;
                        return pass;
                    }
                    params[$(this).attr('name')] = $(this).val();
                }
            });

            params.content = self.editor.html();

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
                fn.loadData(false, {title: value, all: 1});
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
            fn.loadData(false, {title: value, all: 1});
        });

        $('input.search').keydown(function(e) {
            if(e.keyCode === 13) {
                $('button.search').click();
            }
        });

    });

    self.init.fireWith(self);
});