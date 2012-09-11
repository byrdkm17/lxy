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
                    <col width="100">
                    <col width="100">
                    <col width="100">
                    <col width="150">
                    <col width="150">
                </colgroup>
                <thead>
                    <tr>
                        <th></th>
                        <th>抓取地址</th>
                        <th class="center">分类</th>
                        <th class="center">自动抓取</th>
                        <th class="center">抓取间隔 (分)</th>
                        <th class="center">最后一次抓取时间</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

        </div>
    </div>

    <div class="editSource edit" style="display: none; " id="source">

        <form class="well form-horizontal">
           <div class="control-group">
                <label class="control-label" for="url">抓取地址</label>
                <div class="controls">
                    <input type="text" name="url" id="url" class="span10 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="type">分类</label>
                <div class="controls">
                    <select name="type" id="type" class="span10 submitValue required">
                        <option value="notice">西林公告</option>
                        <option value="science">科研动态</option>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="auto">最小抓取间隔 (分)</label>
                <div class="controls">
                    <select name="auto" id="auto" class="span10 submitValue required">
                        <option value="0">关闭</option>
                        <option value="1">开启</option>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="cycle">最小抓取间隔 (分)</label>
                <div class="controls">
                    <input type="text" name="cycle" id="cycle" class="span10 submitValue required">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="pattern">表达式</label>
                <div class="controls">
                    <textarea class="code span10 submitValue" name="pattern" id="pattern"></textarea> 
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