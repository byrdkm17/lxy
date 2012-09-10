<% 
    page = "site"
%>

<div class="container">
    <div class="page-header">
        <h1>站点管理</h1>
    </div>
    <div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="#">菜单管理</a></li>
            <li class="pull-right nav-search" style="display: none; "><input type="text" placeholder=""><span rel="tooltip" title="帮助"><i class="icon-question-sign"></i></span></li>
        </ul>     
        <div class="tab-content">
            <div class="tab-pane active" id="menu"><!--#include file="site\menu.asp" --></div>
        </div>
    </div>
</div>