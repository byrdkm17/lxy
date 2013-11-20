<%

on error resume next

Server.ScriptTimeOut = 9999999

function getContent(url)
    
    on error resume next

    set http = Server.CreateObject("Microsoft.XMLHTTP")

    http.open "Get", url, false
    http.send()

    if http.readystate <> 4 then
        exit function
    end if

    getContent = BytesToBstr(http.responseBody)

    set http = nothing

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

function BytesToBstr(body)

    set stream = Server.CreateObject("adodb.stream")

    stream.type = 1
    stream.mode = 3
    stream.open
    stream.write body
    stream.position = 0
    stream.type = 2
    stream.charset = "gb2312"

    BytesToBstr = stream.readText

    stream.close
    set stream = nothing

end function

function save(html, brs)

    on error resume next

    if html <> "" then

        set regEx = new RegExp

        regEx.pattern = brs.fields("pattern")
        regEx.Global = true

        urls = split(brs.fields("url"), "/")

        baseUrl = urls(0) & "//" & urls(2)

        l = UBound(urls)
        i = 3
        fullUrl = baseUrl & "/"
        do while i < l
            fullUrl = fullUrl & urls(i) & "/"
            i = i + 1
        loop

        set Matches = regEx.Execute(html)        

        for each Match in Matches
            title = replace(replace(trim(Match.SubMatches(2)), "&nbsp;", ""), chr(13), "")
            url = Match.SubMatches(1)
            ctime = Match.SubMatches(3)

            if left(url,1) = "/" then
                url = baseUrl & url
            else
                url = fullUrl & url
            end if

            hash = md5(title & url & ctime)

            if brs.fields("type") = "notice" then
                conn.execute("delete from notice where url like 'http:////%'")

                set rs = conn.execute("select * from notice where hash = '" & hash & "'")                

                if rs.bof and rs.eof then
                    conn.execute("insert into notice (title, url, create_time, type, hash) values " & "('" & title & "', '" & url & "', '" & ctime & "', 1, '" & hash & "')")
                end if

            end if

            if brs.fields("type") = "science" then
                conn.execute("delete from science where url like 'http:////%'")

                set rs = conn.execute("select * from science where hash = '" & hash & "'")

                if rs.bof and rs.eof then
                    conn.execute("insert into science (title, url, create_time, hash) values " & "('" & title & "', '" & url & "', '" & ctime & "', '" & hash & "')")
                end if

            end if

        next

        conn.execute("update remote set success_time = '" & now() & "' where id = " & brs.fields("id"))

    end if    

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

function getAll()

    on error resume next

    set rs = conn.execute("select * from remote")

    if rs.bof and rs.eof then

    else

        rs.movefirst

        do while not rs.eof

            utime = rs.fields("update_time")

            if utime  <> "" then
                
            else
                utime = "1986-08-13"
            end if

            if datediff("n", utime, now()) > rs.fields("cycle") and rs.fields("auto") = 1then

                conn.execute("update remote set update_time = '" & now() & "' where id = " & rs.fields("id"))

                html = getContent(rs.fields("url"))

                save html, rs

            end if

            rs.movenext

        loop

    end if

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

function getOne()
    
    id = request("id")

    set rs = conn.execute("select * from remote where id = " & id)

    if rs.bof and rs.eof then

    else

        rs.movefirst

        conn.execute("update remote set update_time = '" & now() & "' where id = " & rs.fields("id"))

        html = getContent(rs.fields("url"))

        save html, rs

    end if

end function

function test()
    on error resume next
    
    url = "http://yx.swfu.edu.cn/kjc/ShowClass.asp?ClassID=3"

    response.write "Step 1 : " & now() & "<br>"

    html = getContent(url)

    response.write "Step 2 : " & now() & "<br>"

    set regEx = new RegExp

    regEx.pattern = "(<a href='(.+?)' title=.{6}(.+)\n.+\n.+(\d{4}-\d{1,2}-\d{1,2}).+\n.+?>.+?<\/a>)"
    regEx.Global = true

    set Matches = regEx.Execute(html)

    response.write "Step 3 : " & now() & "<br>"

    for each Match in Matches

        response.write "Match.SubMatches(0) : <per>" & Match.SubMatches(0) & "</per><br>"
        response.write "Match.SubMatches(1) : <per>" & Match.SubMatches(1) & "</per><br>"
        response.write "Match.SubMatches(2) : <per>" & Match.SubMatches(2) & "</per><br>"
        response.write "Match.SubMatches(3) : <per>" & Match.SubMatches(3) & "</per><br>"

        response.write "<br>==========================================================<br>"

    next

    response.write "Step 4 : " & now() & "<br>"

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

if err then
    response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
    err.clear
end if

%>