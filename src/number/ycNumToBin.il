;--------------------------------
; Program  : skill-utils(ycNumToBin.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNumToBin(num \@optional minWidth(0) "xx")
    prog((remnum remnumList)
        when(zerop(num)
            remnumList = list("0")
        )
        while(num > 0
            remnum = remainder(num 2)
            remnumList = cons(lsprintf("%d" remnum) remnumList)
            num /= 2
        )
        unless(remnumList
            return()
        )
        for(i 1 minWidth-length(remnumList)
            remnumList = cons("0" remnumList)
        )
        return(strcat("0b" buildString(remnumList "")))
    )
)

; END