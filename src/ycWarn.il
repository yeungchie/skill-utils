;--------------------------
; Program  : skill-utils(ycWarn.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 自动显示函数名的 warn

procedure(ycWarn(format \@key functionName \@rest vars "tgl")
    unless(functionName
        functionName = getCallingFunction(1)
    )
    unless(stringp(functionName)
        functionName = lsprintf("%A" functionName)
    )
    warn("%s: %s" functionName apply('lsprintf format vars))
)

; END