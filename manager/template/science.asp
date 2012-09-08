<div id="manage-science">
    <form><legend>科研动态管理</legend></form>
    <div class="manage-science-nav">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i> 刷新</a></li>
            <li class="icon pull-right add"><a href="#" class="add"><i class="icon-plus" rel="tooltip" title="添加"></i> 添加</a></li>
        </ul>
    </div>

    <table class="table table-striped">
        <colgroup>
            <col width="80">
            <col width="150">
            <col>
            <col width="100">
            <col width="150">
            <col width="60">
            <col width="60">
        </colgroup>
        <thead>    
            <tr>
                <th class="center">ID</th>
                <th>标题</th>
                <th>URL</th>
                <th class="center">作者</th>
                <th class="center">创建时间</th>                
                <th class="center">编辑</th>
                <th class="center">删除</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <div class="modal hide" id="science-modal">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>科研动态</h3>
        </div>
        <div class="modal-body">
            <form class="form-horizontal">

                <div class="control-group">
                    <label class="control-label" for="title">标题</label>
                    <div class="controls">
                        <input type="text" name="title" id="title" class="submitValue required">
                        <span class="help-inline"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="url">URL</label>
                    <div class="controls">
                        <input type="text" name="url" id="url" class="submitValue required">
                        <span class="help-inline"></span>
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