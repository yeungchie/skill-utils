;--------------------------
; Program  : skill-utils(ycError.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 自动显示函数名的 error

procedure(ycError(format \@key functionName \@rest vars "tgl")
    unless(functionName
        functionName = getCallingFunction(1)
    )
    unless(stringp(functionName)
        functionName = lsprintf("%A" functionName)
    )
    error("%s: %s" functionName apply('lsprintf format vars))
)

; END