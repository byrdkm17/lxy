KM.addMod(function() {
    var self = KM.mod('site.menu', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        menu: {

            tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td>${name}</td>',
                    '<td class="center">${seq}</td>',
                    '<td class="center">$${type|menu_tr_type}</td>',
                    '<td class="center">$${type|menu_tr_manage}</td>',
                    '<td><div class="action center">',                      
                        '<a href="#" rel="tooltip" title="编辑" class="edit" data-type="{@if is_nav === 1}menu{@else}sub{@/if}">编辑</a>',
                        '$${is_nav|menu_tr_delete}',
                    '</div></td>',
                '</tr>'
            ].join('')),

            _reg: (function() {

                juicer.register('menu_tr_type', function(data) {
                    return ['<span class="">文章列表</span>',
                            '<span class="">菜单列表</span>',
                            '<span class="">外部链接</span>'
                    ][data];
                });

                juicer.register('menu_tr_manage', function(data) {
                    if(data !== 2) {
                        return '<a href="#" class="manage" data-type="${type}">管理</a>';
                    }
                });

                juicer.register('menu_tr_delete', function(data) {
                    if(data !== 1) {
                        return '<a href="#" rel="tooltip" title="删除" data-type="sub" class="delete">删除</a>';
                    }
                });

            })()

        },

        article: {

            tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td>${title}</td>',
                    '<td class="center">${author}</td>',
                    '<td class="center">${menu_name}</td>',
                    '<td class="center">$${img_url|article_tr_url}</td>',
                    '<td class="center">${create_time}</td>',
                    '<td><div class="action center">',                      
                        '<a href="#" rel="tooltip" title="编辑" class="edit" data-type="article">编辑</a>',
                        '<a href="#" rel="tooltip" title="删除" data-type="article" class="delete">删除</a>',
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

        loadData: function(url, params, callback, region, bind) {
            bind = bind || false

            url += '&_dc=' + +new Date();
            region = region || window;

            if(!bind) {
                $('.breadcrumb li.active').data('load', [url, params, callback, region]);
            }

            if(!$.isEmptyObject(params) && !bind) {
                $('.breadcrumb li.add').show();
            } else {
                $('.breadcrumb li.add').hide();
            }

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        postData: function(url, params, callback, region) {
            region = region || window;
            $.post(url, params, function() {
                callback.apply(region, arguments);
            });
        },

        chechSession: function(callback) {
            $.get(self.path + 'json.asp?action=session', {}, function(data) {
                if(data === 'false') {
                    location.href = location.href;
                } else {
                    callback();
                }
            });
        },

        renderMenu: function(data) {

            $('div.edit').hide();
            $('table.article-list').hide();
            $('table.menu-list').show();            

            var $tbody = $('tbody');

            $tbody.empty();

            $.each(data, function() {
                $tbody.append(tpl.menu.tr.render(this));
                $tbody.find('tr:last').data('source', this);
            });
            $tbody.find('a.manage').click(function(e) {
                e.preventDefault();
                fn.manageClick.call(this, e);
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

        renderArticle: function(data) {

            $('div.edit').hide();
            $('table.menu-list').hide();
            $('table.article-list').show();

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

        manageClick: function() {            

            var $ul = $('.breadcrumb'),
                $tr = $(this).closest('tr'),
                url = self.path, 
                params = {},
                callback, 
                name = $tr.data('source').name;

            if($tr.data('source').is_nav) {
                name += ' (导航)';
                params.is_nav = 1;
            }

            $ul.find('li.active')
                .removeClass('active')
                .wrapInner('<a href="#" />')
                .append('<span class="divider">/</span>')
                .after('<li class="active">' + name + '</li>');   

            $ul.find('li.active').prev().find('a').click(function(e) {
                e.preventDefault();
                fn.navClick.call(this, e);
            });

            if($tr.data('source').type === 0) {
                url += 'json.asp?action=article';
                params.id = $tr.data('source').id;
                params.name = $tr.data('source').name;
                callback = fn.renderArticle;
            }

            if($tr.data('source').type === 1) {
                url += 'json.asp?action=sub';
                params.id = $tr.data('source').id;
                if($tr.data('source').is_nav === 1) {
                    params.type = 1;
                } else {
                    params.type = 2;
                }
                params.name = $tr.data('source').name;
                callback = fn.renderMenu;
            }


            fn.loadData(url, params, callback, self);

        },

        editClick: function() {

            var $tr = $(this).closest('tr'),
                type = $(this).data('type'),
                name = ($tr.data('source').name || $tr.data('source').title)  + ' (编辑)';

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

            fn.loadData(self.path + 'json.asp?action=' + type, {edit: 1, id: $tr.data('source').id}, function(data) {
                if(type === 'article') {
                    $.ajax(self.path + 'json.asp?action=article&_dc=' + +new Date(), {
                        data: {content: 1, id: $tr.data('source').id},
                        success: function(content) {
                           fn.showEdit(type, data, content);
                        }
                    });
                } else {
                    fn.showEdit(type, data);
                }
            }, self, true);

        },

        deleteClick: function() {
            var $tr = $(this).closest('tr'),
                type = $(this).data('type');
            fn.postData(self.path + 'do.asp?action=' + type, {is_del: 1, id: $tr.data('source').id}, function(data) {
                $('.breadcrumb').find('a.refresh').click();
            }, self);
        },

        navClick: function() {            

            var $li = $(this).closest('li');
            
            $(this).next().remove();
            $li.nextAll(':not(.pull-right)').remove().end().addClass('active').text($(this).text());

            $('.breadcrumb').find('li.single').hide();
            $('.breadcrumb').find('li.list').show();
            fn.loadData.apply(this, $li.data('load'));

        },

        showEdit: function(type, data, content) {
            data = $.isArray(data) ? (data[0] || {}) : (data || {});

            var $edit;

            if(type === 'menu') {
                $edit = $('.editMenu');

                $edit.find('#name').val(data.name || '');
                $edit.find('#seq').val(data.seq || 0);
                $edit.find('#type').val(data.type || 0);
                $edit.find('#link').val(data.link || '');
                $edit.find('#id').val(data.id || null);

                if(data.type === 2) {
                    $edit.find('div.c-g-link').show();
                } else {
                    $edit.find('div.c-g-link').hide();
                }

                $('table').hide();
                $edit.show();                
            }

            if(type === 'sub') {
                $edit = $('.editSub');

                fn.navMenu(data.nav_id, $edit);

                fn.parentMenu(data.nav_id, data.parent_id, $edit);

                $edit.find('#name').val(data.name || '');
                $edit.find('#parent_id').val(data.parent_id || '');
                $edit.find('#seq').val(data.seq || 0);
                $edit.find('#type').val(data.type || 0);
                $edit.find('#link').val(data.link || '');
                $edit.find('#id').val(data.id || null);

                if(data.type === 2) {
                    $edit.find('div.c-g-link').show();
                } else {
                    $edit.find('div.c-g-link').hide();
                }

                $('table').hide();
                $edit.show();                
            }

            if(type === 'article') {
                $edit = $('.editArticle');

                $edit.find('#title').val(data.title || '');
                $edit.find('#menu_name').val(data.menu_name || '');
                $edit.find('#menu_id').val(data.menu_id || 0);
                if(data.img_url) {
                    $edit.find('#set_img').attr('checked', true);
                } else {
                    $edit.find('#set_img').removeAttr('checked');
                }
                $edit.find('#img_url').val(data.img_url || '');
                self.editor.html(content || '');
                $edit.find('#id').val(data.id || null);

                $('table').hide();
                $edit.show();

            }

        },

        parentMenu: function(nav_id, parent_id, $edit) {
            nav_id = nav_id || 1;
            parent_id = parent_id || 0;
            fn.loadData(self.path + 'json.asp?action=sub', {id: nav_id, type: 5}, function(data) {
                $edit.find('#parent_id').empty();
                $edit.find('#parent_id').append('<option value="0"></option>');
                $.each(data, function() {
                    $edit.find('#parent_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                });
                $edit.find('#parent_id').val(parent_id);
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
        fn.loadData(self.path + 'json.asp?action=menu', {}, fn.renderMenu, self);

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
                type = $edit.attr('id'),
                url, 
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

            if(type === 'article') {
                params.content = self.editor.html();
            }

            if(pass) {
                url = self.path + 'do.asp?action=' + type;

                fn.postData(url, params, function() {
                    $ul.find('.closem').click();
                }, this);
                
            }
        });

        $ul.find('a.refresh').click(function(e) {
            e.preventDefault();            
            fn.loadData.apply(this, $('.breadcrumb').find('li.active').data('load'));
        });

        $('.addm').click(function(e) {
            e.preventDefault();
            fn.chechSession(function() {
                var url = $('.breadcrumb li.active').data('load')[0],
                    type = $('.breadcrumb li.active').data('load')[0].split('?')[1].split('&')[0].split('=')[1],
                    nav_id = $('.breadcrumb li:eq(1)').data('load')[1].id,
                    menu_id = $('.breadcrumb li.active').data('load')[1].is_nav ? 0 : $('.breadcrumb li.active').data('load')[1].id,
                    menu_name = $('.breadcrumb li.active').data('load')[1].is_nav ? '' : $('.breadcrumb li.active').data('load')[1].name,
                    params = {};

                $('.breadcrumb').find('li.active')
                    .removeClass('active')
                    .wrapInner('<a href="#" />')
                    .append('<span class="divider">/</span>')
                    .after('<li class="active">新增</li>');

                $('.breadcrumb').find('li.active').prev().find('a').click(function(e) {
                    e.preventDefault();
                    fn.navClick.call(this, e);
                });

                if(type === 'sub') {
                    var $edit = $('.editSub');
                    params.nav_id = nav_id;
                    params.parent_id = menu_id;
                    $edit.find('div.c-g-link').hide();
                }

                if(type === 'article') {
                    
                        var $edit = $('.editArticle');
                        params.menu_name = menu_name;
                        params.menu_id = menu_id;
                        $edit.find('div.c-g-img').hide();
                    
                }

                $ul.find('li.single').show();
                $ul.find('li.list').hide();
                fn.showEdit(type, params);
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

    });

    self.init.fireWith(self);
});