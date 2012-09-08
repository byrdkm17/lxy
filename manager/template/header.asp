<%
  response.codepage = 65001
  response.charset = "UTF-8"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <%
        if title <> "" then
            response.write "<title>" & title & " | 管理平台</title>"
        else
            response.write "<title>管理平台</title>"
        end if
        %>
        <link rel="shortcut icon" type="png" href="../content/img/favicon.png">
        <link href="res/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="res/kindeditor/themes/default/default.css" rel="stylesheet" />
        <link href="res/kindeditor/plugins/code/prettify.css" rel="stylesheet" />
        <link href="res/css/manage.css" rel="stylesheet">
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="brand" href="#">林学院</a>
                    <div class="nav-collapse">
                        <ul class="nav">
                            <li><a href="manage.asp" data-nav="home">首页</a></li>
                            <li><a href="manage.asp?nav=site" data-nav="site">站点管理</a></li>
                            <li><a href="manage.asp?nav=content" data-nav="content">内容管理</a></li>
                            <li><a href="manage.asp?nav=auth" data-nav="auth">权限管理</a></li>
                        </ul>
                    </div>
                    <div class="nav-collapse pull-right">
                        <ul class="nav">
                        <% if session("username") <> "" then %>
                            <li><a href="#"><%=session("username")%></a></li>
                            <li class="divider-vertical"></li>
                            <li><a href="logout.asp">退出</a></li>
                        <% end if %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>