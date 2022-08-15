local ls = require('luasnip')
local s = ls.s -- snippet
local i = ls.i -- insert node
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
--local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local def = s('def', fmt([[
  {}={}
]], {
    i(1, 'VARNAME'),
    c(2, {
        t('CHARACTER'),
        t('DATE'),
        t('MONEY'),
        t('NUMBER'),
        t('RATE'),
    }),
}))
table.insert(autosnippets, def)

local pfFieldFmt = [[
       POASJSONFIELD="{}"
       {}{}
       CALL {}
       {}
]]

local pfinput = s('pfi', fmt([[
    IF NAMEARRAY(I)="{}" THEN
      DO
        {}={}
      END
]], {
    i(1, 'myInput'),
    i(2, 'MYVAR'),
    c(3, {
        t('VALUEARRAY(I)'),
        t('VALUE(VALUEARRAY(I))'),
        t('MONEYVALUE(VALUEARRAY(I))'),
        t('RATEVALUE(VALUEARRAY(I))'),
        t('NUMBERVALUE(VALUEARRAY(I))'),
    })
}))
table.insert(autosnippets, pfinput)

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
 {}
 CALL POASGETDATA

 CALL POASGETNAMESBUILDJSON
END

PRINT TITLE=""
 SUPPRESSNEWLINE
END

{}

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
       {}{}
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
    c(2, {
        t('CALL POASGETCUSTOMINPUT [Used to parse custom request parameters]'),
        t('')
    }),
    d(3, function(args)
        if args[1][1] ~= '' then
            return sn(nil, {
                t({ 'PROCEDURE POASGETCUSTOMINPUT', '' }),
                t({ '  ' }),
                i(1, 'LID'),
                t({ '=' }),
                i(2, '""'),
                t({ '', '' }),
                t({ '', '  FOR I=1 TO INPUTCTR', '' }),
                t({ '    DO', '' }),
                t({ '      IF NAMEARRAY(I)=' }),
                t({ '"' }),
                i(3, 'selLoanId'),
                t({ '"' }),
                t({ ' THEN', '' }),
                t({ '        DO', '' }),
                t({ '          ' }),
                rep(1),
                t({ '=VALUEARRAY(I)', '' }),
                t({ '        END', '' }),
                t({ '    END', '', '' }),
                t({ '  IF ' }),
                rep(1),
                t({ '= "" THEN ', '' }),
                t({ '    DO', '' }),
                t({ '      ERRORMSGCTR=ERRORMSGCTR+1', '' }),
                t({ '      ERRORMSG(ERRORMSGCTR)="' }),
                rep(3),
                t({ ' Cannot be Blank"', '' }),
                t({ '      STATUSTYPE="error"', '' }),
                t({ '    END', '' }),
                t({ 'END' })
            })
        else
            return sn(1, { t('') })
        end

    end, { 2 }),
    i(14, ''),
    sn(4, { i(1, 'getDataList'), t('Rs') }),
    d(5, function(args)
        local listName = ''
        for x = 1, #args[1][1] - 2 do
            if (x > 3) then
                listName = listName .. args[1][1]:sub(x, x)
            end
        end
        return sn(nil, {
            i(1, listName)
        })
    end, { 4 }),
    i(6, 'X'),
    c(7, { i(nil, '1'), i(nil, '0') }),
    i(8, 'ITEMCOUNT'),
    rep(6),
    rep(7),
    unpack(pfFields({ 9, 10, 11, 12, 13 }))
}
)
)
table.insert(snippets, poasList)

local psf = s('psf', fmt([[
[ 
 FILENAME: {}

-ABSTRACT:

-HISTORY:

-DETAILS:

 THE RESPONSE JSON CONTAINS THE FOLLOWING INFORMATION:
]

TARGET=Account

DEFINE
 #INCLUDE "RD.GETDATA.DEF"
 #INCLUDE "RD.GETDATA1.DEF"

 [Standard .DEF POAS include files]
 #INCLUDE "RD.POAS.CONSTANTS.DEF"
 #INCLUDE "RD.POAS.GINP.GETINPUT.DEF"
 #INCLUDE "RD.POAS.JSON.CREATION.DEF"
 #INCLUDE "RD.POAS.PMLF.PARM.LETRFIL.DEF"
 #INCLUDE "RD.POAS.READ.PARSE.INPUT.DEF"
 #INCLUDE "RD.POAS.TXTP.TEXTPARSE.DEF"
 #INCLUDE "RD.POAS.VARIABLES.DEF"
 
END

SETUP
 [Standard .SET POAS include files]
 #INCLUDE "RD.POAS.CONSTANTS.SET"
 #INCLUDE "RD.POAS.GINP.GETINPUT.SET"
 #INCLUDE "RD.POAS.JSON.CREATION.SET"
 #INCLUDE "RD.POAS.TXTP.TEXTPARSE.SET"

 [ Get the input message. ]
 CALL POASGINPGETINPUT
 CALL POASGETUSERGETINPUT [only if additional input processing is needed]

 [ Create JSON with <describe the data being output>. ]
 CALL POASGETUSERBUILDJSON
END

PRINT TITLE=""
 SUPPRESSNEWLINE
END

[
 Perform any special processing of the input arguments.

 (only create this procedure and call it if additional processing of the
  input is needed above what the common routine already does.)
]
PROCEDURE POASGETUSERGETINPUT
 RQUSERNUM=""
 
 FOR I=1 TO INPUTCTR
  DO
   IF NAMEARRAY(I)="usernum" THEN
     RQUSERNUM=VALUEARRAY(I)
  END
  
 IF RQUSERNUM="" THEN
  DO
   POASJSONMESSAGE="usernum cannot be blank>"
   CALL POASJSONMSGERROR
  END
END

[
 (describe any additional processing needed)

 Input:   <varname> - <describe input variables used by the procedure>
 Output:  <varname> - <describe variables output or updated by the procedure>
]
PROCEDURE POASGETUSERDATA
END

[
 Call the procedures required to build the response JSON.
]
PROCEDURE POASGETUSERBUILDJSON
 CALL POASGETUSERBUILDJSONHEADER
 IF STATUSTYPE<>STATUSTYPEERROR THEN
  DO
   CALL POASJSONCOMMA
   CALL POASGETUSERBUILDJSONBODY
  END
 CALL POASJSONERRORMSG
 CALL POASJSONFOOTER
 CALL POASJSONOUTPUTJSON
END

[
 Create the JSON response header.
]
PROCEDURE POASGETUSERBUILDJSONHEADER
 MAINOBJNAME="getUserDataRs"
 CALL POASJSONHEADER

 POASJSONFIELD=POASGINPMESSAGEIDN
 POASJSONVALUECHAR=POASGINPMESSAGEID
 CALL POASJSONFIELDCHAR

 [ Any additional header information here ]
END

[
 Create the JSON response body.  The body contains <describe contents here>.
]
PROCEDURE POASGETUSERBUILDJSONBODY

   POASJSONFIELD="userPhoneNumber"
   POASJSONVALUECHAR=char value
   CALL POASJSONFIELDCHAR
   CALL POASJSONCOMMA
   
END

[Standard .PRO POAS include files]
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
}))
table.insert(snippets, psf)
return snippets, autosnippets
