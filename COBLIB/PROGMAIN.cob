        IDENTIFICATION DIVISION.
        PROGRAM-ID.    PROGMAIN.
        AUTHOR.        THIAGO.
      **************************************************
      * INCLUSAO, EXCLUSAO E ALTERACAO DE FUNCIONARIOS *
      **************************************************
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
          DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
           EXEC SQL
              INCLUDE BOOKFUNC
           END-EXEC.
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.
       77  WK-SQLCODE-EDIT           PIC -999        VALUE ZEROS.
       
       COPY CPYACEP.
      *
       PROCEDURE DIVISION.
       000-PRINCIPAL SECTION.
       001-PRINCIPAL.
          PERFORM 101-INICIAR.
          PERFORM 201-PROCESSAR.
          PERFORM 901-FINALIZAR.
          STOP RUN.
       *******************************************************
       100-INICIAR SECTION.
       101-INICIAR.
          ACCEPT WK-ACCEPT FROM SYSIN.
          ACCEPT WK-ACCEPT FROM SYSIN.
          ACCEPT WK-EMAILFUN-ACCEPT FROM SYSIN.
       *******************************************************
       200-PROCESSAR SECTION.
       201-PROCESSAR.
          EVALUATE WK-FUNCAO-ACCEPT
             WHEN 'I'
                   CALL "INCLUIR" USING WK-ACCEPT,
                                         WK-EMAILFUN-ACCEPT
             WHEN 'E'
                   CALL "EXCLUIR" USING WK-CODFUN-ACCEPT
             WHEN 'A'
                   CALL "ALTERAR" USING WK-ACCEPT,
                                        WK-EMAILFUN-ACCEPT
             WHEN OTHER
                   DISPLAY 'FUNCAO ' WK-FUNCAO-ACCEPT ' INVALIDA!'
          END-EVALUATE.
      *******************************************************
       900-FINALIZAR SECTION.
       901-FINALIZAR.
          EXIT.
