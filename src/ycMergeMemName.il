;--------------------------
; Program  : skill-utils(ycMergeMemName.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycMergeMemName(names "l")
    let((init netproc busproc mems state)
        ; 状态机初始化
        init = lambda((\@key name count(0) busp start stop trend(0) "gxgggx")
            state || (state = makeTable("" nil))
            state~>name = name           ; nil | str   = nil  # r"(?P<name>\w+)(<\d+>)?"
            state~>count = count         ; int[>=0]    = 0    # 非 bus 信号 name 计数
            state~>busp = busp           ; nil | t     = nil  # 前一个信号是否为 bus 信号
            state~>start = start         ; nil | int   = nil  # bus 信号起始位
            state~>stop = stop || start  ; nil | int   = nil  # bus 信号结束位
            state~>trend = trend         ; int[-1,0,1] = 0    # bus 信号 bit 位进位趋势
        ); init

        ; 普通信号处理
        ; if st.count == 0:  # 普通信号初始化
        ;     init( -name=name, -count=1 )
        ; ef st.busp:
        ;     if st.stop:
        ;         push( st.name<st.start:st.stop> )
        ;     ef st.count == 1:
        ;         push( st.name<st.start> )
        ;     el:
        ;         push( <*st.count>st.name<st.start> )
        ;     init( -name=name, -count=1 )
        ; ef st.name == name:  # 重复的普通信号
        ;     st.count++  # 计数增加
        ; el:  # 新的普通信号
        ;     if st.count == 1:
        ;         push( st.name )
        ;     el:
        ;         push( <*st.count>st.name )
        ;     init( -name=name, -count=1 )
        netproc = lambda((name "g")
            cond(
                (name && (state~>count == 0)
                    funcall(init ?name name ?count 1)
                )
                (state~>busp
                    mems = tconc(mems
                        cond(
                            (state~>stop
                                lsprintf("%s<%d:%d>" state~>name state~>start state~>stop)
                            )
                            (state~>count == 1
                                lsprintf("%s<%d>" state~>name state~>start)
                            )
                            (t
                                lsprintf("<*%d>%s<%d>" state~>count state~>name state~>start)
                            )
                        )
                    )
                    funcall(init ?name name ?count 1)
                )
                (state~>name == name
                    state~>count += 1
                )
                (t
                    mems = tconc(mems
                        if(state~>count == 1
                            state~>name
                            lsprintf("<*%d>%s" state~>count state~>name)
                        )
                    )
                    funcall(init ?name name ?count 1)
                )
            )
        ); netproc

        ; bus 信号处理
        ; if st.count == 0:  # 总线信号初始化
        ;     init( -name=name, -count=1, -busp=true, -start=bit )
        ; ef st.busp:
        ;     if st.name == name:
        ;         if st.count == 1:
        ;             if st.start == bit:
        ;                 st.count++
        ;             ef abs(bit - st.start) == 1:
        ;                 st.count++
        ;                 st.stop = bit
        ;                 st.trend = bit - st.start
        ;             el:  # bus 同名但 bit 跨度大于 1
        ;                 push( st.name<st.start> )
        ;                 init( -name=name, -count=1, -busp=true, -start=bit )
        ;         ef st.trend == (bit - st.stop):  # bit 连续的 bus 信号
        ;             st.count++
        ;             st.stop = bit
        ;         el:  # bus 信号跨度不连续
        ;             if st.start == st.stop:  # 同一 bit 多次连接
        ;                 push( <*st.count>st.name<st.start> )
        ;             el:
        ;                 push( st.name<st.start:st.stop> )
        ;             init( -name=name, -count=1, -busp=true, -start=bit )
        ;     el:
        ;         if st.stop:
        ;             push( st.name<st.start:st.stop> )
        ;         ef st.count == 1:
        ;             push( st.name<st.start> )
        ;         el:
        ;             push( <*st.count>st.name<st.start> )
        ;         init( -name=name, -count=1, -busp=true, -start=bit )
        ; el:
        ;     if st.count == 1:
        ;         push( st.name )
        ;     el:
        ;         push( <*st.count>st.name )
        ;     init( -name=name, -count=1, -busp=true, -start=bit )
        busproc = lambda((name bit "tx")
            cond(
                (state~>count == 0
                    funcall(init ?name name ?count 1 ?busp t ?start bit)
                )
                (state~>busp
                    if(state~>name == name
                    then
                        cond(
                            (state~>count == 1
                                cond(
                                    (state~>start == bit
                                        state~>count += 1
                                    )
                                    (abs(bit - state~>start) == 1
                                        state~>count += 1
                                        state~>stop = bit
                                        state~>trend = bit - state~>start
                                    )
                                    (t
                                        mems = tconc(mems lsprintf("%s<%d>" state~>name state~>start))
                                        funcall(init ?name name ?count 1 ?busp t ?start bit)
                                    )
                                )
                            )
                            (state~>trend == (bit - state~>stop)
                                state~>count += 1
                                state~>stop = bit
                            )
                            (t
                                mems = tconc(mems
                                    if(state~>start == state~>stop
                                        lsprintf("<*%d>%s<%d>" state~>count state~>name state~>start)
                                        lsprintf("%s<%d:%d>" state~>name state~>start state~>stop)
                                    )
                                )
                                funcall(init ?name name ?count 1 ?busp t ?start bit)
                            )
                        )
                    else
                        mems = tconc(mems
                            cond(
                                (state~>count == 1
                                    lsprintf("%s<%d>" state~>name state~>start)
                                )
                                (state~>start == state~>stop
                                    lsprintf("<*%d>%s<%d>" state~>count state~>name state~>start)
                                )
                                (t
                                    lsprintf("%s<%d:%d>" state~>name state~>start state~>stop)
                                )
                            )
                        )
                        funcall(init ?name name ?count 1 ?busp t ?start bit)
                    )
                )
                (t
                    mems = tconc(mems
                        if(state~>count == 1
                            state~>name
                            lsprintf("<*%d>%s" state~>count state~>name)
                        )
                    )
                    funcall(init ?name name ?count 1 ?busp t ?start bit)
                )
            )
        ); busproc

        funcall(init)
        foreach(name names
            when(symbolp(name)
                name = symbolToString(name)
            )
            if(pcreMatchp("^(\\w+)<(\\d+)>$" name)
                funcall(busproc
                    pcreSubstitute("\\1")
                    atoi(pcreSubstitute("\\2"))
                )
                funcall(netproc name)
            )
        )
        funcall(netproc nil)
        buildString(car(mems) ",")
    )
)

; END
