" Vim syntax file
" Language: PowerOn
" Maintainer: Phil Eagleson
" Latest Revision: 14 March 2020

if exists("b:current_syntax")
  finish
endif

syntax case ignore
" Keywords

" Type keywords
syn keyword poweronDataTypeKeywords NUMBER CHARACTER RATE MONEY CODE DATE FLOAT

" PreProcessor keywords
syn keyword poweronPreProcKeywords #INCLUDE

" Language keywords
syn keyword poweronLanguageKeywords ACCESS ACHADDENDA ACHADDINFO ACHEDIT ACHITEM ACCOUNTCHANGE ACROSS
syn keyword poweronLanguageKeywords ACTIVITY AFTERLAST AGREEMENT TRANSACTION ALL AND ANY ANYSERVICE ANYWARNING APPEND ASCII
syn keyword poweronLanguageKeywords ATMDIALOG AUDIO BEFOREFIRST BELL BLINK BLOCKSIZE BRIGHT CALL CAPITALIZE CARD CARDCREATIONWIZARD
syn keyword poweronLanguageKeywords CASHLETTER CASHORDER CDMDIALOG CERTIFICATE CHANGE TARGET

" RecordLevel keywords
syn keyword poweronRecordLevelKeywords ACCOUNT NAME SHARE LOAN TRACKING PREFERENCE NOTE CREDREP FMHISTORY

" Function keywords
syn keyword poweronFunctions ABS VALUE

" Matches
syn match poweronIdentifier '[a-z|A-Z]'
syn match poweronNumber '\d\+'
syn match poweronNumber '[-+]\d\+'

syn match poweronFloat '[-+]\d\+\.\d*'
syn match poweronFloat '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match poweronFloat '\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match poweronFloat '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match poweronFloat '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

syn cluster poweronDefineCluster contains=poweronNumber,poweronFloat,poweronDataTypeKeywords
" Regions
syn region poweronComment start='\[' end='\]'
syn region poweronString start='"' end='"'
syn region poweronDEFINE start='DEFINE' end='END' contains=poweronDataTypeKeywords, poweronIdentifier
syn region poweronSELECT start='SELECT' end='END'
syn region poweronSETUP start='SETUP' end='END' contains=poweronIdentifier,poweronNumber,poweronFloat,poweronString
syn region poweronSORT start='SORT' end='END'
syn region poweronPRINT start='PRINT TITLE' end='END'
syn region poweronPROCEDURE start='PROCEDURE' end='END'


" Tell Vim how to highlight
let b:current_syntax = "poweron"

hi def link poweronDataTypeKeywords      Type
hi def link poweronComment               Comment
hi def link poweronLanguageKeywords      Statement
hi def link poweronPreProcKeywords       Include
hi def link poweronRecordLevelKeywords   Keyword
hi def link poweronFunctions             Function
hi def link poweronNumber                Number
hi def link poweronFloat                 Float
hi def link poweronDEFINE                Function
hi def link poweronIdentifier            Identifier
