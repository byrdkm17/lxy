(function($, d, w, K) {

    var kami = w.kami || {};

    kami.reg = function(name) {
        return kami[name] || {}
    }

    $(d).ready(function() {

        if($('#manage-article').length) {

            (function() {

                var scope = kami.reg('article');

                scope.path = w.location.href.split("/manager/")[0] + '/manager/';

                scope.tpl = {                    

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

                    loadData: function(url, params, callback, region) {

                        url = url || scope.path + 'json/article.asp';
                        url += '?_dc=' + +new Date();
                        params = params || {all: 1};
                        callback = callback || scope.fn.render
                        region = region || w;

                        $.getJSON(url, params, function(data) {
                            callback.call(region, data);
                        });

                    },

                    postData: function(url, params, callback, region) {

                        url = url || scope.path + 'do/article.asp';
                        region = region || w;

                        $.post(url, params, function() {
                            callback.apply(region, arguments);
                        });
                    },

                    render: function(data) {

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

                    editClick: function() {
                        var $tr = $(this).closest('tr');
                        scope.fn.loadData(false, {edit: 1, id: $tr.data('source').id}, function(data) {
                            $.ajax(scope.path + 'json/article.asp', {
                                data: {content: 1, id: $tr.data('source').id},
                                success: function(content) {
                                    scope.fn.modal(data, content);
                                }
                            });
                        }, scope, true);

                    },

                    deleteClick: function() {
                        var $tr = $(this).closest('tr');
                        scope.fn.postData(false, {is_del: 1, id: $tr.data('source').id}, function(data) {
                            $('.breadcrumb').find('a.refresh').click();
                        }, scope);
                    },

                    modal: function(data, content) {
                        data = $.isArray(data) ? (data[0] || {}) : (data || {})

                        var $modal = $('#article-modal');                        

                        $modal.find('#title').val(data.title || '');

                        scope.fn.navMenu(data.nav_id, $modal);
                        scope.fn.parentMenu(data.nav_id, data.menu_id, $modal);

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


                    },

                    parentMenu: function(nav_id, parent_id, $modal) {
                        nav_id = nav_id || 1;
                        parent_id = parent_id || 0;
                        scope.fn.loadData(scope.path + 'json/sub.asp', {id: nav_id, type: 4}, function(data) {
                            $modal.find('#menu_id').empty();
                            $modal.find('#menu_id').append('<option value="0"></option>');
                            $.each(data, function() {
                                $modal.find('#menu_id').append('<option value="'+ this.id +'">' + this.name+ '</option>');
                            });
                            $modal.find('#menu_id').val(parent_id);
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

                    K.ready(function(K) {
                        scope.editor = K.create('#article-modal #content', {
                            cssPath : 'content/kindeditor/plugins/code/prettify.css',
                            uploadJson : 'content/kindeditor/asp/upload_json.asp',
                            fileManagerJson : 'content/kindeditor/asp/file_manager_json.asp',
                            allowFileManager : true
                        });
                        prettyPrint();
                    });

                    scope.fn.loadData();

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
                    $('.modal a.closem').click(function(e) {
                        e.preventDefault();
                        $(this).closest('.modal').modal('hide');
                    });

                    // Modal Save
                    $('.modal a.savem').click(function() {
                        var $modal = $(this).closest('.modal'),
                            params = {}, 
                            pass = true;

                        if($modal.find('#menu_id').val() == '0') {
                            $(this).focus();
                            pass = false;
                        }
                        $modal.find('.submitValue').each(function() {
                            if($(this).hasClass('required') && String($(this).val()) === "") {
                                $(this).focus();
                                pass = false;
                                return pass;
                            } else {
                                params[$(this).attr('name')] = $(this).val();
                            }
                        });

                        params.content = scope.editor.html();

                        if(pass) {
                            scope.fn.postData(false, params, function() {
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
                        var value = $('input.search').val();
                        if(value) {
                            scope.fn.loadData(false, {title: value, all: 1});
                        } else {
                            scope.fn.loadData();
                        }
                    });

                    $('.breadcrumb').find('a.add').click(function(e) {
                        e.preventDefault();
                        var $modal = $('#article-modal');

                        $modal.find('div.c-g-img').hide();

                        scope.fn.modal();
                    });

                    $('button.search').click(function() {
                        var value = $('input.search').val();
                        scope.fn.loadData(false, {title: value, all: 1});
                    });

                }

                scope.init();

            })();

        }

    });

})(jQuery, document, window, KindEditor);