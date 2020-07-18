Program Menghitung;

Uses Crt;

Var
   Lagi : Char;
   R    : LongInt;
   N,I  : Real;

Procedure Menu(Var R : LongInt; Var I,N : Real);
Begin
   Repeat
      {$I-}
         GotoXY (16,7); Write ('Pembayaran anuitas (R) : '); ClrEOL;
         Readln (R);
      {$I+}
   Until (IOResult=0) And (R>0);
   Repeat
      {$I-}
         GotoXY (16,9); Write ('Suku bunga (i)         :     %'); ClrEOL;
         GotoXY (41,9); Readln (I);
      {$I+}
   Until (IOResult=0) And (I>0) And (I<101);
   Repeat
      {$I-}
         GotoXY (16,11); Write ('Banyaknya periode      : '); ClrEOL;
         Readln (N);
      {$I+}
   Until (IOResult=0) And (N>0) And (N<101);
End;

Function Pangkat (N,I : Real) : Real;
Begin
   Pangkat := Exp (N*ln(I));
End;

Procedure Present;
Var Hasil : Real;
Begin
   ClrScr;
   GotoXY (16,4); Write ('Menghitung Present Value');
   GotoXY (16,5); Write ('~~~~~~~~~~~~~~~~~~~~~~~~');
   Menu (R,I,N);
   Hasil := R*((1-(1/(Pangkat(1+(I/100),N))))/(I/100));
   GotoXY (16,13); Write ('Present value          : ',Hasil:6:0);
   Readln;
End;

Procedure Future;
Var Hasil : Real;
Begin
   ClrScr;
   GotoXY (16,4); Write ('Menghitung Future Value');
   GotoXY (16,5); Write ('~~~~~~~~~~~~~~~~~~~~~~~');
   Menu (R,I,N);
   Hasil := R*((Pangkat(1+(I/100),N)-1)/(I/100));
   GotoXY (16,13); Write ('Future value           : ',Hasil:6:0);
   Readln;
End;

Begin
   Repeat
      ClrScr;
      GotoXY (21,3); Write ('Main Menu');
      GotoXY (21,4); Write ('ßßßßßßßßß');
      GotoXY (16,5); Write ('Pembayaran Anuitas');
      GotoXY (16,8); Write ('1. Hitung Present Value.');
      GotoXY (16,10); Write ('2. Hitung Future Value.');
      GotoXY (16,12); Write ('3. Exit.');
      GotoXY (16,14); Write ('Pilihan Anda : [ ]');
      Repeat
         GotoXY (32,14); Lagi := Readkey;
      Until Lagi In ['1'..'3'];
      Case Lagi Of
         '1' : Present;
         '2' : Future;
      End;
   Until Lagi='3';
End.
