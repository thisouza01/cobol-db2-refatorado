       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTERAR.
      ****************************************
      * PROGRAMA DE ALTERACAO DO FUNCIONARIO *
      ****************************************
       ENVIRONMENT                   DIVISION.
       CONFIGURATION                 SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       DATA                          DIVISION.
      *
       WORKING-STORAGE               SECTION.
      *
       LINKAGE                       SECTION.
       01  LK-ACCEPT.
              05 LK-FUNCAO-ACCEPT       PIC X.
              05 LK-CODFUN-ACCEPT       PIC X(4).
              05 LK-NOMEFUN-ACCEPT      PIC X(30).
              05 LK-SALARIOFUN-ACCEPT   PIC 9(6)V99.
              05 LK-DEPTOFUN-ACCEPT     PIC X(3).
              05 LK-ADMISSFUN-ACCEPT    PIC X(11).
              05 LK-IDADEFUN-ACCEPT     PIC 99.
       77  LK-EMAILFUN-ACCEPT           PIC X(30).       
      *
       PROCEDURE                     DIVISION USING LK-ACCEPT,
                                                    LK-EMAILFUN-ACCEPT.
      *
       PERFORM ALTERA-INFORMACAO.
       GOBACK.
      *
       ALTERA-INFORMACAO.
           MOVE LK-CODFUN-ACCEPT     TO DB2-CODFUN.

           IF   LK-NOMEFUN-ACCEPT    NOT = SPACES
               CALL "ALTNOME" USING DB2-CODFUN,
                                    LK-NOMEFUN-ACCEPT
           END-IF.
           IF   LK-SALARIOFUN-ACCEPT IS NUMERIC
               CALL "ALTSALAR" USING DB2-CODFUN,
                                     LK-SALARIOFUN-ACCEPT          
           END-IF.
           IF   LK-DEPTOFUN-ACCEPT   NOT = SPACES
               CALL "ALTDEPTO" USING DB2-CODFUN,
                                     LK-DEPTOFUN-ACCEPT         
           END-IF.
           IF   LK-ADMISSFUN-ACCEPT  NOT = SPACES
               CALL "ALTADMIS" USING DB2-CODFUN,
                                     LK-ADMISSFUN-ACCEPT  
           END-IF.
           IF   LK-IDADEFUN-ACCEPT   IS NUMERIC
               CALL "ALTIDADE" USING DB2-CODFUN,
                                     LK-IDADEFUN-ACCEPT  
           END-IF.
           IF   LK-EMAILFUN-ACCEPT   NOT = SPACES
               CALL "ALTEMAIL" USING DB2-CODFUN,
                                     LK-EMAILFUN-ACCEPT
           END-IF.