//CRINPUTJ JOB 1,NOTIFY=&SYSUID
//COBRUN  EXEC IGYWCL
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//DELET100 EXEC PGM=IDCAMS
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
