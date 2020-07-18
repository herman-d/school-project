Uses Crt;

Var
   P,A,B,C : Real;
   Coba    : Char;

Function Faktorial (N : Real) : Real;
Begin
   If N = 0 Then
      Faktorial := 1
   Else
      Faktorial := N * Faktorial (N-1);
End;
{
Function Faktor( N : Real ) : LongInt ;
Var Temp : LongInt ;
    I    : Byte ;
Begin
   For I := 1 to Trunc(N) do Temp := Temp * I ;
   Faktor := Temp ;
End ; }


Function Permutasi (A,B : Real) : Real ;
Begin
   Permutasi := Faktorial(A)/Faktorial(A-B);
End;

Function Combinasi (A,B : Real): real ;
Begin
   Combinasi := Faktorial(A)/(Faktorial(A)*Faktorial(A-B));
End;

Procedure Menu;
Begin
   Repeat
      ClrScr;
      GotoXY ( 8, 2); Write ('Permutasi     a          a!');
      GotoXY (24, 3); Write ('P  =  컴컴컴컴');
      GotoXY (22, 4); Write ('b        (a-b)!');
      GotoXY ( 8, 6); Write ('Combinasi     a          a!');
      GotoXY (24, 7); Write ('C  =  컴컴컴컴');
      GotoXY (22, 8); Write ('b       a! (a-b)!');
      GotoXY ( 8,11); Write ('Masukkan nilai a : ');
      GotoXY ( 8,13); Write ('Masukkan nilai b : ');
      Repeat
         {$I-}
            GotoXY (27,11); ClrEOL; Readln (A);
            GotoXY (27,13); ClrEOL; Readln (B);
         {$I+}
      Until (IOResult=0) And (A>=B) And (B>=0);
      GotoXY ( 8,15); Write ('Hasil Permutasi  : ',Permutasi(A,B):9:2);
      GotoXY (14,16); Write ('Combinasi  : ',Combinasi(A,B):9:2);
      GotoXY (14,19); Write ('Coba Lagi (Y/T) ? ');
      Repeat
         Coba := Upcase (Readkey);
      Until Coba In ['Y','T'];
   Until Coba = 'T';
End;
Begin
   Menu;
End.