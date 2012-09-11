<%
   
function json(rs):

    on error resume next

    dim results, value


    if rs.bof and rs.eof then

        results = "[]"

    else

        results = "["

        rs.movefirst

        do while not rs.eof

            results = results & "{"

            for i = 0 to rs.Fields.Count - 1
                value = typename(rs.fields(i).value)

                select case value:

                    case "Integer":
                        value = rs.fields(i).value
                    case "Long":
                        value = rs.fields(i).value
                    case "Single":
                        value = rs.fields(i).value
                    case "Double":
                        value = rs.fields(i).value
                    case else:
                        value = replace(replace(trim("""" & rs.fields(i).value & """"), "&nbsp;", ""), chr(13), "")
                        if rs.fields(i).name = "content" or rs.fields(i).name = "abstract" or rs.fields(i).name = "pattern" then
                            value = """"""
                        end if
                        
                end select                

                results = results & """" & lcase(rs.fields(i).name) & """:" & value & ","
            Next

            results = left(results, len(results) - 1)

            results = results & "},"

            rs.movenext

        loop

        results = left(results, len(results) - 1)

        results = results & "]"

    end if    

    json = results

    if err then
        response.write "[" & err.number & "] : " & err.description & " (" & err.source & ":" & err.line & ")"
        err.clear
    end if

end function

%>