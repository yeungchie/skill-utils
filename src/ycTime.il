;--------------------------
; Program  : skill-utils(ycTime.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycTime (\@key format("%f") suffix("s") \@rest body "ttgl")
    `{
        _ycTime.used = measureTime(
            _ycTime.result = car(errset({nil ,@body} t))
        )
        foreach((fmt time)
            list(
                strcat("UserTime  : " ,format ,suffix "\n")
                strcat("SysTime   : " ,format ,suffix "\n")
                strcat("WallClock : " ,format ,suffix "\n")
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
