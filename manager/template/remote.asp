<% 
    page = "remote"

    cur = request("mod")
%>

<div class="container">
    <div class="page-header">
        <h1>其他</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li<% if cur = "source" or cur = "" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=source">数据源管理</a></li>
            <li<% if cur = "list" then %> class="active"<% end if %>><a href="manage.asp?nav=remote&mod=list">抓取列表</a></li>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="source"><!--#include file="remote_source.asp" --></div>
            <div class="tab-pane active" id="list"><!--#include file="remote_list.asp" --></div>
        </div>
    </div>
</div>