<div id="manage-article">
    <form>
        <legend>文章管理</legend>
        <div class="input-append" style="position: fixed; right: 80px; top: 125px;">
            <input class="search" type="text"><button class="btn search" type="button">搜索</button>
        </div>
    </form>
    <div class="manage-article-nav">
        <ul class="breadcrumb">
            <li class="active">列表</li>
            <li class="icon pull-right" style="zoom:1"><a href="#" class="refresh"><i class="icon-refresh" rel="tooltip" title="刷新列表"></i> 刷新</a></li>
            <li class="icon pull-right add" style="zoom:1"><a href="#" class="add"><i class="icon-plus" rel="tooltip" title="添加"></i> 添加</a></li>
            
        </ul>
    </div>
    <table class="table table-striped">
        <colgroup>
            <col width="80">
            <col>
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="150">
            <col width="60">
            <col width="60">
        </colgroup>
        <thead>
            <tr>
                <th class="center">文章 ID</th>
                <th>文章标题</th>
                <th class="center">作者</th>
                <th class="center">文章类别</th>
                <th class="center">图片新闻</th>
                <th class="center">发布时间</th>
                <th class="center">编辑</th>
                <th class="center">删除</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <div class="modal hide" id="article-modal" style="width: 80%; margin: -320px 0 0 -40%;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>文章编辑</h3>
        </div>
        <div class="modal-body" style="max-height: 600px">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="nav_id">标题</label>
                    <div class="controls">
                        <input name="title" id="title" type="text" class="span12 submitValue required">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="nav_id">导航菜单</label>
                    <div class="controls">
                        <select name="nav_id" id="nav_id" class="span12 submitValue required"></select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="menu_id">类别</label>
                    <div class="controls">
                        <select name="menu_id" id="menu_id" class="span12 submitValue required"></select>
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