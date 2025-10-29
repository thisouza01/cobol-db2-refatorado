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

      * Variáveis de controle SQL 
       COPY SQLVARS.
      *
       LINKAGE                       SECTION.
       01 LK-DEPTOFUN-ACCEPT         PIC X(03).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-DEPTOFUN-ACCEPT.
      * Tratamento de SQLCODE 
           COPY SQLTREAT.                                                     
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

            PERFORM TRATA-SQLCODE.

           EVALUATE WK-SQL-STATUS
           WHEN 'SUCESSO'
              EXEC SQL COMMIT END-EXEC              
              DISPLAY 'DEPARTAMENTO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-DEPTOFUN
           WHEN 'NAO-ENCONTRADO'
              DISPLAY 'ERRO NA VALIDACAO DO CODIGO DO FUNCIONARIO'
           WHEN 'FK-INVALIDA'
              DISPLAY 'DEPARTAMENTO ' LK-DEPTOFUN-ACCEPT
                      ' NAO EXISTE!'
           WHEN OTHER
              EXEC SQL ROLLBACK END-EXEC
              STOP RUN  
           END-EVALUATE.
      
