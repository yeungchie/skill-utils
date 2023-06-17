;--------------------------
; Program  : skill-utils(ycQuiet.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycQuiet (\@key stdprint warnprint errprint \@rest body "gggl")
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
