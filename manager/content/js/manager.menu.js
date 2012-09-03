(function($, d, w, K) {

    var kami = w.kami || {};

    kami.reg = function(name) {
        return kami[name] || {}
    }

    $(d).ready(function() {

        if($('#manage-menu').length) {

            (function() {

                var scope = kami.reg('menu');

                scope.path = w.location.href.split("/manager/")[0] + '/manager/';

                scope.tpl = {

                    menu: {

                        tr: juicer([
                            '<tr>',
                                '<td class="center">${id}</td>',
                                '<td>${name}</td>',
                                '<td class="center"><input type="text" class="input-mini" value="${seq}"></td>',
                                '<td class="center">$${type|menu_tr_type}</td>',
                                '<td class="center">$${type|menu_tr_manage}</td>',
                                '<td class="center"><a href="#" class="edit" data-type="{@if is_nav === 1}nav{@else}sub{@/if}">编辑</a></td>',
                                '<td class="center">$${is_nav|menu_tr_delete}</td>',
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
                                if(data === 2) {
                                    return '<span class="disabled">管理</span>';
                                } else {
                                    return '<a href="#" class="manage" data-type="${type}">管理</a>';
                                }
                            });

                            juicer.register('menu_tr_delete', function(data) {
                                if(data === 1) {
                                    return '<span class="disabled">删除</span>';
                                } else {
                                    return '<a href="#" class="delete" data-type="sub">删除</a>';
                                }
                            });

                        })()

                    },

                    article: {

                        tr: juicer([
                            '<tr>',
                                '<td class="center">${id}</td>',
                                '<td>${title}</td>',
                                '<td class="center">${author}</td>',
                                '<td class="center">${menu_name}</td>',
                                '<td class="center">$${img_url|article_tr_url}</td>',
                                '<td class="center">${create_time}</td>',
                                '<td class="center"><a href="#" class="edit" data-type="article">编辑</a></td>',
                                '<td class="center"><a href="#" class="delete" data-type="article">删除</a></td>',
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

                };


                scope.fn = {

                    loadData: function(url, params, callback, region, bind) {
                        bind = bind || false

                        url += '?_dc=' + +new Date();
                        region = region || w;

                        if(!bind) {
                            $('.breadcrumb li.active').data('load', [url, params, callback, region]);
                        }

                        if(!$.isEmptyObject(params) && !bind) {
                            $('.breadcrumb li.add').show();
                        } else {
                            $('.breadcrumb li.add').hide();
                        }

                        if(url.indexOf('article') > -1) {
                            $('.breadcrumb li.add span.tip').text(' 添加文章');
                        }
                        if(url.indexOf('sub') > -1) {
                            $('.breadcrumb li.add span.tip').text(' 添加菜单');
                        }

                        $.getJSON(url, params, function(data) {
                            callback.call(region, data);
                        });

                    },

                    postData: function(url, params, callback, region) {

                        region = region || w;

                        $.post(url, params, function() {
                            callback.apply(region, arguments);
                        });
                    },

                    renderMenu: function(data) {

                        $('table.menu-list').show();
                        $('table.article-list').hide();
                        

                        var $tbody = $('tbody');

                        $tbody.empty();

                        $.each(data, function() {
                            $tbody.append(scope.tpl.menu.tr.render(this));
                            $tbody.find('tr:last').data('source', this);
                        });

                        $tbody.find('a.manage').click(function(e) {
                            e.preventDefault();
                            scope.fn.manageClick.call(this, e);
                        });
                        $tbody.find('a.edit').click(function(e) {
                            e.preventDefault();
                            scope.fn.editClick.call(this, e);
                        });
                        $tbody.find('a.delete').click(function(e) {
                            e.preventDefault();
                            scope.fn.deleteClick.call(this, e);
                        });

                    },

                    renderArticle: function(data) {

                        $('table.menu-list').hide();
                        $('table.article-list').show();

                        var $tbody = $('tbody');

                        $tbody.empty();

                        $.each(data, function() {
                            $tbody.append(scope.tpl.article.tr.render(this));
                            $tbody.find('tr:last').data('source', this);
                        });

                         $tbody.find('a.edit').click(function(e) {
                            e.preventDefault();
                            scope.fn.editClick.call(this, e);
                        });
                        $tbody.find('a.delete').click(function(e) {
                            e.preventDefault();
                            scope.fn.deleteClick.call(this, e);
                        });

                    },

                    manageClick: function() {

                        var $ul = $('.breadcrumb'),
                            $tr = $(this).closest('tr'),
                            url = scope.path, 
                            params = {},
                            callback, 
                            name = $tr.data('source').name;

                        if($tr.data('source').is_nav) {
                            name += ' (导航)';
                        }

                        $ul.find('li.active')
                            .removeClass('active')
                            .wrapInner('<a href="#" />')
                            .append('<span class="divider">/</span>')
                            .after('<li class="active">' + name + '</li>');   

                        $ul.find('li.active').prev().find('a').click(function(e) {
                            e.preventDefault();
                            scope.fn.navClick.call(this, e);
                        });

                        if($tr.data('source').type === 0) {
                            url += 'json/article.asp';
                            params.id = $tr.data('source').id;
                            params.name = $tr.data('source').name;
                            callback = scope.fn.renderArticle;
                        }

                        if($tr.data('source').type === 1) {
                            url += 'json/sub.asp';
                            params.id = $tr.data('source').id;
                            if($tr.data('source').is_nav === 1) {
                                params.type = 1;
                            } else {
                                params.type = 2;
                            }
                            params.name = $tr.data('source').name;
                            callback = scope.fn.renderMenu;
                        }

                        scope.fn.loadData(url, params, callback, scope);

                    },

                    editClick: function() {

                        var $tr = $(this).closest('tr'),
                            type = $(this).data('type');

                        scope.fn.loadData(scope.path + 'json/' + type + '.asp', {edit: 1, id: $tr.data('source').id}, function(data) {
                            if(type === 'article') {
                                $.ajax(scope.path + 'json/article.asp', {
                                    data: {content: 1, id: $tr.data('source').id},
                                    success: function(content) {
                                        scope.fn.modal(type, data, content);
                                    }
                                });
                            } else {
                                scope.fn.modal(type, data);
                            }
                        }, scope, true);

                    },

                    deleteClick: function() {
                        var $tr = $(this).closest('tr'),
                            type = $(this).data('type');
                        scope.fn.postData(scope.path + 'do/' + type + '.asp', {is_del: 1, id: $tr.data('source').id}, function(data) {
                            $('.breadcrumb').find('a.refresh').click();
                        }, scope);
                    },

                    navClick: function() {

                        var $li = $(this).closest('li');
                        
                        $(this).next().remove();
                        $li.nextAll(':not(.pull-right)').remove().end().addClass('active').text($(this).text());

                        scope.fn.loadData.apply(this, $li.data('load'));

                    },

                    modal: function(type, data, content) {
                        data = $.isArray(data) ? (data[0] || {}) : (data || {})

                        var $modal;

                        if(type === 'nav') {
                            $modal = $('#nav-modal');

                            $modal.find('#name').val(data.name || '');
                            $modal.find('#seq').val(data.seq || 0);
                            $modal.find('#type').val(data.type || 0);
                            $modal.find('#link').val(data.link || '');
                            $modal.find('#id').val(data.id || null);

                            if(data.type === 2) {
                                $modal.find('div.c-g-link').show();
                            } else {
                                $modal.find('div.c-g-link').hide();
                            }

                            $modal.modal();
                            $('.modal-backdrop').off('click');
                        }

                        if(type === 'sub') {
                            $modal = $('#sub-modal');

                            scope.fn.navMenu(data.nav_id, $modal);

                            scope.fn.parentMenu(data.nav_id, data.parent_id, $modal);
     
                            $modal.find('#name').val(data.name || '');
                            $modal.find('#seq').val(data.seq || 0);
                            $modal.find('#type').val(data.type || 0);
                            $modal.find('#link').val(data.link || '');
                            $modal.find('#id').val(data.id || null);

                            if(data.type === 2) {
                                $modal.find('div.c-g-link').show();
                            } else {
                                $modal.find('div.c-g-link').hide();
                            }

                            $modal.modal();
                            $('.modal-backdrop').off('click');
                        }

                        if(type === 'article') {
                            $modal = $('#article-modal');

                            $modal.find('#title').val(data.title || '');
                            $modal.find('#menu_name').val(data.menu_name || '');
                            $modal.find('#menu_id').val(data.menu_id || 0);
                            if(data.img_url) {
                                $modal.find('#set_img').attr('checked', true);
                            } else {
                                $modal.find('#set_img').removeAttr('checked');
                            }
                            $modal.find('#img_url').val(data.img_url || '');
                            scope.editor.html(content || '');
                            $modal.find('#id').val(data.id || null);

                            $modal.modal();
                            $('.modal-backdrop').off('click');
                        }

                    },

                    parentMenu: function(nav_id, parent_id, $modal) {
                        nav_id = nav_id || 1;
                        parent_id = parent_id || 0;
                        scope.fn.loadData(scope.path + 'json/sub.asp', {id: nav_id, type: 3}, function(data) {
                            $modal.find('#parent_id').empty();
                            $modal.find('#parent_id').append('<option value="0"></option>');
                            $.each(data, function() {
                                $modal.find('#parent_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                            });
                            $modal.find('#parent_id').val(parent_id);
                        }, this, true);
                    },

                    navMenu: function(nav_id, $modal) {
                        scope.fn.loadData(scope.path + 'json/nav.asp', {type: 1}, function(data) {
                            $modal.find('#nav_id').empty();
                            $.each(data, function() {
                                $modal.find('#nav_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                            });
                            $modal.find('#nav_id').val(nav_id);
                        }, this, true);
                    }

                };

                scope.init = function() {

                    scope.editor = K.create('#article-modal #content', {
                        cssPath : 'content/kindeditor/plugins/code/prettify.css',
                        uploadJson : 'content/kindeditor/asp/upload_json.asp',
                        fileManagerJson : 'content/kindeditor/asp/file_manager_json.asp',
                        allowFileManager : true
                    });
                    prettyPrint();

                    scope.fn.loadData(scope.path + 'json/nav.asp', {}, scope.fn.renderMenu, scope);

                    $('.modal').find('#type').change(function() {
                        if($(this).val() == 2) {
                            $(this).closest('.modal').find('div.c-g-link').show();
                        } else {
                            $(this).closest('.modal').find('div.c-g-link').hide().find('#link').val('');
                        }
                    });

                    $('.modal').find('#nav_id').change(function() {
                        scope.fn.parentMenu($(this).val(), 0, $(this).closest('.modal'));
                    });

                    $('.modal').find('#set_img').click(function(e) {
                        var $modal = $(this).closest('.modal');
                        if($(this).attr('checked')) {
                            $modal.find('.c-g-img').show();
                        } else {
                            $modal.find('.c-g-img').hide();
                            $modal.find('#img_url').val('');
                        }
                    });

                    // Modal Close
                    $('.modal a.closem').click(function() {
                        $(this).closest('.modal').modal('hide');
                    });

                    // Modal Save
                    $('.modal a.savem').click(function() {
                        var $modal = $(this).closest('.modal'),
                            type = $modal.attr('id').split('-')[0],
                            url, 
                            params = {}, 
                            pass = true;

                        $modal.find('.submitValue').each(function() {
                            if($(this).hasClass('required') && String($(this).val()) === "") {
                                $(this).focus();
                                pass = false;
                                return pass;
                            } else {
                                params[$(this).attr('name')] = $(this).val();
                            }
                        });

                        if(type === 'article') {
                            params.content = scope.editor.html();
                        }

                        if(pass) {
                            url = scope.path + 'do/' + type + '.asp';

                            scope.fn.postData(url, params, function() {
                                $modal.modal('hide');
                            }, this);
                            
                        }
                    });

                    // Modal Hide
                    $('.modal').on('hidden', function() {
                        $('.breadcrumb').find('a.refresh').click();
                    });

                    $('.breadcrumb').find('a.refresh').click(function(e) {
                        e.preventDefault();
                        scope.fn.loadData.apply(this, $('.breadcrumb').find('li.active').data('load'));
                    });

                    $('.breadcrumb').find('a.add').click(function(e) {
                        e.preventDefault();
                        var url = $('.breadcrumb li.active').data('load')[0],
                            type = url.split('/')[url.split('/').length - 1].split('.')[0],
                            nav_id = $('.breadcrumb li:eq(1)').data('load')[1].id,
                            menu_id = $('.breadcrumb li.active').data('load')[1].id,
                            menu_name = $('.breadcrumb li.active').data('load')[1].name,
                            params = {};

                        if(type === 'sub') {
                            var $modal = $('#sub-modal');
                            params.nav_id =  nav_id;
                            params.parent_id = menu_id;
                            $modal.find('div.c-g-link').hide();
                        }

                        if(type === 'article') {
                            var $modal = $('#article-modal');
                            params.menu_name = menu_name;
                            params.menu_id = menu_id;
                            $modal.find('div.c-g-img').hide();
                        }

                        scope.fn.modal(type, params);
                    });

                }

                scope.init();

            })();

        }

    });

})(jQuery, document, window, KindEditor);