;--------------------------
; Program  : skill-utils(ycListAssign.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 模仿 tcl 函数 `lassign`

procedure(ycListAssign(var \@rest syms "ls")
    foreach(sym syms
        set(sym car(var))
        var = cdr(var)
    )
    var
)

; END