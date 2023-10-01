;--------------------------------
; Program  : skill-utils(ycDecimalToBinary.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycDecimalToBinary(num "x")
    prog((remnum remnumList string)
        when(zerop(num)
            remnumList = list("0")
        )
        while(num > 0
            remnum = remainder(num 2)
            remnumList = cons(artMakeString(remnum) remnumList)
            num /= 2
        )
        string = strcat("0b" buildString(remnumList || return() ""))
        return(string)
    )
)

; END