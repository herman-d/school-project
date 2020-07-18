{Nama    : Heri
 2 PCA  0102940297}

Program Pascal;
Uses Crt,printer;
Const Max = 3;
Type Rpegawai = record
        Nama   : string[15];
        Bagian : string[15];
        Case status : (Tetap, Parttime, Harian) of
            Tetap   : (Gaji_Pokok, Tunjangan : Real);
            Parttime: (Gaji_Per_jam, Jml_jam_kerja, Min_jam_kerja : real);
            Harian  : (Upah_per_hari, Jml_hari_kerja  : real);
        end;
    Tpegawai = Array[1..Max] of RPegawai;
Var Data     : Tpegawai;
    Jml_data : Byte;

Procedure Input;
Var jawab  : char;
begin
   If (jml_data >= 3) then exit;
   Repeat
      Inc(Jml_data);
      Clrscr;
      Gotoxy( 2, 2);write('Nama   :');
      gotoxy( 2, 3);write('Bagian :');
      gotoxy( 2, 4);write('status :   ([T]Tetap,[P]Parttime,[H]Harian) ');
      gotoxy( 2,34);
      with Data[jml_data] do
      begin
         gotoxy(11, 2);readln(nama);
         if (Nama <>'') then
         begin
           gotoxy(11, 3);readln(bagian);
           repeat
              gotoxy(11, 4);jawab := upcase(readkey);
           until jawab in ['T','P','H'];
           gotoxy(11, 4);write(jawab);
           Case Jawab of
           'T' : begin
                    status := tetap;
                    gotoxy( 2, 5);write('Gaji Pokok   :');
                    gotoxy( 2, 6);write('Tunjangan    :');
                    gotoxy(16, 5);readln(gaji_pokok);
                    gotoxy(16, 6);readln(tunjangan);
                 end;
           'P' : begin
                     Status := Parttime;
                     gotoxy( 2, 5);write('Gaji Perjam       :');
                     gotoxy( 2, 6);write('Jumlah jam kerja  :');
                     gotoxy( 2, 7);write('Minimum jam kerja :');
                     gotoxy(22, 5);readln(gaji_per_jam);
                     gotoxy(22, 6);readln(jml_jam_kerja);
                     gotoxy(22, 7);readln(min_jam_kerja);
                 end;
           'H' : begin
                     status := harian;
                     gotoxy( 2, 5);write('Upah Perhari      :');
                     gotoxy( 2, 6);write('Jumlah hari kerja :');
                     gotoxy(23, 5);readln(Upah_per_hari);
                     gotoxy(23, 6);readln(jml_jam_kerja);
                 end;
             end;
             end;
             end;
   Until ((data[jml_data].nama ='') or (jml_data >= 3));
   If (data[jml_data].Nama ='') then
   Dec(Jml_data);
end;

Procedure Cetak;
Var  I : Byte;
     total_gaji, tolsel : real;
begin
    if(jml_data = 0) then  exit;
    write(lst,#15);
    writeln(lst,'PT Manis Asem Asing');
    writeln(lst,'Jalan Rame Rasanya');
    writeln(lst,'Jakarta');
    writeln(lst);
    writeln(lst,'':19,'LAPORAN PEMBAYARAN GAJI');
    writeln(lst,'':19,'_______________________');
    writeln(lst,'':19,' Bulan   :  Juni  1995');
    writeln(lst);
    for I := 1 to 61 do
    write(lst,'_');
    writeln(lst);
    writeln(lst,'Nama         Bagian       Status Pekerja     Total Gaji');
    for I := 1 to 61 do
    writeln(lst,'_');
    writeln(lst);
    tolsel := 0;
    for I := 1 to jml_data do
    begin
       with data[I] do
       begin
          write(lst,Nama,'':16-length(nama));
          write(lst,Bagian,'':16-length(bagian));
          case status of
          Tetap : begin
                    write(lst,'  Tetap     Rp.');
                    total_gaji :=  gaji_pokok + tunjangan;
                    writeln(lst,Total_Gaji :9:0);
                  end;
          Parttime : begin
                        write(lst,'    Parttime  Rp.');
                        if (jml_jam_kerja <= min_jam_kerja) then
                        Total_gaji := jml_jam_kerja * gaji_per_jam
                        else
                          Total_gaji := ((jml_jam_kerja - Min_jam_kerja)*1.2*
                          gaji_per_jam + min_jam_kerja * gaji_per_jam);
                          writeln(lst,total_gaji:9:0);
                     end;
          harian : begin
                      writeln(lst,'   Harian  Rp.');
                      total_gaji := upah_per_hari * jml_jam_kerja;
                      writeln(lst,total_gaji:9:0);
                   end;
                   end;
                   tolsel := tolsel + total_gaji;
       end;
    end;
       for I := 1 to 61 do
       writeln(lst);
       writeln(lst,'Total gaji yang harus dibayar','':23,'Rp','Tolsel:10:0');readln;

end;


Procedure Menu;
Var Pilih : Char;
Begin
  Repeat
    Clrscr;
    GotoXY(2,2); Write('[1] Input Data');
    GotoXY(2,3); Write('[2] Cetak Laporan');
    GotoXY(2,4); Write('[3] Selesai');
    GotoXY(2,6); Write('Pilihan Anda : [_]');
    Repeat
      GotoXY(18,6); Pilih := Readkey;
    Until (Pilih in ['1'..'3']);
    Case Pilih of
      '1' : Input;
      '2' : Cetak;
    End;
  Until (Pilih = '3');
End;

Begin
  Jml_Data := 0;
  Menu;
  readln;
End.