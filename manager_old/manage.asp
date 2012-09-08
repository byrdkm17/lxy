<%  

  response.codepage=65001
  response.charset="UTF-8"

  if session("username") = "" then
    Response.redirect("login.asp")
  end if

%>
<!--#include file="conn.asp" -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>管理平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" type="png" href="../content/img/favicon.png">
    <!-- Le styles -->
    <link href="../content/css/bootstrap.min.css" rel="stylesheet">

    

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../content/js/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="stylesheet" href="content/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="content/kindeditor/plugins/code/prettify.css" />
    <link href="content/css/manager.css" rel="stylesheet">
    
    <script src="../content/js/jquery.min.js"></script>
    <script charset="utf-8" src="content/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="content/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="content/kindeditor/plugins/code/prettify.js"></script>
  </head>

  <body>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">林学院网站管理平台</a>
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
              Logged in as <a href="#" class="navbar-link"><%=session("username")%></a>
            </p>
            <ul class="nav">
              <li class="active"><a href="manage.asp">Home</a></li>
              <li><a href="#about">About</a></li>
              <li><a href="#contact">Contact</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">消息发布</li>
              <li class=""><a href="manage.asp?act=notice">通知发布</a></li>
              <li><a href="manage.asp?act=science">科研动态管理</a></li>
              <li><a href="manage.asp?act=news">学院要闻管理</a></li>
              <li><a href="manage.asp?act=article">文章管理</a></li>
              <li class="nav-header">站点管理</li>
              <li><a href="manage.asp?act=nav">菜单管理</a></li>
              <li class="nav-header">权限管理</li>
              <li><a href="manage.asp?act=user">用户管理</a></li>
            </ul>
          </div>
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">About</li>
              <li class="nav-header-cur">建议通过 FireFox, Chrome 访问本页面, 以获得更好的体验.</li>
              <li class="nav-header-cur">Author : byrdkm17@gmail.com</li>
            </ul>
          </div>
        </div>
        <div class="span9">
          <div class="hero-unit">           
             <%
              dim action, viewer
              action = request("act")
              select case action:
                case "notice": %> <!--#include file="template/notice.asp" -->
              <% case "science": %> <!--#include file="template/science.asp" -->
              <% case "nav": %> <!--#include file="template/nav.asp" -->
              <% case "user": %> <!--#include file="template/user.asp" -->
              <% case "news": %> <!--#include file="template/news.asp" -->
              <% case "article": %> <!--#include file="template/article.asp" -->
              <% case else: %> <!--#include file="template/system.asp" -->
              <% end select %>
        </div><!--/span-->
      </div><!--/row-->

      <hr>



    </div><!--/.fluid-container-->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../content/js/bootstrap.min.js"></script>
    <script charset="utf-8" src="content/js/juicer.js"></script>
    <% select case action:
      case "science":
    %>
    <script charset="utf-8" src="content/js/manager.science.js"></script>
    <%
      case "nav":
    %>
    <script charset="utf-8" src="content/js/manager.menu.js"></script>
    <%
      case "news":
    %>
    <script charset="utf-8" src="content/js/manager.news.js"></script>
    <%
      case "user":
    %>
    <script charset="utf-8" src="content/js/manager.user.js"></script>
    <%
      case "notice":
    %>
    <script charset="utf-8" src="content/js/manager.notice.js"></script>
    <%
      case "article":
    %>
    <script charset="utf-8" src="content/js/manager.article.js"></script>
    <%
      end select
    %>
  </body>
</html>