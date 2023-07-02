//PBCID01J JOB 1,NOTIFY=&SYSUID
//***************************************************/
//* Copyright Contributors to the COBOL Programming Course
//* SPDX-License-Identifier: CC-BY-4.0
//***************************************************/
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
