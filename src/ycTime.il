;--------------------------
; Program  : skill-utils(ycTime.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 快速计算某段代码的耗时

defmacro( ycTime (\@key format("%f") suffix("s") \@rest body)
    `{
        _ycTime.used = measureTime(
            _ycTime.result = car(errset({nil ,@body} t))
        )
        foreach((fmt time)
            list(
                "UserTime "
                "SysTime  "
                "WallClock"
            )
            _ycTime.used
            printf(strcat(fmt " : " ,format ,suffix "\n") time)
        )
        prog1(
            _ycTime.result
            _ycTime.used   = nil
            _ycTime.result = nil
        )
    }
); ycTime

; END
