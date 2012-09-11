KM.addMod(function() {
    var self = KM.mod('remote.list', true);

    self.path = location.href.split("/manager/")[0] + '/manager/';

    var tpl = {

        list: {

             tr: juicer([
                '<tr>',
                    '<td></td>',
                    '<td><a href="${url}" title="${url}" target="_blank">${title}</a></td>',
                    '<td class="center">${type|list_tr_type}</td>',
                    '<td class="center">${create_time}</td>',
                '</tr>'
            ].join('')),

            _reg: (function() {

                juicer.register('list_tr_type', function(data) {
                    return {notice: '西林公告', 'science': '科研动态'}[data];
                });

            })()

        }

    }

    var fn = {
        loadData: function(url, params, callback, region) {

            url = url || self.path + 'json.asp?action=list';
            url += '&_dc=' + +new Date();
            params = params || {type: 'science'};
            callback = callback || fn.render
            region = region || window;

            $.getJSON(url, params, function(data) {
                callback.call(region, data);
            });

        },

        render: function(data) {

            var $tbody = $('tbody');

            $tbody.empty();

            $.each(data, function() {
                $tbody.append(tpl.list.tr.render(this));
                $tbody.find('tr:last').data('source', this);
            });

        }

    }

    self.init.add(function() {

        fn.loadData();

        $('.breadcrumb').find('a.refresh').click(function(e) {
            e.preventDefault();
            fn.loadData();
        });

    });

    self.init.fireWith(self);
});