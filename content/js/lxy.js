(function($, d) {

    $(d).ready(function() {
        var kmenumanageinit = function() {
            var $ul = $('.k-nav-menu .breadcrumb');
                        
            var tpl = {
                menu: {
                    tr: juicer([
                        '<tr>',
                            '<td class="center">${id}</td>',
                            '<td>${menu_name}</td>',
                            '<td class="center"><input type="text" class="input-mini" value="${seq}"></td>',
                            '<td class="center"><input type="checkbox"{@if sub === 1} checked{@/if}></td>',
                            '<td class="center sub">{@if sub === 1}<a class="sub" href="#">管理</a>{@/if}</td>',
                            '<td class="center article">{@if sub === 0}<a class="article" href="#">管理</a>{@/if}</td>',
                            '<td class="center"><a href="#" class="edit">编辑</a></td>',
                            '<td class="center"><a href="#" class="delete">删除</a></td>',
                        '</tr>'
                    ].join(''))
                },

                article: {
                    tr: juicer([
                        '<tr>',
                            '<td class="center">${id}</td>',
                            '<td>${title}</td>',
                            '<td class="center">${author}</td>',
                            '<td class="center">${menu_name}</td>',
                            '<td class="center"><a href="${img_url}" target="_blank">图片链接</a></td>',
                            '<td class="center">${create_time}</td>',
                            '<td class="center"><a href="#" class="edit">编辑</a></td>',
                            '<td class="center"><a href="#" class="delete">删除</a></td>',
                        '</tr>'
                    ].join(''))
                }
            }
            var fn = {

                loadData: function(id, callback, type) {

                    type = type || 'sub';

                    $ul.data('type', type);

                    var url = 'json_' + type + '.asp';

                    $.getJSON(url, { id: id }, function(data) {
                        callback.call(this, data);
                    });
                },

                setKey: function(id, key, value) {
                    $.post('do_nav.asp', {
                        id: id,
                        key: key,
                        value: value
                    });
                },

                renderSub: function(data) {
                    $('.k-article-list').hide();
                    $('.k-menu-list').show();                    

                    var $tbody = $('.k-table').find('tbody');

                    $tbody.empty();

                    $.each(data, function() {
                        $tbody.append(tpl.menu.tr.render(this));
                        $tbody.find('tr:last').data('mate', this);
                    });

                    $tbody.find('input[type="checkbox"]').click(function() {
                        var $tr = $(this).closest('tr'),
                            $td_sub = $tr.find('td.sub'),
                            $td_article = $tr.find('td.article');

                        fn.setKey($tr.data('mate').id, 'sub', $(this).attr('checked') ? 1 : 0);

                        if($(this).attr('checked')) {
                            $td_article.empty();
                            $td_sub.append('<a class="sub" href="#">管理</a>');
                            $td_sub.find('a.sub').click(function(e) {
                                fn.subClick.call(this, e);
                            });
                        } else {
                            $td_sub.empty();
                            $td_article.append('<a class="article" href="#">管理</a>');
                            $td_article.find('a.article').click(function(e) {
                                fn.articleClick.call(this, e);
                            });
                        }

                    });

                    $tbody.find('a.sub').click(function(e) {
                        fn.subClick.call(this, e);
                    });
                    $tbody.find('a.article').click(function(e) {
                        fn.articleClick.call(this, e);
                    });
                    $tbody.find('a.edit').click(function(e) {
                        fn.editClick.call(this, e);
                    });
                    $tbody.find('a.delete').click(function(e) {
                        fn.deleteClick.call(this, e);
                    });

                    $tbody.fadeIn(200);

                },

                renderArticle: function(data) {
                    $('.k-menu-list').hide();
                    $('.k-article-list').show();

                    var $tbody = $('.k-table').find('tbody');

                    $tbody.empty();

                    $.each(data, function() {
                        $tbody.append(tpl.article.tr.render(this));
                        $tbody.find('tr:last').data('mate', this);
                    });

                    $tbody.find('a.edit').click(function(e) {
                        fn.editClick.call(this, e);
                    });
                    $tbody.find('a.delete').click(function(e) {
                        fn.deleteClick.call(this, e);
                    });

                    $tbody.fadeIn(200);

                },

                subClick: function(e) {
                    e.preventDefault();                    

                    $ul.find('li.k-add').show();

                    var $tr = $(this).closest('tr');
                    $ul.data('parent', $tr.data('mate'));

                    fn.loadData($tr.data('mate').id, fn.renderSub);

                    $ul.find('li.active')
                        .attr('data-id', $tr.data('mate').parent_id)
                        .removeClass('active')
                        .wrapInner('<a href="#" />')
                        .append('<span class="divider">/</span>')
                        .after('<li class="active" data-id="' + $tr.data('mate').id + '">' + $tr.data('mate').menu_name + '</li>');

                    if($tr.data('mate').parent_id === 0) {
                        $ul.data('nav_id', $tr.data('mate').id);
                    }

                    $ul.find('li[data-id="' + $tr.data('mate').id + '"]').prev().find('a').click(function(e) {
                        fn.showOther.call(this, e);
                    });
                        
                },

                articleClick: function(e) {
                    e.preventDefault();

                    $ul.find('li.k-add').show();

                    var $tr = $(this).closest('tr');
                    $ul.data('parent', $tr.data('mate'));

                    fn.loadData($tr.data('mate').id, fn.renderArticle, 'article');

                    $ul.find('li.active')
                        .attr('data-id', $tr.data('mate').parent_id)
                        .removeClass('active')
                        .wrapInner('<a href="#" />')
                        .append('<span class="divider">/</span>')
                        .after('<li class="active" data-id="' + $tr.data('mate').id + '">' + $tr.data('mate').menu_name + '</li>');

                    if($tr.data('mate').parent_id === 0) {
                        $ul.data('nav_id', $tr.data('mate').id);
                    }

                    $ul.find('li[data-id="' + $tr.data('mate').id + '"]').prev().find('a').click(function(e) {
                        fn.showOther.call(this, e);
                    });
                        
                },

                editClick: function(e) {
                    e.preventDefault();
  
                    var url = 'json_' + $ul.data('type') + '.asp',
                        $tr = $(this).closest('tr');

                    $ul.data('action', 'edit');

                    $.getJSON(url, { id: $tr.data('mate').id, edit: 1 }, function(data) {
                        fn.showModal($ul.data('type'), data);
                    });
                },

                deleteClick: function(e) {
                    e.preventDefault();

                    var $tr = $(this).closest('tr'),
                        table = $ul.data('type') === 'sub' ? 'menu' : 'article',
                        id = $tr.data('mate').id;

                     $.post('action.asp', {
                            act: 'del',
                            table: table,
                            id: id
                        }, function() {
                            $ul.find('a.refresh').click();
                        });
                },

                showOther: function(e) {

                    e.preventDefault();                        

                    var $li = $(this).closest('li'),
                        id = $li.data('id');

                    if(id === 0) {
                        $ul.find('li.k-add').hide();
                    }
                    
                    $(this).next().remove();
                    $li.nextAll(':not(.pull-right)').remove().end().addClass('active').text($(this).text());

                    fn.loadData(id, fn.renderSub);

                },

                showModal: function(type, data) {
                    data = data && data[0] || {};

                    var $modal = $('#k-modal'),
                        $sub_body = $modal.find('.modal-body.sub'),
                        $article_body = $modal.find('.modal-body.article');

                    if(type === 'sub') {
                        $modal.width(560);
                        $modal.find('.modal-header h3').text('菜单编辑');
                        fn.loadData(0, function(data) {
                            $sub_body.find('select').empty();
                            $sub_body.find('select').append('<option value="0"></option>');
                            $.each(data, function() {
                                $sub_body.find('select').append('<option value="'+ this.id +'">' + this.menu_name+ '</option>');
                            });
                            $sub_body.find('select').val($ul.data('nav_id') || 0);
                        });
                        $sub_body.find('#menu_name').val(data.menu_name || '');
                        $sub_body.find('#parent_name').val($ul.data('parent') && $ul.data('parent').menu_name);
                        $sub_body.find('#parent_id').val($ul.data('parent') && $ul.data('parent').id);
                        $sub_body.find('#seq').val(data.seq || 0);
                        if(data.sub === 1) {
                            $sub_body.find('#sub').attr('checked', true);
                        } else {
                            $sub_body.find('#sub').removeAttr('checked');
                        }
                        $sub_body.find('#id').val(data.id || 0);
                        $article_body.hide();
                        $sub_body.show();
                        $modal.modal();
                        $('.modal-backdrop').off('click');
                    }

                    if(type === 'article') {
                        $modal.width(735);
                        $modal.find('.modal-header h3').text('新闻发布');
                        $article_body.find('#title').val(data.title || '');
                        $article_body.find('#parent_name').val($ul.data('parent') && $ul.data('parent').menu_name);
                        $article_body.find('#parent_id').val($ul.data('parent') && $ul.data('parent').id);
                        $article_body.find('#seq').val(data.seq || 0);
                        if(data.img_url) {
                            $article_body.find('#set_img').attr('checked', true);
                            $article_body.find('#img_url').val(data.img_url);
                            $article_body.find('#img_url_g').show();
                        } else {
                            $article_body.find('#set_img').removeAttr('checked');
                            $article_body.find('#img_url').val('');
                            $article_body.find('#img_url_g').hide();
                        }
                        $article_body.find('#content').val(data.content);
                        $article_body.find('#id').val(data.id || 0);
                        $sub_body.hide();
                        $article_body.show();
                        $modal.modal();
                        $('.modal-backdrop').off('click');
                    }
                }

            }

            $ul.find('a.refresh').click(function(e) {
                e.preventDefault();
                var type = $ul.data('type');
                if(type === 'sub') {
                    fn.loadData($ul.find('li.active').data('id'), fn.renderSub);
                } 
                if(type === 'article') {
                    fn.loadData($ul.find('li.active').data('id'), fn.renderArticle, 'article');
                }
            });

            $ul.find('a.add').click(function(e) {
                e.preventDefault();       
                $ul.data('action', 'add');
                fn.showModal($ul.data('type'));
            });

            $('#k-modal').find('#set_img').click(function(e) {
                if($(this).attr('checked')) {
                    $('#k-modal').find('#img_url_g').show();
                } else {
                    $('#k-modal').find('#img_url_g').hide();
                    $('#k-modal').find('#img_url').val('');
                }
            });

            $('#k-modal').find('a.btn.save').click(function(e) {
                e.preventDefault();
                var $modal = $('#k-modal'),
                    type = $ul.data('type');

                if(type === 'sub') {
                    var nav_id = +$modal.find('.sub #nav_id').val() || 0,
                        menu_name = $modal.find('.sub #menu_name').val() || null,
                        seq = $modal.find('.sub #seq').val() || 0,
                        parent_id = $modal.find('.sub #parent_id').val() || 0,
                        sub = $modal.find('.sub #sub').attr('checked') ? 1 : 0,
                        id = $modal.find('.sub #id').val() || 0;

                    if(menu_name !== null) {
                        $.post('action.asp', {
                            act: $ul.data('action') === 'add' ? 'nav' : 'updatenav',
                            id: id,
                            nav_id: nav_id,
                            menu_name: menu_name,
                            seq: seq,
                            parent_id: parent_id,
                            sub: sub
                        }, function() {
                            $modal.modal('hide');
                        });
                    } else {
                        alert('[菜单名称] 不能为空');
                        $modal.find('.sub #menu_name').focus();
                    }
                }

                if(type === 'article') {
                    var title = $modal.find('.article #title').val() || null,
                        img_url = $modal.find('.article #img_url').val() || null,
                        parent_id = $modal.find('.article #parent_id').val() || 0,
                        content = $modal.find('.article #content').val() || null,
                        id = $modal.find('.article #id').val() || 0;

                    if(title !== null) {
                        $.post('action.asp', {
                            act: $ul.data('action') === 'add' ? 'news' : 'updatenews',
                            id: id,
                            title: title,
                            img_url: img_url,
                            content: content,
                            parent_id: parent_id
                        }, function() {
                            $modal.modal('hide');
                        });
                    } else {
                        alert('[新闻标题] 不能为空');
                        $modal.find('.sub #menu_name').focus();
                    }
                }
            });

            $('#k-modal').find('a.btn.closem').click(function(e) {
                e.preventDefault();
                $('#k-modal').modal('hide');
                
            });

            $('#k-modal').on('hidden', function() {
                $ul.find('a.refresh').click();
            });


            $('.k-menu-manage').find('*[rel="tooltip"]').tooltip();

            fn.loadData(0, fn.renderSub);

        }

        if($('.k-menu-manage').length === 1) {
            kmenumanageinit();
        }
    });

})(jQuery, document);