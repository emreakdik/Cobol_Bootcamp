       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PBVSAM0.
       AUTHOR. Yunus Emre Akdik.
      *****************************************************************
      *****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INP-FILE ASSIGN  TO INPFILE
                           STATUS ST-INPFILE.
           SELECT OUT-FILE ASSIGN TO OUTFILE
                           STATUS ST-OUTFILE.
           SELECT IDX-FILE ASSIGN TO IDXFILE
                           ORGANIZATION INDEXED
                           ACCESS RANDOM
                           RECORD KEY IDX-KEY
                           STATUS ST-IDXFILE.
      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
       FD INP-FILE RECORDING MODE F.
       01 INP-KEY.
           03 INP-ID            PIC X(05).
           03 INP-DVZ           PIC X(03).
       FD OUT-FILE RECORDING MODE F.
       01 OUT-REC.
           03 OUT-ID         PIC 9(05).
           03 OUT-DVZ        PIC 9(03).
           03 OUT-NAME       PIC X(30).
           03 OUT-DATE       PIC X(8).
           03 OUT-BALANCE    PIC 9(15).
       FD IDX-FILE.
       01 IDX-REC.
           03 IDX-KEY.
              05 IDX-ID            PIC S9(5) COMP-3.
              05 IDX-DVZ           PIC S9(3) COMP.
           03 IDX-NAME       PIC X(30).
           03 IDX-DATE       PIC S9(7) COMP-3.
           03 IDX-BALANCE    PIC S9(15) COMP-3.
      *****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-WORK-AREA.
           03 ST-INPFILE         PIC 9(2).
               88 INP-EOF              VALUE 10.
               88 INP-OK               VALUE 0 97.
               88 INP-NF               VALUE 23.
           03 ST-OUTFILE         PIC 9(2).
               88 OUT-EOF              VALUE 10.
               88 OUT-OK               VALUE 0 97.
               88 OUT-NF               VALUE 23.
           03 ST-IDXFILE         PIC 9(2).
               88 IDX-EOF              VALUE 10.
               88 IDX-OK               VALUE 0 97.
               88 IDX-NF               VALUE 23.
       77 INT-DATE           PIC 9(7).
       77 GREG-DATE          PIC 9(8).
      ******************************************************************
       PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM H200-OPEN-FILES
           PERFORM H300-PROCESS-RECORD UNTIL INP-EOF
           PERFORM H990-SHUT-DOWN.
       0000-END. EXIT.
      *
       H200-OPEN-FILES.
           OPEN INPUT INP-FILE.
           IF INP-NF OR NOT INP-OK
                DISPLAY "INP-FILE ERROR"
                MOVE ST-INPFILE TO RETURN-CODE
                PERFORM H990-SHUT-DOWN
           END-IF.
           OPEN OUTPUT OUT-FILE.
           IF OUT-NF OR NOT OUT-OK
                DISPLAY "OUT-FILE ERROR"
                MOVE ST-OUTFILE TO RETURN-CODE
                PERFORM H990-SHUT-DOWN
           END-IF.
           OPEN INPUT  IDX-FILE.
           IF IDX-NF OR NOT IDX-OK
                DISPLAY "IDX-FILE ERROR"
                MOVE ST-IDXFILE TO RETURN-CODE
                PERFORM H990-SHUT-DOWN
           END-IF.
           READ INP-FILE.
           IF (NOT INP-OK)
                DISPLAY "INP-FILE ERROR"
                MOVE ST-INPFILE TO RETURN-CODE
                PERFORM H990-SHUT-DOWN
           END-IF.
       H200-END. EXIT.
      *
       H300-PROCESS-RECORD.
           COMPUTE IDX-ID  = FUNCTION NUMVAL (INP-ID).
           COMPUTE IDX-DVZ = FUNCTION NUMVAL (INP-DVZ).
           READ IDX-FILE KEY IDX-KEY
             INVALID KEY PERFORM H410-ERROR-MSG
             NOT INVALID KEY PERFORM H400-DISPLAY-RECORD.
           READ INP-FILE.
       H300-END. EXIT.
      *
       H400-DISPLAY-RECORD.
           PERFORM H910-DATE-CONVERSION.
           MOVE IDX-ID TO OUT-ID.
           MOVE IDX-DVZ TO OUT-DVZ.
           MOVE IDX-NAME TO OUT-NAME.
           MOVE GREG-DATE  TO OUT-DATE.
           MOVE IDX-BALANCE TO OUT-BALANCE.
           WRITE OUT-REC.
       H400-END. EXIT.
      *
       H410-ERROR-MSG.
           DISPLAY "INVALID KEY: " IDX-ID IDX-DVZ.
       H410-END. EXIT.
      *
       H910-DATE-CONVERSION.
           COMPUTE INT-DATE = FUNCTION INTEGER-OF-DAY(IDX-DATE).
           COMPUTE GREG-DATE = FUNCTION DATE-OF-INTEGER(INT-DATE).
       H910-END. EXIT.
      *
       H990-SHUT-DOWN.
           CLOSE INP-FILE
           CLOSE IDX-FILE
           CLOSE OUT-FILE.
           STOP RUN.
       H990-END. EXIT.
