;--------------------------------
; Program  : skill-utils(ycNumToHex.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNumToHex(num \@optional minWidth(0) "xx")
    prog((remnum remnumList)
        when(zerop(num)
            remnumList = list("0")
        )
        while(num > 0
            remnum = remainder(num 16)
            remnumList = cons(lsprintf("%d" remnum) remnumList)
            num /= 16
        )
        unless(remnumList
            return()
        )
        for(i 1 minWidth-length(remnumList)
            remnumList = cons("0" remnumList)
        )
        remnumList = foreach(mapcar x remnumList
            case(x
                ("10"  "A")
                ("11"  "B")
                ("12"  "C")
                ("13"  "D")
                ("14"  "E")
                ("15"  "F")
                (t      x )
            )
        )
        return(strcat("0x" buildString(remnumList "")))
    )
)

; END