;--------------------------
; Program  : skill-utils(ycFlattenMemName.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycFlattenMemName(name "t")
    let((suffix flats)
        foreach(pin parseString(name ", ")
            foreach(mem
                if(pcreMatchp("^(.+<[^<>]+>)([^<>]+)" pin)
                then
                    pin = pcreSubstitute("\\1")
                    suffix = pcreSubstitute("\\2")
                    foreach(mapcar x dbProduceMemName(pin)
                        strcat(x suffix)
                    )
                else
                    dbProduceMemName(pin)
                )
                flats = cons(mem flats)
            )
        )
        reverse(flats)
    )
)

; END
