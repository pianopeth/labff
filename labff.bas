parameter$ = UCASE$(COMMAND$)
IF LEFT$(parameter$, 7) = "/SILENT" THEN
    silentmode = 1
END IF

inifile$ = "labff.ini"
markernew$ = "0"

COLOR 7
PRINT "AUDACITY LABELS -> FFMPEG INPUT FILE CONVERTER v0.2 by iCS 2023-03-28"
PRINT ""

'create ini file if not exists
IF NOT _FILEEXISTS(inifile$) THEN
    OPEN inifile$ FOR OUTPUT AS #4
    PRINT #4, CHR$(34) + "project\" + CHR$(34) + CHR$(44) + CHR$(32) + CHR$(34) + "score_" + CHR$(34) + CHR$(44) + CHR$(32) + "4" + CHR$(44) + CHR$(32) + CHR$(34) + "png" + CHR$(34)
    CLOSE #4
END IF

'read data from inifile
OPEN inifile$ FOR INPUT AS #3
INPUT #3, projectfolder$, prefix$, precision, extension$
CLOSE #3

'make project folder if not exists
IF NOT _DIREXISTS(projectfolder$) THEN
    MKDIR (projectfolder$)
    COLOR 12
    PRINT "Put source image, audio and Audacity label files into " + projectfolder$ + " folder!"
    COLOR 7
    END
END IF

'error if labels.txt not exists
IF NOT _FILEEXISTS(projectfolder$ + "labels.txt") THEN
    COLOR 12
    PRINT "Error: source file labels.txt is missing. Use File/Export/Export labels in Audacity and copy the file into this folder ;)"
    COLOR 7
    END
END IF

'create input.txt if not exists
'to prevent error message
IF NOT _FILEEXISTS(projectfolder$ + "input.txt") THEN
    OPEN projectfolder$ + "input.txt" FOR OUTPUT AS #2
    PRINT #2, ""
    CLOSE #2
END IF

'print infos
PRINT "Work folder:", CHR$(34) + projectfolder$ + CHR$(34)
PRINT "Prefix:", CHR$(34) + prefix$ + CHR$(34)
PRINT "Digits:", precision
PRINT "Extension:", extension$
PRINT "(Modify values in " + inifile$ + " if you use different filename template)"
PRINT ""
IF silentmode = 1 THEN _DELAY 2
PRINT "Writing input.txt:"
PRINT ""
COLOR 15

fnum = 1

OPEN projectfolder$ + "labels.txt" FOR INPUT AS #1
OPEN projectfolder$ + "input.txt" FOR OUTPUT AS #2

DO WHILE NOT EOF(1)
    INPUT #1, marker$

    'calculate duration
    markerdur = VAL(marker$) - VAL(markermem$)

    'file numbering
    fnumnew$ = _TRIM$(STR$(fnum))

    'add leading zeros
    WHILE LEN(fnumnew$) < precision
        fnumnew$ = "0" + LTRIM$(fnumnew$)
    WEND

    'limit to 7 digits
    fnumnew$ = RIGHT$(fnumnew$, 7)
    IF silentmode = 1 THEN _DELAY 0.05


    PRINT "file " + CHR$(39) + prefix$ + fnumnew$ + CHR$(46) + extension$ + CHR$(39);
    COLOR 8
    PRINT "[starts at " + markernew$ + "]"
    COLOR 15

    'write output file
    PRINT #2, "file " + CHR$(39) + prefix$ + fnumnew$ + CHR$(46) + extension$ + CHR$(39)
    PRINT "duration" + STR$(markerdur)
    PRINT #2, "duration" + STR$(markerdur)

    markernew$ = LEFT$(marker$, INSTR(marker$, CHR$(9)) - 1)

    'save current marker in order to be able calculate duration in the next round
    '(markerdur = VAL(marker$) - VAL(markermem$))

    markermem$ = marker$

    'next label/file
    fnum = fnum + 1

LOOP
CLOSE #2
CLOSE #1
COLOR 7

'check command line parameter
IF silentmode = 1 THEN
    _DELAY 2
    SYSTEM
END IF
END

