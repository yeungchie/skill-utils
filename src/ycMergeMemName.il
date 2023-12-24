;--------------------------
; Program  : skill-utils(ycMergeMemName.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycMergeMemName(names "l")
    let((map buss array)
        map = makeTable("" nil)
        names = foreach(mapcar x names
            prog1(
                x = case(type(x)
                    (string x)
                    (symbol symbolToString(x))
                    (t
                        if(pairp(x) && member(car(x) '(bitfield1 bitfield arrayref))
                            lsprintf("%A" x)
                            ycError("member argument should be string or symbol - %A" x)
                        )
                    )
                )
                map[x] = t
            )
        )
        names = ycPrettySort(names)
        buss = removeListDuplicates(
            foreach(mapcar x names car(parseString(x "<")))
        )
        array = foreach(mapcar bus buss
            prog((nets index min max merge net low)
                unless(nets = pcreMatchList(strcat("^" bus "<\\d+>") names)
                    return(bus)
                )
                foreach(x nets
                    when(index = atoi(cadr(parseString(x "<>")))
                        min = min || index
                        max = max || index
                        when(index < min
                            min = index
                        )
                        when(index > min
                            max = index
                        )
                    )
                )
                for(i min max+1
                    net = lsprintf("%s<%d>" bus i)
                    if(map[net]
                    then
                        low = low || i
                    else
                        when(low
                            merge = cons(
                                if(low == i-1
                                    lsprintf("%s<%d>" bus low)
                                    lsprintf("%s<%d:%d>" bus i-1 low)
                                )
                                merge
                            )
                            low = nil
                        )
                    )
                )
                return(merge)
            )
        )
        ycFlattenList(array)
    )
)

; END
