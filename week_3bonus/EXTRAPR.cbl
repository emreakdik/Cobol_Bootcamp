      *****************************************************************
      * Program name:    EXTRAPR
      * Original author: Yunus Emre Akdik
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXTRAPR.
       AUTHOR. Yunus Emre Akdik
      *****************************************************************
      *****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INP-FILE ASSIGN  TO INPFILE
                           STATUS ST-INPFILE.

           SELECT OUT-FILE ASSIGN TO OUTFILE
                           STATUS ST-OUTFILE.
      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
       FD INP-FILE RECORDING MODE F.
       01 INP-REC.
           03 INP-ID      PIC 9(5).
           03 INP-DVZ     PIC 9(3).
           03 INP-NAME    PIC X(30).
           03 INP-DATE    PIC 9(8).
           03 INP-BALANCE PIC 9(15).
       FD OUT-FILE RECORDING MODE F.
       01 OUT-REC.
           03 OUT-ID      PIC 9(5).
           03 OUT-DVZ     PIC 9(3).
           03 OUT-NAME    PIC X(30).
           03 OUT-DATE    PIC 9(8).
           03 OUT-BALANCE PIC 9(15).
      *****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-WORK-AREA.
           03 ST-OUTFILE  PIC 9(2).
              88 OUTFILE-OK        VALUE 00.
           03 ST-INPFILE  PIC 9(2).
              88 INPFILE-OK        VALUE 00.
              88 INPFILE-EOF       VALUE 10.
       77  CHECK-ID       PIC 9(5) VALUE 10010.
       77  AMOUNT         PIC 9(15) VALUE 2400.
      *****************************************************************
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM H100-OPENFILES.
           PERFORM H200-PROCESS UNTIL INPFILE-EOF.
           PERFORM H300-END-OF-PROGRAM.
       MAIN-END. EXIT.

       H100-OPENFILES.
           OPEN INPUT INP-FILE.
           IF NOT INPFILE-OK
               DISPLAY "INP-FILE OPEN ERROR"
               MOVE ST-INPFILE TO RETURN-CODE
               PERFORM H300-END-OF-PROGRAM
           END-IF.
           OPEN OUTPUT OUT-FILE.
           IF NOT OUTFILE-OK
              DISPLAY "OUT-FILE OPEN ERROR"
              MOVE ST-OUTFILE TO RETURN-CODE
              PERFORM H300-END-OF-PROGRAM
           END-IF.
           READ INP-FILE
                IF NOT INPFILE-OK
                    DISPLAY "INP-FILE READ ERROR"
                    MOVE ST-INPFILE TO RETURN-CODE
                     PERFORM H300-END-OF-PROGRAM
                END-IF.
       H100-END. EXIT.

       H200-PROCESS.
           IF INP-ID NOT > CHECK-ID
           CALL 'SUBPRG' USING INP-DVZ, AMOUNT, INP-BALANCE, OUT-BALANCE
                MOVE INP-ID TO OUT-ID
                MOVE INP-DVZ TO OUT-DVZ
                MOVE INP-NAME TO OUT-NAME
                MOVE INP-DATE TO OUT-DATE
                WRITE OUT-REC
           ELSE
              MOVE INP-ID TO OUT-ID
              MOVE INP-DVZ TO OUT-DVZ
              MOVE INP-NAME TO OUT-NAME
              MOVE INP-DATE TO OUT-DATE
              MOVE INP-BALANCE TO OUT-BALANCE
              WRITE OUT-REC
           END-IF.
           READ INP-FILE.
       H200-END. EXIT.

       H300-END-OF-PROGRAM.
           CLOSE INP-FILE.
           CLOSE OUT-FILE.
           STOP RUN.
       H300-END. EXIT.

       END PROGRAM EXTRAPR.
      *****************************************************************
      *****************************************************************
      * Program name:    EXTRAPR0
      * Original author: YUNUS EMRE AKDIK
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUBPRG.
       AUTHOR. YUNUS EMRE AKDIK.
      *****************************************************************
       DATA DIVISION.
       LINKAGE SECTION.
       77 INPUT-EXC        PIC 9(3).
       77 INPUT-AMOUNT     PIC 9(15).
       77 INPUT-BALANCE    PIC 9(15).
       77 RESULT           PIC 9(15).
      *****************************************************************
       PROCEDURE DIVISION
           USING INPUT-EXC, INPUT-AMOUNT, INPUT-BALANCE, RESULT.

           IF INPUT-EXC = 840
              COMPUTE RESULT = INPUT-BALANCE + (INPUT-AMOUNT * 0.86)
           ELSE IF INPUT-EXC = 978
              COMPUTE RESULT = INPUT-BALANCE + (INPUT-AMOUNT * 0.98)
           ELSE IF INPUT-EXC = 949
              COMPUTE RESULT = INPUT-BALANCE + (INPUT-AMOUNT * 0.84)
           ELSE
              COMPUTE RESULT = INPUT-BALANCE + INPUT-AMOUNT
            END-IF.
           GOBACK.
       END PROGRAM SUBPRG.

