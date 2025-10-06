       IDENTIFICATION                        DIVISION.
       PROGRAM-ID.                           CONTMAIL.
      *
       ENVIRONMENT                           DIVISION.
      *
       DATA                                  DIVISION.
       WORKING-STORAGE                       SECTION.
       77  WK-POSICAO                     PIC 99    VALUE ZEROS.
      *
       LINKAGE                               SECTION.
       01  LK-EMAILFUN.
             05  LK-EMAILFUN-LEN          PIC S9(04).
             05  LK-EMAILFUN-TEXT         PIC X(30).
      *
       PROCEDURE                             DIVISION USING LK-EMAILFUN.
      
       PERFORM CONTA-EMAIL.
       GOBACK.

       CONTA-EMAIL.
          MOVE 30 TO LK-EMAILFUN-LEN.
          PERFORM VARYING WK-POSICAO FROM 30 BY -1
                   UNTIL LK-EMAILFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
             SUBTRACT 1 FROM LK-EMAILFUN-LEN
          END-PERFORM.
      
