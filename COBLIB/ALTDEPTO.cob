       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTDEPTO.
      ********************************************************
      * PROGRAMA DE ALTERACAO DO DEPARTAMENTO DO FUNCIONARIO *
      ********************************************************
       ENVIRONMENT                   DIVISION.
       CONFIGURATION                 SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       DATA                          DIVISION.
      *
       WORKING-STORAGE               SECTION.
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
               INCLUDE BOOKFUNC
           END-EXEC.
      *
       77 RETORNO-SQLCODE            PIC -999   VALUE ZEROS.
      *
       LINKAGE                       SECTION.
       01 LK-DEPTOFUN-ACCEPT         PIC X(03).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-DEPTOFUN-ACCEPT.
                                                    
      *
       PERFORM ALTERA-DEPARTAMENTO.
       GOBACK.
      *
       ALTERA-DEPARTAMENTO.
           MOVE LK-DEPTOFUN-ACCEPT TO DB2-DEPTOFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET DEPTOFUN = :DB2-DEPTOFUN
                   WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'DEPARTAMENTO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-DEPTOFUN
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN -530
              DISPLAY 'DEPARTAMENTO ' LK-DEPTOFUN-ACCEPT
                      ' NAO EXISTE!'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DO DEPARTAMENTO'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
