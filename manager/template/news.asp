<div id="manage-news">
    <form><legend>学院要闻管理</legend></form>
    <div class="manage-news-nav">
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
                <th class="center">图片新闻</th>
                <th class="center">创建时间</th>                
                <th class="center">编辑</th>
                <th class="center">删除</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <div class="modal hide" id="news-modal" style="width: 80%; margin: -300px 0 0 -40%;">
        <div class="modal-header">
            <button type="button" class="close closem" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>学院要闻</h3>
        </div>
        <div class="modal-body" style="max-height: 600px">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="title">标题</label>
                    <div class="controls">
                        <input type="text" name="title" id="title" class="span12 submitValue required">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="set_img">设置为图片新闻</label>
                    <div class="controls">
                        <input id="set_img" name="set_img" type="checkbox"> 
                    </div>
                </div>
                <div class="control-group c-g-img" style="display: none; ">
                    <label class="control-label" for="img_url">图片新闻链接</label>
                    <div class="controls">
                        <input type="text" name="img_url" id="img_url" class="span12 submitValue">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="abstract">新闻概要</label>
                    <div class="controls">
                        <textarea name="abstract" id="abstract" class="span12 submitValue"></textarea>
                    </div>
                </div>
                <textarea name="content" id="content" style="width:100%;height:200px;visibility:hidden;"></textarea>
                <input type="hidden" name="id" id="id" class="submitValue">
            </form>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn closem">Close</a>
            <a href="#" class="btn btn-primary savem">保存</a>
        </div>
    </div>
</div>