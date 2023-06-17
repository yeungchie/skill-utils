;--------------------------
; Program  : skill-utils(ycTime.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycTime (\@rest body)
    `{
        _ycTime.used = measureTime(
            _ycTime.result = car(errset({nil ,@body} t))
        )
        unless(_ycTime.format && stringp(_ycTime.format)
            _ycTime.format = "%f"
        )
        foreach((fmt time)
            list(
                strcat("UserTime  : " _ycTime.format "\n")
                strcat("SysTime   : " _ycTime.format "\n")
                strcat("WallClock : " _ycTime.format "\n")
            )
            _ycTime.used
            printf(fmt time)
        )
        prog1(
            _ycTime.result
            _ycTime.used   = nil
            _ycTime.result = nil
        )
    }
); ycTime

; END
