<div class="container ie10Panel" style="margin-top: 50px">
    <form class="well form-horizontal" method="post" action="do.asp?action=login">
        <fieldset>
            <legend>服务器信息</legend>
            <div class="control-group">
                <label class="control-label"><b>协议/版本</b></label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("Server_Protocol") %>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><b>访问地址</b></label>
                <div class="controls" style="line-height: 28px;">
                    <% url = Request.ServerVariables("Server_Name") %>
                    <a href="http://<%=url %>"><%=url %></a>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><b>脚本路径</b></label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("Path_Translated") %>                    
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><b>服务器版本</b></label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("SERVER_SOFTWARE") %>
                </div>
            </div>
        </fieldset>
    </form>
</div>