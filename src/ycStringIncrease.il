;--------------------------
; Program  : skill-utils(ycStringIncrease.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 对字符串内部固定位置的数字自增，并返回自增后完整的字符串

procedure(ycStringIncrease(str \@optional num(1) "tn")
    let((nump format _num)
        nump = "-?\\d+\\.?\\d*|-?\\.\\d+"
        unless(ycRegEx(str nump nil nil "\\0" t)
            ycError("argument #1 should be a string and have a char for number - %A" str)
        )
        ycRegExCase(str
            (lsprintf("^(.*?)(%s)$" nump)
                ; 数字结尾作为目标
                ; "net1", "net2", "net_3"
                ;     ^       ^        ^
                _num = ycRegExSub(2)
                format = lsprintf("%s%%s"
                    ycRegExSub(1)
                )
            )
            (lsprintf("^(.*?)([<\\[])(%s)([>\\]])$" nump)
                ; 比特位数字作为目标
                ; "net<1>", "net[2]", "net_[3]"
                ;      ^         ^          ^
                _num = ycRegExSub(3)
                format = lsprintf("%s%s%%s%s"
                    ycRegExSub(1)
                    ycRegExSub(2)
                    ycRegExSub(4)
                )
            )
            (lsprintf("^(.*?)(%s)(.*)$" nump)
                ; 非数字结尾以首位数字为目标
                ; "net1a", "net_2_b", "net_3_4_c"
                ;     ^         ^          ^
                _num = ycRegExSub(2)
                format = lsprintf("%s%%s%s"
                    ycRegExSub(1)
                    ycRegExSub(3)
                )
            )
            (t
                ycError("faild to matching - %A" str)
            )
        )
        _num = ycStringNumAdd(_num num)
        lsprintf(format _num)
    )
)

; END
