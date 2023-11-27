;--------------------------
; Program  : skill-utils(ycChomp.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycChomp (\@optional str all "gg")
    `prog((string split result)
        string = ,str
        if(string
            unless(stringp(string)
                ycError("argument #1 should be a string - %A" string)
            )
            if(boundp('_) && stringp(_)
                string = _
                return()
            )
        )
        split = reverse(parseString(string "\n" t))
        if(,all
            while(car(split) == ""
                split = cdr(split)
            )
            when(car(split) == ""
                split = cdr(split)
            )
        )
        result = buildString(reverse(split) "\n")
        if(,str
            errset(setq(,str result))
            _ = result
        )
        return(result)
    )
)

; END