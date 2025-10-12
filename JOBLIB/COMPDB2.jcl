//CMPDB201 JOB ('J906NPD160911'),TSO.&SYSUID,
//    REGION=0M,NOTIFY=&SYSUID,
//    MSGCLASS=A,MSGLEVEL=1,CLASS=A
//***************************************************************
//        PRE-COMPILACAO (PC) COM O UTILITARIO DSNHPC           *
//***************************************************************
//CMPDB2   PROC MOD=
//PC       EXEC PGM=DSNHPC,
//     PARM='HOST(COB),APOST,APOSTSQL,SOURCE,VERSION(AUTO)'
//STEPLIB  DD DSN=DSN910.SDSNLOAD,DISP=SHR
//SYSLIB   DD DSN=IBMUSER.THIAGO.BOOKLIB,DISP=SHR
//DBRMLIB  DD DSN=IBMUSER.THIAGO.DBRMDB2(&MOD),SPACE=(TRK,(3,,1)),
//     UNIT=SYSDA,DISP=(SHR,CATLG),
//     DCB=(DSORG=PO,LRECL=80,RECFM=FB)
//SYSCIN   DD DSN=&&COBPG,DISP=(,PASS),UNIT=SYSDA,
//     SPACE=(800,(500,500))
//SYSIN    DD DSN=IBMUSER.THIAGO.COBLIB(&MOD),DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSTERM  DD SYSOUT=*
//SYSUT1   DD SPACE=(800,(500,500),,,ROUND),UNIT=SYSDA
//SYSUT2   DD SPACE=(CYL,(5,5)),
//     UNIT=SYSDA,
//     BLKSIZE=27920,LRECL=80,RECFM=FB,DSORG=PS
//***************************************************************
//*  IMPRESSAO DO FONTE PRE-COMPILADO COM O UTILITARIO IEBGENER *
//***************************************************************
//PRINTPC    EXEC  PGM=IEBGENER,COND=(4,LT,PC)
//SYSUT1     DD    DSN=&&COBPG,DISP=(OLD,PASS)
//SYSPRINT   DD    SYSOUT=*
//SYSUT2     DD    SYSOUT=*
//SYSIN      DD    DUMMY
//***************************************************************
//*          COMPILACAO (COB) COM O UTILITARIO IGYCRCTL         *
//***************************************************************
//COB    EXEC PGM=IGYCRCTL,REGION=2M,
//             PARM='BUFSIZE(32760),EXIT(NOPRTEXIT),LIB'
//STEPLIB  DD DISP=SHR,DSN=IGY420.SIGYCOMP
//         DD DSN=IBMUSER.THIAGO.BOOKLIB,DISP=SHR
//         DD DSN=IBMUSER.THIAGO.COPYLIB,DISP=SHR
//SYSLIB   DD DSN=DFH410.CICS.SDFHSAMP,DISP=SHR
//         DD DSN=DFH410.CICS.SDFHCOB,DISP=SHR
//         DD DSN=IBMUSER.THIAGO.COBLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DSN=&&COBPG,DISP=(OLD,PASS)
//SYSLIN   DD DSN=&&LOADSET,DISP=(,PASS),
//     UNIT=SYSDA,SPACE=(180,(250,100))
//SYSUT1   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT2   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT3   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT4   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT5   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT6   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT7   DD UNIT=SYSDA,SPACE=(960,(550,100))
//***************************************************************
//*         LINKEDICAO (LKED) COM O UTILITARIO IEWL             *
//***************************************************************
//LKED   EXEC PGM=IEWL,REGION=2M,
//        PARM='XREF',COND=(5,LT,COB)
//SYSLIB   DD DSN=DSN910.SDSNLOAD,DISP=SHR
//     DD DSN=IBMUSER.THIAGO.USERLOAD,DISP=SHR
//     DD DSN=SYS1.SIEALNKE,DISP=SHR
//     DD DSN=CEE.SCEELKED,DISP=SHR
//SYSLMOD  DD DSN=IBMUSER.THIAGO.USERLOAD(&MOD),DISP=SHR
//SYSUT1   DD UNIT=SYSDA,DCB=BLKSIZE=1024,
//        SPACE=(1024,(200,20))
//SYSPRINT DD SYSOUT=*
//SYSLIN   DD DSN=&&LOADSET,DISP=(OLD,DELETE)
//***************************************************************
//*          BIND (BINDPK03) COM O UTILITARIO IKJEFT01          *
//***************************************************************
//BINDPK03   EXEC  PGM=IKJEFT01,COND=(4,LT,COB),
//       DYNAMNBR=20
//DBRMLIB    DD    DSN=IBMUSER.THIAGO.DBRMDB2(&MOD),DISP=(OLD,KEEP)
//STEPLIB    DD    DSN=DSN910.SDSNLOAD,DISP=SHR
//SYSUDUMP   DD    SYSOUT=*
//SYSTSPRT   DD    SYSOUT=*
//SYSPRINT   DD    SYSOUT=*
//SYSTSIN    DD    DSN=IBMUSER.THIAGO.JOBLIB(PARBIND),DISP=SHR
//          PEND
//***************************************************************
//*               EXECUÇÃO DA PROC CMPDB2                       *
//***************************************************************
//COBDB2  EXEC CMPDB2,MOD=PROGMAIN
