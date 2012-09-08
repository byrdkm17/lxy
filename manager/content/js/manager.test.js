KindEditor.ready(function(K) {
    K.create('#content', {
        cssPath : 'content/kindeditor/plugins/code/prettify.css',
        uploadJson : 'content/kindeditor/asp/upload_json.asp',
        fileManagerJson : 'content/kindeditor/asp/file_manager_json.asp',
        allowFileManager : true
    });
    prettyPrint();
});