;--------------------------
; Program  : skill-utils(ycPrettyStringArray.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPrettyStringArray(array \@optional join(" ") "lt")
    let((i j strlenArray max widths)
        unless(array
            ycError("argument #1 is nil" array)
        )

        i = 0
        j = 0
        strlenArray = foreach(mapcar row array
            unless(pairp(row)
                ycError("argument #1[%d] should be a valid list - %A" i row)
            )
            prog1(
                foreach(mapcar x row
                    unless(stringp(x)
                        ycError("argument #1[%d][%d] should be a string - %A" i j x)
                    )
                    j++
                    strlen(x)
                )
                i++
                j = 0
            )
        )

        max = lambda((args) let((maxNum)
            foreach(x args
                when(!maxNum || (maxNum < x)
                    maxNum = x
                )
            )
            maxNum
        ))
        for(i 0 funcall(max mapcar('length strlenArray))-1
            widths = cons(
                funcall(max foreach(mapcar x strlenArray nth(i x) || 0))
                widths
            )
        )
        widths = reverse(widths)

        foreach(mapcar row array
            let((strings)
                if(onep(length(row))
                then
                    car(row)
                else
                    row = reverse(row)
                    strings = foreach(mapcar (width str) widths reverse(cdr(row))
                        sprintf(nil sprintf(nil "%%-%ds" width) str)
                    )
                    strcat(buildString(strings join) join car(row))
                )
            )
        )
    )
)

; END