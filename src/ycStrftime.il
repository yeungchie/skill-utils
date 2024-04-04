;--------------------------
; Program  : skill-utils(ycStrftime.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycStrftime(\@optional format("%F %T") time(getCurrentTime()) "tg")
    prog((strList specp formatted strOut)
        unless(fixp(time) || stringp(time)
            ycError("argument #2 should be a int number or a string - %A" time)
        )
        foreach(x parseString(format "")
            if(specp
            then
                unless(formatted = _ycStrftimeReadFormat(x time)
                    return()
                )
                strList = cons(formatted strList)
                specp = nil
            else
                if(x == "%"
                    specp = t
                    strList = cons(x strList)
                )
            )
        )
        strOut = buildString(reverse(strList) "")
        return(strOut)
    )
)


procedure(_ycStrftimeReadFormat(type time "tg")
    let((tm trans)
        when(stringp(time)
            time = stringToTime(time)
        )
        tm = timeToTm(time)
        unless(tm == -1
            trans = case(type
                ("S"    tm~>tm_sec                  )
                ("M"    tm~>tm_min                  )
                ("H"    tm~>tm_hour                 )
                ("d"    tm~>tm_mday                 )
                ("m"    tm~>tm_mon+1                )
                ("Y"    tm~>tm_year+1900            )
                ("w"    tm~>tm_wday                 )
                ("j"    tm~>tm_yday                 )
                ("T"    ycStrftime("%H:%M:%S" time) )
                ("F"    ycStrftime("%Y-%m-%d" time) )
                ("%"    "%"                         )
                ("n"    "\n"                        )
                (t
                    ycError("illegal format spec - \"%%%s\"" type)
                )
            )
            caseq(type(trans)
                (fixnum
                    lsprintf("%02d" trans)
                )
                (string
                    trans
                )
                (t
                    lsprintf("%A" trans)
                )
            )
        )
    )
)

; END
