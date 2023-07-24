;--------------------------
; Program  : skill-utils(ycForeachOnCIW.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 在 CIW 上同步显示当前 foreach 的进度
; 先实现功能，目前能用，但效率极低待优化

defmacro( ycForeachOnCIW ( \@rest body )
    'let((_body _call _fmlVar _iexpr _minCount _exprList)
        _body = '(,@body)

        ; mapping function
        if(member(car(_body) '(map mapc mapcan mapcar mapcon maplist))
        then
            _call = car(_body)
            _body = cdr(_body)
        else
            _call = 'mapc
        )

        ; formal variable
        _fmlVar = car(_body)
        cond(
            (symbolp(_fmlVar)
                _iexpr = 1
            )
            (forall(x _fmlVar symbolp(x))
                _iexpr = length(_fmlVar)
            )
            (t
                ycError("the formal variable must be a symbol or list of symbols - %A" _fmlVar)
            )
        )

        ; expr list
        for(i 1 _iexpr
            let((var)
                var = eval(nth(i _iexpr))
                if(listp(var) || tablep(var)
                then
                    _exprList = append1(_exprList nth(i _body))
                    _minCount = _minCount && min(_minCount length(var)) || length(var)
                else
                    ycError("the expression list should be a list or table - %A" var)
                )
            )
        )

        ; expr body
        _body = nthcdr(_iexpr _body)
        hiShowProgressBar(hiGetCIWindow() _minCount 0 "Foreach On CIW")
        hiSetProgressBar(hiGetCIWindow() 0)
        prog1(
            car(errset(
                apply('foreach
                    _call
                    _fmlVar
                    nconc(
                        _exprList
                        '(hiAdvanceProgressBarOneStep(hiGetCIWindow()))
                        _body
                    )
                )
                t
            ))
            hiHideProgressBar(hiGetCIWindow())
        )
    )
)

; END
