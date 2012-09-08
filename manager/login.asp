<%

dim page, title
page = "login"
title = "登录"

%>

<!--#include file="template/header.asp" -->
<div class="container" style="margin-top: 50px">
    <form class="well form-horizontal" method="post" action="do.asp?action=login">
        <fieldset>
            <legend>Login</legend>
            <div class="control-group">
                <label class="control-label" for="username">用户名</label>
                <div class="controls">
                    <input type="text" class="input-xlarge" name="username" tabindex="1" id="username" autofocus value="<% 
                        response.write session("error_username")
                        session.contents.remove("error_username")
                    %>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="passwd">密码</label>
                <div class="controls">
                    <input type="password" class="input-xlarge" name="passwd" tabindex="2" id="passwd">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-primary" id="doLogin">登录</button>
            </div>
        </fieldset>
    </form>
</div>
<!--#include file="template/footer.asp" -->