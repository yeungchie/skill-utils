;--------------------------
; Program  : skill-utils(ycNth.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; data = list( 1 2 3 4 5 6 )    => ( 1 2 3 4 5 6 )
; ycNth( 0 data )               => 1
; ycNth( -1 data )              => 6
; ycNth( 0:3 data )             => ( 1 2 3 4 )
; ycNth( list( 0 3 2 ) data )   => ( 1 3 )
; ycNth( "0 3 -1" data )        => ( 1 4 6 )

procedure(ycNth(index dataList "gl")
    let((tips start end step new)
        tips = "argument #1 should be a int or int list or string"
        if(pairp(index)
            unless(forall(x index fixp(x))
                ycError("%s - %A" tips index)
            )
            cond(
                (fixp(index)    t)
                (stringp(index) t)
                (t
                    ycError("%s - %A" tips index)
                )
            )
        )

        if(pairp(index)
        then
            start = nth(0 index)
            end   = nth(1 index) || start
            step  = nth(2 index) || 1
            while(start <= end
                new = append1(new ycNth(start dataList))
                start += step
            )
        else
            cond(
                (fixp(index)
                    new = if(index >= 0
                        nth(index       dataList)
                        nth(-index-1    reverse(dataList))
                    )
                )
                (stringp(index)
                    foreach(x parseString(index)
                        let((num)
                            unless(num = atoi(x)
                                ycError("error index in string - %A" x)
                            )
                            new = append1(new ycNth(num dataList))
                        )
                    )
                )
            )
        )
        new
    )
)

; END