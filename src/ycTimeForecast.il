;--------------------------
; Program  : skill-utils(ycTimeForecast.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycTimeForecast(start total current \@key spec(list("%T" "%F %T")) now(getCurrentTime()) "txxgt")
    prog((used per remain end remainSpec endSpec)
        when(spec
            case(type(spec)
                (string
                    remainSpec = spec
                    endSpec    = spec
                )
                (list
                    remainSpec = car(spec)
                    endSpec    = cadr(spec)
                )
                (t
                    ycError("time spec invalid - %A" spec)
                )
            )
        )
        remainSpec = remainSpec || "%T"
        endSpec    = endSpec    || "%F %T"

        start = stringToTime(start)
        now   = stringToTime(now)
        when((start == -1) || (now == -1)
            return()
        )

        total   *= 1.0
        current *= 1.0

        used   = now - start            ; 已经用时
        per    = if(zerop(current)
            current
            used/current                ; 每步用时
        )
        remain = per * (total-current)  ; 剩余用时
        end    = remain + now           ; 结束时间

        return(list(nil
            'remain ycStrftime(remainSpec round2(remain+57600))
            'end    ycStrftime(endSpec    round2(end))
        ))
    )
)

; END
