<div class="content-page">
    <div class="nav-menu">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right list"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i></a></li>
            <li class="icon pull-right list"><a href="#" class="addm"><i class="icon-file" rel="tooltip" title="新增"></i></a></li>
            <li class="icon pull-right single" style="display: none; "><a href="#" class="closem"><i class="icon-remove" rel="tooltip" title="关闭"></i></a></li>
        </ul>
    </div>
    <div class="list">
        <div class="table">

            <table class="table">
                <colgroup>
                    <col width="30">
                    <col>
                    <col width="150">
                    <col width="100">
                    <col width="100">
                    <col width="150">
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>用户名</th>
                        <th class="center">最后登录时间</th>                        
                        <th class="center">类型</th>
                        <th class="center">状态</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

        </div>
    </div>

    <div class="edit" style="display: none; ">

        <form class="well form-horizontal">
            <div class="control-group">
                <label class="control-label" for="username">用户名</label>
                <div class="controls">
                    <input type="text" name="username" id="username" class="span10 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="passwd">密码</label>
                <div class="controls">
                    <input type="password" name="passwd" id="passwd" class="span10 submitValue">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="type">类型</label>
                <div class="controls">
                    <input type="text" name="type" id="type" class="span10 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="state">状态</label>
                <div class="controls">
                    <select name="state" id="state" class="span10 submitValue required">
                        <option value="0">正常</option>
                        <option value="1">禁用</option>
                    </select>
                </div>
            </div>            
            <input type="hidden" name="id" id="id" class="submitValue">
            <div class="form-actions">
                <div class="pull-right">
                    <button type="button" class="btn span1 closem">关闭</button>
                    <button type="button" class="btn btn-primary span1 savem">保存</button>
                </div>
            </div>
        </form>       

    </div>

</div>