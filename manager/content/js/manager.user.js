(function($, d, w) {

    var kami = w.kami || {};

    kami.reg = function(name) {
        return kami[name] || {}
    }

    $(d).ready(function() {

        if($('#manage-user').length) {

            (function() {

                var scope = kami.reg('user');

                scope.path = w.location.href.split("/manager/")[0] + '/manager/';

                scope.tpl = {

                    user: {

                        tr: juicer([
                            '<tr>',
                                '<td class="center">${id}</td>',
                                '<td>${username}</td>',
                                '<td class="center">$${state|user_tr_state}</td>',
                                '<td class="center">${lastlog}</td>',
                                '<td class="center">${type}</td>',                                
                                '<td class="center"><a href="#" class="edit">编辑</a></td>',
                                '<td class="center">$${id|menu_tr_delete}</td>',
                            '</tr>'
                        ].join('')),

                        _reg: (function() {

                            juicer.register('user_tr_state', function(data) {
                                return ['<span class="green">正常</span>', '<span class="red">禁用</span>'][data];
                            });

                            juicer.register('menu_tr_delete', function(data) {
                                if(data === 1) {
                                    return '<span class="disabled">删除</span>';
                                } else {
                                    return '<a href="#" class="delete" data-type="sub">删除</a>';
                                }
                            });

                        })()

                    }

                };

                scope.fn = {

                    loadData: function(url, params, callback, region) {

                        url = url || scope.path + 'json/user.asp';
                        url += '?_dc=' + +new Date();
                        params = params || {};
                        callback = callback || scope.fn.render
                        region = region || w;

                        $.getJSON(url, params, function(data) {
                            callback.call(region, data);
                        });

                    },

                    postData: function(url, params, callback, region) {

                        url = url || scope.path + 'do/user.asp';
                        region = region || w;

                        $.post(url, params, function(data) {
                            if(data === 'error 0') {
                                alert('用户名重复');
                            } else {
                                callback.call(region, data);
                            }
                        });
                    },

                    render: function(data) {                       

                        var $tbody = $('tbody');

                        $tbody.empty();

                        $.each(data, function() {
                            $tbody.append(scope.tpl.user.tr.render(this));
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
                            scope.fn.modal(data);
                        });

                    },

                    deleteClick: function() {
                        var $tr = $(this).closest('tr');
                        scope.fn.postData(false, {is_del: 1, id: $tr.data('source').id}, function(data) {
                            $('.breadcrumb').find('a.refresh').click();
                        });
                    },

                    modal: function(data) {
                        data = $.isArray(data) ? (data[0] || {}) : (data || {})

                        var $modal = $('#user-modal');

                        $modal.find('#username').val(data.username || '');
                        $modal.find('#passwd').val('');

                        $modal.find('#type').val(data.type || 0);
                        $modal.find('#state').val(data.state || 0);
                        $modal.find('#id').val(data.id);

                        $modal.modal();
                        $('.modal-backdrop').off('click');

                    }
                };

                scope.init = function() {

                    scope.fn.loadData();

                    $('.modal a.closem').click(function() {
                        $(this).closest('.modal').modal('hide');
                    });

                    $('.modal a.savem').click(function() {
                        var $modal = $(this).closest('.modal'),
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
                        if(pass) {
                            scope.fn.postData(false, params, function() {
                                $modal.modal('hide');
                            }, this);
                        }
                    });

                    $('.modal').on('hidden', function() {
                        $('.breadcrumb').find('a.refresh').click();
                    });

                    $('.breadcrumb').find('a.refresh').click(function(e) {
                        e.preventDefault();
                        scope.fn.loadData();
                    });

                    $('.breadcrumb').find('a.add').click(function(e) {
                        e.preventDefault();
                        var $modal = $('#user-modal');
                        scope.fn.modal();
                    });

                }

                scope.init();
                
            })();

        }

    });

})(jQuery, document, window);