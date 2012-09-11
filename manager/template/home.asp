<div class="container ie10Panel" style="margin-top: 50px">
    <form class="well form-horizontal" method="post" action="do.asp?action=login">
        <fieldset>
            <legend>服务器信息</legend>
            <div class="control-group">
                <label class="control-label">HTTP VERSION</label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("Server_Protocol") %>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">SERVICE IP</label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("Server_Name") %>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">SERVER PATH</label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("Path_Translated") %>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">SERVCICE VERSION</label>
                <div class="controls" style="line-height: 28px;">
                    <% response.write Request.ServerVariables("SERVER_SOFTWARE") %>
                </div>
            </div>
        </fieldset>
    </form>
</div>