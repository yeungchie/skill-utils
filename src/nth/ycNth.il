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
    let((tips new)
        tips = "argument #1 should be a int or int list or string"
        cond(
            (fixp(index)
                nth(ycNthRealIndex(index dataList) dataList)
            )
            (pairp(index)
                unless(forall(x index fixp(x))
                    ycError("%s - %A" tips index)
                )
                let((start end step)
                    start = ycNthRealIndex(nth(0 index) dataList)
                    end   = ycNthRealIndex((nth(1 index) || start) dataList)
                    step  = nth(2 index) || 1
                    while(start <= end
                        new = cons(ycNth(start dataList) new)
                        start += step
                    )
                )
                reverse(new)
            )
            (stringp(index)
                foreach(x parseString(index)
                    let((num)
                        unless(num = atoi(x)
                            ycError("error index in string - %A" x)
                        )
                        new = cons(ycNth(ycNthRealIndex(num dataList) dataList) new)
                    )
                )
                reverse(new)
            )
            (t
                ycError("%s - %A" tips index)
            )
        )
    )
)

; END