<div id="manage-notice">
    <form><legend>通知管理</legend></form>
    <div class="manage-notice-nav">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i> 刷新</a></li>
            <li class="icon pull-right add"><a href="#" class="add"><i class="icon-plus" rel="tooltip" title="添加"></i> 添加</a></li>
        </ul>
    </div>

    <table class="table table-striped">
        <colgroup>
            <col width="80">
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
                <th class="center">作者</th>
                <th class="center">发布时间</th>
                <th class="center">编辑</th>
                <th class="center">删除</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <div class="modal hide" id="notice-modal" style="width: 80%; margin: -300px 0 0 -40%;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>通知</h3>
        </div>
        <div class="modal-body" style="max-height: 600px">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="nav_id">标题</label>
                    <div class="controls">
                        <input name="title" id="title" type="text" class="span12 submitValue required">
                    </div>
                </div>
                <textarea name="content" id="content" style="width:100%;height:300px;visibility:hidden;"></textarea>
                <input type="hidden" name="id" id="id" class="submitValue">
            </form>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn closem">Close</a>
            <a href="#" class="btn btn-primary savem">保存</a>
        </div>
    </div>
</div>