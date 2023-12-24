;--------------------------------
; Program  : skill-utils(ycNumToOct.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNumToOct(num \@optional minWidth(0) "xx")
    prog((remnum remnumList)
        when(zerop(num)
            remnumList = list("0")
        )
        while(num > 0
            remnum = remainder(num 8)
            remnumList = cons(lsprintf("%d" remnum) remnumList)
            num /= 8
        )
        unless(remnumList
            return()
        )
        for(i 1 minWidth-length(remnumList)
            remnumList = cons("0" remnumList)
        )
        return(strcat("0" buildString(remnumList "")))
    )
)

; END