;--------------------------
; Program  : skill-utils(ycStringIncrease.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 对字符串表示的数字自增

procedure(ycStringIncrease(str \@optional num(1) "tn")
    let((_num)
        unless(pcreMatchp("^-?(\\d+\\.?\\d*|\\.\\d+)$" str)
            ycError("argument #1 should be a string of number - %A" str)
        )
        _num = if(pcreMatchp("\\." str)
            atof(str)
            atoi(str)
        )
        lsprintf("%A" _num+num)
    )
); ycStringIncrease

; END
