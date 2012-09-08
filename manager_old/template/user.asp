<div id="manage-user">
    <form><legend>用户管理</legend></form>
    <div class="manage-user-nav">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i> 刷新</a></li>
            <li class="icon pull-right add"><a href="#" class="add"><i class="icon-plus" rel="tooltip" title="添加"></i> 添加</a></li>
        </ul>
    </div>

    <table class="table table-striped">
        <colgroup class="menu-list">
            <col width="80">
            <col>
            <col width="100">
            <col width="150">
            <col width="100">
            <col width="60">
            <col width="60">
        </colgroup>
        <thead class="menu-list">    
            <tr>
                <th class="center">ID</th>
                <th>用户名</th>
                <th class="center">状态</th>
                <th class="center">上次登录时间</th>
                <th class="center">用户类型</th>                
                <th class="center">编辑</th>
                <th class="center">删除</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <div class="modal hide" id="user-modal">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>用户</h3>
        </div>
        <div class="modal-body">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="username">用户名</label>
                    <div class="controls">
                        <input type="text" name="username" id="username" class="submitValue required">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="passwd">密码</label>
                    <div class="controls">
                        <input type="password" name="passwd" id="passwd" class="submitValue">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="type">用户类型</label>
                    <div class="controls">
                        <input type="text" name="type" id="type" class="submitValue">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="state">状态</label>
                    <div class="controls">
                        <select name="state" id="state" class="submitValue">
                            <option value="0">启用</option>
                            <option value="1">禁用</option>
                        </select>
                    </div>
                </div>
                <input type="hidden" name="id" id="id" class="submitValue">
            </form>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn closem">Close</a>
            <a href="#" class="btn btn-primary savem">保存</a>
        </div>
    </div>
</div>