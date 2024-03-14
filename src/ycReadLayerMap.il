;--------------------------
; Program  : skill-utils(ycReadLayerMap.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; layermap 文件解析

procedure(ycReadLayerMap(\@key file tech libName reverse)
    prog((fileName lib rows map)
        fileName = cond(
            (file
                file
            )
            (tech || libName
                unless(tech
                    unless(lib = ddGetObj(libName)
                        ycError("no such lib - %s" libName)
                    )
                    tech = techGetTechFile(lib)
                )
                ddGetObj(tech~>libName nil nil strcat(tech~>libName ".layermap"))~>readPath
            )
            (t
                ycError("cannot found layermap file")
            )
        )
        unless(rows = ycCat(fileName t)
            ycWarn("cannot open '%s' for reading: Permmission denied" fileName)
            return()
        )
        map = makeTable("LayerMap" nil)
        foreach(item rows
            prog((info layerName purpose gdsNumber dataType key val)
                when(pcreMatchp("^([^#]*)#.*$" item)
                    item = pcreSubstitute("\\1")
                )
                when(info = parseString(item)
                    ycListAssign(info 'layerName 'purpose 'gdsNumber 'dataType)
                    if(reverse
                    then
                        key = list(gdsNumber dataType)
                        val = list(layerName purpose)
                    else
                        key = list(layerName purpose)
                        val = list(gdsNumber dataType)
                    )
                    unless(map[key]
                        map[key] = val
                    )
                )
            )
        )
        return(map)
    )
)

; END
