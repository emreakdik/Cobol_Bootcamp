      *****************************************************************
      * Program name:    DAYCAL01
      * Original author: Yunus Emre Akdik
      *
      * Maintenence Log
      * Date      Author        Maintenance Requirement
      * --------- ------------  ---------------------------------------
      * 25/06/2023 Yunus Emre Akdik  Created for COBOL class
      *
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  DAYCAL01.
       AUTHOR. Yunus Emre Akdik.
       INSTALLATION. COBOL DEVELOPMENT CENTER.
       DATE-WRITTEN. 25/06/2023.
       DATE-COMPILED. 25/06/2023.
       SECURITY. NON-CONFIDENTIAL.
      *****************************************************************
      *****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-3081.
       OBJECT-COMPUTER. IBM-3081.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-LINE ASSIGN  TO PRTLINE
                             STATUS ST-PRINT-LINE.
           SELECT DATE-REC   ASSIGN TO DATEREC
                             STATUS ST-DATE-REC.
      *****************************************************************
      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
       FD  PRINT-LINE RECORDING MODE F.
       01  PRINT-LINE-REC.
             05 PRINT-LINE-ID      PIC 9(4).
             05 PRINT-LINE-NAME    PIC X(15).
             05 PRINT-LINE-SNAME   PIC X(15).
             05 PRINT-LINE-BDATE   PIC 9(8).
             05 PRINT-LINE-TODAY   PIC 9(8).
             05 PRINT-LINE-RES     PIC 9(5).
       FD  DATE-REC RECORDING MODE F.
       01  RECORD-DATE-REC.
             05 RECORD-DATE-ID     PIC 9(4).
             05 RECORD-DATE-NAME   PIC X(15).
             05 RECORD-DATE-SNAME  PIC X(15).
             05 RECORD-DATE-BDATE  PIC 9(8).
             05 RECORD-DATE-TODAY  PIC 9(8).
      *****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-DATE-REC.
           05 WS-RES-DAY           PIC 9(5).
           05 WS-BDATE-INT         PIC 9(8).
           05 WS-TDATE-INT         PIC 9(8).
           05 ST-PRINT-LINE        PIC 9(2).
              88 ST-PRINT-LINE-OK     VALUE 00 97.
              88 ST-PRINT-LINE-EOF    VALUE 10.
           05 ST-DATE-REC          PIC 9(2).
              88 ST-DATE-REC-OK       VALUE 00 97.
              88 ST-DATE-REC-EOF      VALUE 10.
      *****************************************************************
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM H100.
           PERFORM H200 UNTIL ST-DATE-REC-EOF.
           PERFORM H300.
       MAIN-PROCEDURE-END. EXIT.

       H100.
           OPEN INPUT DATE-REC.
           OPEN OUTPUT PRINT-LINE.
           IF NOT ST-DATE-REC-OK
              DISPLAY "DATE-REC FILE OPEN ERROR"
           END-IF.

           IF NOT ST-PRINT-LINE-OK
              DISPLAY "PRINT-LINE FILE OPEN ERROR"
           END-IF.
           READ DATE-REC.
       H100-END. EXIT.


       H200.
           COMPUTE WS-BDATE-INT = FUNCTION INTEGER-OF-DATE
           (RECORD-DATE-BDATE).
           COMPUTE WS-TDATE-INT = FUNCTION INTEGER-OF-DATE
           (RECORD-DATE-TODAY).
           COMPUTE WS-RES-DAY = WS-BDATE-INT - WS-TDATE-INT.
           MOVE RECORD-DATE-ID TO PRINT-LINE-ID.
           MOVE RECORD-DATE-NAME TO PRINT-LINE-NAME.
           MOVE RECORD-DATE-SNAME TO PRINT-LINE-SNAME.
           MOVE RECORD-DATE-BDATE TO PRINT-LINE-BDATE.
           MOVE RECORD-DATE-TODAY TO PRINT-LINE-TODAY.
           MOVE WS-RES-DAY TO PRINT-LINE-RES.
           WRITE PRINT-LINE-REC.
           READ DATE-REC.
       H200-END. EXIT.

       H300.
           CLOSE DATE-REC.
           CLOSE PRINT-LINE.
           STOP RUN.





