<%@ CODEPAGE=65001 %>
<%
Response.CodePage=65001
Response.Charset="UTF-8"
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>管理平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link rel="shortcut icon" type="png" href="../content/img/favicon.png">
    <link href="../content/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>
  <body>
    <div class ="container hero-unit" style="width:400px;padding:80px">
    <form class="form-horizontal" method="post" action="action.asp?act=login">

    <div class="control-group">
      <label class="control-label" for="inputUsername">Username:</label>
      <div class="controls">
        <input type="text" name="username" id="inputUsername" placeholder="Username">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="inputPassword">Password:</label>
      <div class="controls">
        <input type="password" name="password" id="inputPassword" placeholder="Password">
      </div>
    </div>
    <div class="control-group">
      <div class="controls">
        <button type="submit" class="btn btn-primary btn-large">Sign in</button>
      </div>
    </div>
  </form>
</div>
</body>
</html>