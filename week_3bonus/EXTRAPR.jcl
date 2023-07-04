//CRQSAM0J JOB ' ',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=X,NOTIFY=&SYSUID
//DELET000 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE Z95615.QSAM.DD NONVSAM
  IF LASTCC LE 08 THEN SET MAXCC = 00
//SORT0100 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD *
10009840ELIF           KAYA           19871203
10008949AHMET          YILDIRIM       19940218
10007978AYSE           ARSLAN         19891022
10006840MEHMET         YILMAZ         19960811
10005949AYSE           ÇELIK          19780527
10004978EMRE           DEMIR          20010519
10003949MUSTAFA        ÖZTÜRK         19851229
10002949FATMA          AKTAN          19921107
10001840CAN            YILDIRIM       19991214
10000978MERVE          KARA           19980625
10011978ALI            YILMAZ         19821031
10010840AHMET          DEMIR          19950306
10012949ELIF           KARA           19910207
10013978EMRE           YILMAZ         19830816
//SORTOUT  DD DSN=&SYSUID..QSAM.DD,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5),RLSE),
//            DCB=(RECFM=FB,LRECL=60)
//SYSIN    DD *
  SORT FIELDS=(1,7,CH,A)
  OUTREC FIELDS=(1,38,39,8,Y4T,TOJUL=Y4T,15C'0')
//*
//DELET200 EXEC PGM=IEFBR14
//FILE01    DD DSN=&SYSUID..QSAM.FF,
//             DISP=(MOD,DELETE,DELETE),SPACE=(TRK,0)
//SORT0400 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DSN=&SYSUID..QSAM.DD,DISP=SHR
//SORTOUT  DD DSN=&SYSUID..QSAM.FF,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5),RLSE),
//            DCB=(RECFM=FB,LRECL=47)
//SYSIN DD *
  SORT FIELDS=COPY
    OUTREC FIELDS=(1,5,ZD,TO=PD,LENGTH=3,
                   6,3,ZD,TO=BI,LENGTH=2,
                   9,30,
                   39,7,ZD,TO=PD,LENGTH=4,
                   46,15,ZD,TO=PD,LENGTH=8)
//CRINPUTJ  EXEC IGYWCL
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//DELET300 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
   DELETE Z95615.QSAM.INP NONVSAM
   IF LASTCC LE 08 THEN SET MAXCC = 00
//***************************************************/
//RUN     EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//SORTIN    DD DSN=&SYSUID..QSAM.DD,DISP=SHR
//SORTOUT   DD DSN=&SYSUID..QSAM.INP,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(10,10),RLSE),
//             DCB=(RECFM=FB,LRECL=8,BLKSIZE=0)
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//SYSIN     DD  *
      SORT FIELDS=COPY
         INREC BUILD=(1:1,8)
//***************************************************/
// ELSE
// ENDIF
//DELET400 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
  DELETE Z95615.VSAM.AA CLUSTER PURGE
  IF LASTCC LE 08 THEN SET MAXCC = 00
  DEF CL ( NAME(Z95615.VSAM.AA)      -
           FREESPACE( 20 20 )        -
           SHR( 2,3 )                -
           KEYS(5 0)                 -
           INDEXED SPEED             -
           RECSZ(47 47)              -
           TRK (10 10)               -
           LOG(NONE)                 -
           VOLUME (VPWRKB)           -
           UNIQUE )                  -
   DATA (NAME(Z95615.VSAM.AA.DATA))  -
   INDEX ( NAME(Z95615.VSAM.AA.INDEX))
//REPRO500 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//INN001   DD DSN=Z95615.QSAM.FF,DISP=SHR
//OUT001   DD DSN=Z95615.VSAM.AA,DISP=SHR
//SYSIN    DD *
  REPRO INFILE(INN001) OUTFILE(OUT001)
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=Z95615.CBL(PBCID01),DISP=SHR
//LKED.SYSLMOD DD DSN=Z95615.LOAD(PBCID01),DISP=SHR
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//RUN     EXEC PGM=PBCID01
//STEPLIB   DD DSN=Z95615.LOAD,DISP=SHR
//INPFILE   DD DSN=Z95615.QSAM.INP,DISP=SHR
//IDXFILE   DD DSN=Z95615.VSAM.AA,DISP=SHR
//OUTFILE   DD DSN=Z95615.QSAM.OUT,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,
//             SPACE=(TRK,(20,20),RLSE),
//             DCB=(RECFM=FB,LRECL=61)
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//***************************************************/
// ELSE
// ENDIF
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=Z95615.CBL(EXTRAPR),DISP=SHR
//LKED.SYSLMOD DD DSN=Z95615.LOAD(EXTRAPR),DISP=SHR
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//RUN     EXEC PGM=EXTRAPR
//STEPLIB   DD DSN=Z95615.LOAD,DISP=SHR
//INPFILE   DD DSN=Z95615.QSAM.OUT,DISP=SHR
//OUTFILE   DD DSN=Z95615.QSAM.LOUT,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,
//             SPACE=(TRK,(20,20),RLSE),
//             DCB=(RECFM=FB,LRECL=61)
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//***************************************************/
// ELSE
// ENDIF