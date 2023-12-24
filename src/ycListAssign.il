;--------------------------
; Program  : skill-utils(ycListAssign.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 模仿 tcl 函数 `lassign`

procedure(ycListAssign(_ycListAssign_var \@rest _ycListAssign_syms "lg")
    let((_ycListAssign_index)
        _ycListAssign_index = 1
        foreach(x _ycListAssign_syms
            when(x && !symbolp(x)
                _ycListAssign_index++
                ycError("argument #%d should be a symbol - %A" _ycListAssign_index x)
            )
        )
        foreach(_ycListAssign_sym _ycListAssign_syms
            when(_ycListAssign_sym
                set(_ycListAssign_sym car(_ycListAssign_var))
            )
            _ycListAssign_var = cdr(_ycListAssign_var)
        )
        _ycListAssign_var
    )
)

; END