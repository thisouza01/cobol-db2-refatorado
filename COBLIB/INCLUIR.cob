       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   INCLUIR.
      ****************************************
      * PROGRAMA DE INCLUSAO DO FUNCIONARIO  *
      ****************************************
       ENVIRONMENT                   DIVISION.
       CONFIGURATION                 SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       DATA                          DIVISION.
      *
       WORKING-STORAGE               SECTION.
      * Variáveis de controle SQL 
       COPY SQLVARS.
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
       77   LK-EMAILFUN-ACCEPT          PIC X(30).       
      *
       PROCEDURE                     DIVISION USING LK-ACCEPT,
                                                    LK-EMAILFUN-ACCEPT.
      * Tratamento de SQLCODE 
       COPY SQLTREAT.                                             
      *
       PERFORM INCLUI-FUNCIONARIO.
       GOBACK.
      *
       INCLUI-FUNCIONARIO.
          MOVE LK-CODFUN-ACCEPT     TO DB2-CODFUN.
          MOVE LK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-NOMEFUN-LEN.
          CALL "CONTNOME"           USING DB2-NOMEFUN.
          MOVE LK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.
          MOVE LK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.
          MOVE LK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.
          MOVE LK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.
          MOVE LK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-EMAILFUN-LEN.
          CALL "CONTMAIL"           USING DB2-EMAILFUN.

          EXEC SQL
             INSERT INTO EAD719.FUNCIONARIOS
             VALUES(  :DB2-CODFUN,
                      :DB2-NOMEFUN,
                      :DB2-SALARIOFUN,
                      :DB2-DEPTOFUN,
                      :DB2-ADMISSFUN,
                      :DB2-IDADEFUN,
                      :DB2-EMAILFUN)
          END-EXEC.

          PERFORM TRATA-SQLCODE.

          EVALUATE WS-SQL-STATUS
              WHEN 'SUCESSO'
                  EXEC SQL COMMIT END-EXEC                                
                  DISPLAY 'FUNCIONARIO ' DB2-CODFUN 
                          ' INCLUIDO COM SUCESSO!'
              WHEN 'JA-EXISTE'
                  DISPLAY 'FUNCIONARIO ' DB2-CODFUN 
                          ' JA EXISTE!'
              WHEN 'FK-INVALIDA'
                  DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN 
                          ' NAO EXISTE!'
              WHEN 'NAO-ENCONTRADO'
                  DISPLAY 'ERRO NA VALIDACAO DOS DADOS'
              WHEN OTHER
                  CONTINUE
          END-EVALUATE.