;--------------------------
; Program  : skill-utils(ycQuiet.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycQuiet (\@rest body)
    unless(_ycQuiet.port && openportp(_ycQuiet.port)
        _ycQuiet.port = outfile("/dev/null")
    )
    `let((poport(poport) woport(woport) errport(errport))
        unless(_ycQuiet.std
            poport = _ycQuiet.port
        )
        unless(_ycQuiet.warn
            woport = _ycQuiet.port
        )
        unless(_ycQuiet.err
            errport = _ycQuiet.port
        )
        car(if(_ycQuiet.errset

        ))
        car(errset({nil ,@body} _ycQuiet.err))
    )
)

; END
