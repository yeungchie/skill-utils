;--------------------------
; Program  : skill-utils(ycQuiet.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 安静模式执行某段代码，不会在 CIW 打印任何信息

defmacro( ycQuiet (\@key stdprint warnprint errprint \@rest body)
    unless(_ycQuiet.port && openportp(_ycQuiet.port)
        _ycQuiet.port = outfile("/dev/null")
    )
    `let((poport(poport) woport(woport) errport(errport))
        unless(,stdprint
            poport = _ycQuiet.port
        )
        unless(,warnprint
            woport = _ycQuiet.port
        )
        unless(,errprint
            errport = _ycQuiet.port
        )
        car(errset(prog2(nil {,@body} ,warnprint && t || getWarn()) ,errprint))
    )
)

; END
