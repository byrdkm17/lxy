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
                    <col width="200">
                    <col width="100">
                    <col width="150">
                    <col width="150">
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>标题</th>
                        <th>URL</th>
                        <th class="center">作者</th>
                        <th class="center">创建时间</th>                
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
                <label class="control-label" for="title">标题</label>
                <div class="controls">
                    <input type="text" name="title" id="title" class="submitValue required span6">
                    <span class="help-inline"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="url">URL</label>
                <div class="controls">
                    <input type="text" name="url" id="url" class="submitValue required span6">
                    <span class="help-inline"></span>
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