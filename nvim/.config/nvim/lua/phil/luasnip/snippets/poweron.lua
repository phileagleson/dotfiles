local ls = require('luasnip')
local s = ls.s -- snippet
local i = ls.i -- insert node
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local pfFieldFmt = [[
       POASJSONFIELD="{}"
       {}={}
       CALL {}
       {}
]]


local pfFields = function(idxs)
    return {
        i(idxs[1], 'KEY'),
        c(idxs[2], {
            t('POASJSONVALUECHAR='),
            t('POASJSONVALUEMONEY='),
            t('POASJSONVALUENUMBER='),
            t('POASJSONVALUERATE='),
            t('POASJSONVALUEDATE='),
        }),
        i(idxs[3], 'VALUE'),
        d(idxs[4], function(args)
            local datatype = args[1][1]:sub(14, #args[1][1] - 1)
            print('datatype:', datatype)
            if (datatype == 'char' or datatype == 'CHAR') then
                return sn(1, t('POASJSONFIELDCHAR'))
            elseif (datatype == 'money' or datatype == 'MONEY') then
                return sn(1, t('POASJSONFIELDMONEY'))
            elseif (datatype == 'rate' or datatype == 'RATE') then
                return sn(1, t('POASJSONFIELDRATE'))
            elseif (datatype == 'number' or datatype == 'NUMBER') then
                return sn(1, t('POASJSONFIELDNUMBER'))
            elseif (datatype == 'date' or datatype == 'DATE') then
                return sn(1, t('POASJSONFIELDDATE'))
            else
                return sn(1, t(''))
            end
        end, { idxs[2] }),
        c(idxs[5], {
            t('CALL POASJSONCOMMA'),
            t('')
        })
    }
end


local pff = s('pff', fmt(pfFieldFmt, pfFields({ 1, 2, 3, 4, 5 })))
table.insert(autosnippets, pff)

--[[ local pfFieldSnip = function(idx)
    return sn(idx, pfFieldFunc)
end ]]

local poasList = s('psl', fmt([[
[ 
 FILENAME: {}

-ABSTRACT:

-HISTORY:

-DETAILS:

 THE RESPONSE JSON CONTAINS THE FOLLOWING INFORMATION:
]

TARGET=ACCOUNT

DEFINE
 #INCLUDE "RD.GETDATA.DEF"
 #INCLUDE "RD.GETDATA1.DEF"

 #INCLUDE "RD.POAS.CONSTANTS.DEF"
 #INCLUDE "RD.POAS.GINP.GETINPUT.DEF"
 #INCLUDE "RD.POAS.JSON.CREATION.DEF"
 #INCLUDE "RD.POAS.PMLF.PARM.LETRFIL.DEF"
 #INCLUDE "RD.POAS.READ.PARSE.INPUT.DEF"
 #INCLUDE "RD.POAS.TXTP.TEXTPARSE.DEF"
 #INCLUDE "RD.POAS.VARIABLES.DEF"
END

SETUP
 #INCLUDE "RD.POAS.CONSTANTS.SET"
 #INCLUDE "RD.POAS.GINP.GETINPUT.SET"
 #INCLUDE "RD.POAS.JSON.CREATION.SET"
 #INCLUDE "RD.POAS.TXTP.TEXTPARSE.SET"

 CALL POASGINPGETINPUT
 CALL POASGETCUSTOMINPUT
 CALL POASGETDATA

 CALL POASGETNAMESBUILDJSON
END

PRINT TITLE=""
 SUPPRESSNEWLINE
END

PROCEDURE POASGECUSTOMINPUT
END

PROCEDURE POASGETDATA
 {}
END

PROCEDURE POASGETNAMESBUILDJSON
 CALL POASGETNAMESBUILDJSONHEADER
 IF STATUSTYPE<>STATUSTYPEERROR THEN
  DO
   CALL POASJSONCOMMA
   CALL POASGETNAMESBUILDJSONBODY
  END
 CALL POASJSONCOMMA
 CALL POASJSONERRORMSG
 CALL POASJSONFOOTER
 CALL POASJSONOUTPUTJSON
END

PROCEDURE POASGETNAMESBUILDJSONHEADER
 MAINOBJNAME="{}"
 CALL POASJSONHEADER

 POASJSONFIELD=POASGINPMESSAGEIDN
 POASJSONVALUECHAR=POASGINPMESSAGEID
 CALL POASJSONFIELDCHAR
END

PROCEDURE POASGETNAMESBUILDJSONBODY
 DATAOBJNAME="{}"
 CALL POASJSONSTARTARRAYOBJ

  FOR {} = {} TO {}
   DO
     IF {} <> {} THEN 
        DO
         CALL POASJSONCOMMA
        END

       CALL POASJSONOPENCURLY

       POASJSONFIELD="{}"
       {}={}
       CALL {}
       {}

   END
   
   CALL POASJSONCLOSECURLY

 CALL POASJSONENDARRAYOBJ
END

[STANDARD .PRO POAS INCLUDE FILES]
#INCLUDE "RD.POAS.GINP.GETINPUT.PRO"
#INCLUDE "RD.POAS.JSON.CREATION.PRO"
#INCLUDE "RD.POAS.PMLF.PARM.LETRFIL.PRO"
#INCLUDE "RD.POAS.READ.PARSE.INPUT.PRO"
#INCLUDE "RD.POAS.TXTP.TEXTPARSE.PRO"
#INCLUDE "RD.POAS.USEOBJFIELD.NULL.PRO"
]], {
    d(1, function(_, snip)
        return sn(nil, i(1, snip.env.TM_FILENAME))
    end, {}),
    i(12, ''),
    sn(2, { i(1, 'getDataList'), t('Rs') }),
    d(3, function(args)
        local listName = ''
        for x = 1, #args[1][1] - 2 do
            if (x > 3) then
                listName = listName .. args[1][1]:sub(x, x)
            end
        end
        return sn(nil, {
            i(1, listName)
        })
    end, { 2 }),
    i(4, 'X'),
    c(5, { i(nil, '1'), i(nil, '0') }),
    i(6, 'ITEMCOUNT'),
    rep(4),
    rep(5),
    --pfFieldSnip(7)
    --    i(7, ''),
    unpack(pfFields({ 7, 8, 9, 10, 11 }))
}
)
)
table.insert(snippets, poasList)


return snippets, autosnippets
