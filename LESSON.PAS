    Uses Crt ;
    Const
         NamaData = 'Lesson.txt' ;    {    Nama file tempat untuk
                                        manyimpang Data yang diinput }

    Type
         MhsRec   = record
                      Nim   : String[10] ;
                      Nama  : String[25] ;
                      Kelas : String[04] ;
                      ABS   : real ;
                      TM    : real ;
                      Mid   : real ;
                      Final : real ;
                    End ;             { Struktur record yang akan direkam }

         TypeFile = File of MhsRec ;  { Type yang dibuat untuk File }

    Var
         f        : TypeFile ; { Var utk File Bertype }
         Data     : MhsRec ;   { Var utk menampung input dr Keyboard }
         JumRec   : Integer ;  { Var yg menunjukan banyaknya Record dlm File }


  { ************************************************************************ }
  { Procedure Open_File :                                                    }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                     }
  { Procedure ini bertujuan untuk menghubungkan variabel f dengan            }
  { file yang terdapat pada Const di atas yaitu 'Lesson.txt'.                }
  {                                                                          }
  { Assign( f, NamaData ) :                                                  }
  { - Berarti Menghubungkan f dengan File yang bernama 'Lesson.txt'          }
  { Reset( f )                                                               }
  { - Berarti Membuka File tersebut                                          }
  {                                                                          }
  { Keteranagn : Jika terjadi kesalahan maka nilai IOResult akan lebih       }
  {              besar dari 0, ( Berarti file tidak ada / Error )            }
  {              Maka kita menbuat sebuah file baru dengan nama 'Lesson.txt' }
  {              dengan perintah ReWrite( f ).                               }
  {                                                                          }
  { JumRec := FileSize( f ) ;                                                }
  { - Berarti mengambil berapa banyaknya record yang terdapat pada           }
  {    file yang kita buka tadi.                                             }
  { ************************************************************************ }

    Procedure Open_File ;
    Begin
      Assign( f, NamaData ) ;
      {$I-} Reset( f ) ;{$I+} ;
      If IOResult <> 0 then Rewrite( f ) ;

      JumRec := FileSize( f ) ;
    End ;



  { ************************************************************************ }
  { Procedure Pesan :                                                        }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                        }
  { Procedure ini Hanya menampilkan pesan pesan Kesalahan saja.              }
  { ************************************************************************ }

    Procedure Pesan ;
    Begin
      gotoxy( 22,24 ); write('Maaf Record ini tidak ada dalam File' ) ;
      ReadKey ;
      gotoxy( 22,24 );ClrEol ;
    End ;



  { ************************************************************************ }
  { Procedure Tanya :                                                        }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                        }
  { Procedure ini dijalankan Bertujuan untuk mendapatkan jawaban dari user   }
  { sewaktu ingin mengambil keputusan pada program.                          }
  {                                                                          }
  { - Disini Parameter Var Answer akan membalikan nilai                      }
  {   antara 'Y' atau 'T' saja.                                              }
  { ************************************************************************ }

    Procedure Tanya( x, y : Byte; Var Answer : Char ; Kalimat : String ) ;
    Begin
      Repeat
        gotoxy( x,y ); write( Kalimat ) ;
        Answer := UpCase( ReadKey ) ;
      until Answer in [ 'Y', 'T' ] ;
      gotoxy( x,y ); ClrEol ;
    End ;



    Procedure Keterangan ;
    Begin
      gotoxy( 05,05 ); write('Nim         : ') ;ClrEol ;
      gotoxy( 05,06 ); write('Nama        : ') ;ClrEol ;
      gotoxy( 05,07 ); write('Kelas       : ') ;ClrEol ;
      gotoxy( 05,08 ); write('ABS         : ') ;ClrEol ;
      gotoxy( 05,09 ); write('TM          : ') ;ClrEol ;
      gotoxy( 05,10 ); write('Mid         : ') ;ClrEol ;
      gotoxy( 05,11 ); write('Final       : ') ;ClrEol ;
    End ;



  { ************************************************************************ }
  { Procedure Keterangan :                                                   }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                   }
  { Procedure ini bertujuan untuk mendapatkan input dari Keyboard            }
  { Keterangan Proses : Pada pemanggil Procedure ini, ia mengirimkan         }
  {                     parameter dan ditampung ke variabel Data,            }
  {                     Setelah itu baru melakukan pemasukan nilai.          }
  {                                                                          }
  {                     Seandainya kita tekan ENTER pada waktu memasukkan    }
  {                     Nim maka nim it akan sama dengan '' ( Nim := '' ).   }
  {                                                                          }
  {                     Jika Nim tidak sama dengan '' ( Nim <> '' )          }
  {                     Maka kita melakukan pemasukan nilai nilai Lainnya .  }
  {                     ( Nama, Kelas, ABS, TM Mid, Final )                  }
  { ************************************************************************ }

    Procedure Baca( Var Data : MhsRec ) ;
    Begin
      gotoxy( 19,05 ); ReadLn( Data.Nim ) ;
      If Data.Nim <> '' then
      Begin
        gotoxy( 19,06 ); ReadLn( Data.Nama ) ;
        gotoxy( 19,07 ); ReadLn( Data.Kelas ) ;
        gotoxy( 19,08 ); ReadLn( Data.ABS ) ;
        gotoxy( 19,09 ); ReadLn( Data.TM ) ;
        gotoxy( 19,10 ); ReadLn( Data.Mid ) ;
        gotoxy( 19,11 ); ReadLn( Data.Final ) ;
      End ;
    End ;



  { ************************************************************************ }
  { Procedure Tambah_Data :                                                  }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                  }
  { Penjelasan Logika :                                                      }
  { 1. Manhapus Layar.                                                       }
  {     * ClrScr                                                             }
  {                                                                          }
  { 2. Menampilkan Judul Procedure                                           }
  {     * gotoxy( 05, 02 ); write('Procedure Menabah Data') ;                }
  {     * gotoxy( 05, 03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;                }
  {                                                                          }
  { 3. Memanggil Procedure Keterangan.                                       }
  {                                                                          }
  { 4. Memanggil Procedure Baca( Temp )                                      }
  {     * Parameter Temp ini bersifat lokal.                                 }
  {     * Temp ini dikirim untuk mendapatkan nilai-nilai dari Keyboard.      }
  {                                                                          }
  { 5. If Temp.Nim <> '' ( Apakah Temp.nim = '' ) - ( '' = Enter )           }
  {     * Jika bukan Enter maka Proses dilanjutkan.                          }
  {       setelah itu kita memanggil Procedure Tanya untuk mendapatkan       }
  {       'Y' atau 'T'.                                                      }
  {       Jika variabel Save itu = 'Y' maka apa yang ada di dalam variabel   }
  {       Temp itu kita simpan kedalam file dengan cara :                    }
  {            a. Open_File          - Buka file.                            }
  {            b. Seek ( f, JumRec ) - mencari posisi di akhir File.         }
  {            c. write(  f, Temp  ) - menulis ke dalam File                 }
  {            d. Close( f )         - Tutup kembali File tsb.               }
  {            e Kembali ke langkah 3.                                       }
  {                                                                          }
  {     * seandainya Temp.nim sama dengan '' maka langsung keluar dari       }
  {       procedure Tambah data ini.                                         }
  { ************************************************************************ }

    Procedure Tambah_Data ;
    Var Save : Char ;
        Temp : MhsRec ;
    Begin
      ClrScr ;
      gotoxy( 05, 02 ); write('Procedure Menabah Data') ;
      gotoxy( 05, 03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;

      Repeat
        Keterangan ;
        Baca( Temp ) ;
        If Temp.Nim <> '' then
        Begin
          Tanya( 05, 13, Save, 'Apakah data akan disimpan (Y/T) : ') ;

          If Save = 'Y' then
          Begin
            Open_File ;
            Seek( f, JumRec ) ;
            Write( f, Temp ) ;
            Close( f ) ;
          End ;
        End ;
      Until Temp.Nim = '' ;
    End ;



    Procedure Proses_Sort ;
    Var P, K          : Integer ;
        Data1, Data2  : MhsRec ;
    Begin
      Open_File ;
      For P := 0 to JumRec - 2 do
      Begin Seek( f, P ); Read( f, Data1 ) ;

            For K := P + 1 to JumRec - 1 do
            Begin Seek( f, K ); Read( f, Data2 ) ;
                  If Data2.Nim < Data1.Nim then
                  Begin Seek( f, P ); write( f, Data2 );
                        Seek( f, K ); write( f, Data1 );
                  End ;
            End ;

      End ;

      Close( f ) ;
    End ;



    Procedure Proses_Hitung(     Data  : MhsRec ;
                             Var Nilai : real ;
                             Var Grade : Char ) ;
    Begin
      Nilai := ( (Data.ABS  * 10) + (Data.TM   * 10) +
                 (Data.Mid  * 30) + (Data.Final* 50) ) / 100 ;

      Case Round( Nilai ) of
           00..54  : Grade := 'E' ;
           55..64  : Grade := 'D' ;
           65..74  : Grade := 'C' ;
           75..84  : Grade := 'B' ;
           85..100 : Grade := 'A' ;
      End ;
    End ;



  { ************************************************************************ }
  { Procedure Cetak_laporan :                                                }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                }
  { Penjelasan Logika :                                                      }
  {                                                                          }
  { 1. Cetak Header laporan.                                                 }
  { 2. Variabel Nomor dinolkan karena pada file posisi 0 adalah menuju ke    }
  {    record yang pertama.                                                  }
  {    Keterangan : Pada File Posisi 0 adalah record 1                       }
  {                                  1 adalah record 2                       }
  {                                  2 adalah record 3 ... dst               }
  {                 Karena kita ingin menampilkan semua isi dalam file       }
  {                 maka kita akan menapilkan recordnya satu per satu        }
  {                 mulai dari awal jadi Nomor := 0 berarti                  }
  {                 Nomor = record 1, dan setelah itu nomor jangan lupa      }
  {                 ditambahkan terus hingga EOF( f ).                       }
  {                                                                          }
  { 3. Sebelum menampilkan isi dari file terlebih dahulu kita melakukan      }
  {    proses pengurutan data dalam file.                                    }
  {    - Mamanggil Procedure Sort_Proses                                     }
  {                                                                          }
  { 4. Seek( f, Nomor )                                                      }
  {    Berarti menuju ke posisi yang ditunjukan Nomor pada file yang kita    }
  {            buka tadi ( Ingat...!  f mewakili 'Lesson,txt' ).             }
  {                                                                          }
  { 5. Setelah Perintah Seek Sukses maka kita akan Melakukan pembacaan       }
  {    file ke dalam variabel Data tsb dengan Perintah Resd( f, Data ) ;     }
  {                                                                          }
  { 6. Lalu Setelah Baca maka kita akan mencetak apa yang dibaca itu ke      }
  {    layar / Printer dengan Perintah Write / WriteLn.                      }
  {    Ingat : Pada 'write' dilakukan maka pada layar / Printer              }
  {            tidak akan melakukan pemindahan baris.                        }
  {            Sedangkan 'WriteLn' dilakukan maka pada Layar /               }
  {            Printer akan melakukan pemindahan 1 Baris.                    }
  {                                                                          }
  {                                                                          }
  { 7. Setelah cetak satu Baris maka Periksalah apakah sudah EOF( f )        }
  {    Jika belum maka kembali ke Proses 4,                                  }
  {    dan Jika sudah maka jalankan Proses No 8.                             }
  {                                                                          }
  { 8. Close( f )                                                            }
  {    Cetak garis tutup.                                                    }
  {    Readkey - Tujuan dari Readkey adalah agar kita dapat membaca          }
  {              apa yang ditampilkan di monitor.                            }
  {              Jika Langsung cetak Keprinter maka Readkey ini tdk          }
  {              perlu lagi.                                                 }
  { ************************************************************************ }

    Procedure Cetak_laporan ;
    Var Nomor : Integer ;
        Nilai : real ;
        Grade : Char ;
    Begin
      ClrScr ;
      WriteLn('                      Laporan Mahasiswa Binus') ;
      WriteLn('                      ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ') ;
      WriteLn(' No.  Nim         Nama                       Kelas  Nilai  Grade') ;
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ') ;
      Nomor := 0 ;
      Proses_Sort ;
      Open_File ;
      While not EOF( f ) do
      Begin
        Seek( f, Nomor ) ;
        Read( f, Data ) ;
        Proses_Hitung( Data, Nilai, Grade ) ;
        Inc ( Nomor ) ;
        write  ( ' ',Nomor:3 ) ;
        write  ( ' ':02,Data.Nim ) ;
        write  ( ' ':12-Length(Data.Nim), Data.Nama ) ;
        write  ( ' ':27-Length(Data.Nama), Data.Kelas ) ;
        write  ( ' ':07-Length(Data.Kelas),Nilai:5:1) ;
        writeLn( ' ':04,Grade ) ;
      End ;
      Close( f ) ;
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ') ;
      ReadKey ;
    End ;



  { ************************************************************************ }
  { Procedure Tampil_Data :                                                  }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                  }
  { Pada Procedure ini kita hanya bertujuan menampilkkan 1 record ke layar   }
  { Mengapa kita membuat procedure ini ?                                     }
  { - Karena Procedure ini bisa dipanggil oleh Procedure Hapus dan Ubah Data }
  { ************************************************************************ }

    Procedure Tampil_Data( Temp : MhsRec ) ;
    Begin
      Keterangan ;
      gotoxy( 19,05 ); write( Data.Nim ) ;
      gotoxy( 19,06 ); write( Data.Nama ) ;
      gotoxy( 19,07 ); write( Data.Kelas ) ;
      gotoxy( 19,08 ); write( Round(Data.ABS) ) ;
      gotoxy( 19,09 ); write( Round(Data.TM) ) ;
      gotoxy( 19,10 ); write( Round(Data.Mid) ) ;
      gotoxy( 19,11 ); write( Round(Data.Final) ) ;
    End ;



  { ************************************************************************ }
  { Procedure Cari_data :                                                    }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                    }
  { Tujuan dari Procedure ini adalah ingin mengetahui apakah Nim yang        }
  { di input ini ada / tidak dalam file 'Lesson.txt'                         }
  { Penjelasan Logika :                                                      }
  { 1. Parameter masukkan adalah                                             }
  {    a. Ketemu - supaya memberi tahukan kpd pemanggil                      }
  {                apakah Nim-nya ada / tidak ada.                           }
  {    b. Nomor  - Memberi tahukan kpd pemanggil posisi                      }
  {                record yang dicari.                                       }
  {    c. Temp   - membalikan hasil cari tsb                                 }
  {                ( seperti Nim, Nama, Kelas, ABS, TM, Mid, Final )         }
  {    d. Nim_S  - Sebagai Pembandingan antara yang di dalam file            }
  {                dengan yang di input.                                     }
  {                                                                          }
  { 2. a. Pertamam - tama Kita anggap belum ketemu, maka                     }
  {       variabek ketemu di beri nilai Ketemu := False.                     }
  {    b. Nomor juga diberikan nilai 0 supaya ia menuju ke posisi 1.         }
  {    c. Open_File.                                                         }
  {                                                                          }
  { 3. Melakukan Penggulangan Sampai Ketemu atau sudah EOF( f ).             }
  {    Proses :                                                              }
  {                                                                          }
  {       If Not EOF( f ) and Not Ketemu                                     }
  {       ( Jika file belum habis dan belum Ketemu ) maka lakukan            }
  {                                                                          }
  {       ÚÄÄ                                                                }
  {       ³                                                                  }
  {       ³  Seek( f, Nomor ) - menuju ke posisi Nomor.                      }
  {       ³  Read( f, Temp  ) - Baca file dan simpan ke Data.                }
  {       ³  Jika Nim_S = Data.Nim maka Ketemu diberikan nilai True          }
  {       ³       maka proses penggulangan selesai                           }
  {       ³  dan jika belum maka nomor ditambah 1 dan lakukan                }
  {       ³      seek lagi                                                   }
  {       ³      read lagi dan Perbandingan lagi......dst                    }
  {       ³      ( sampai EOF / Ketemu = True )                              }
  {       ³                                                                  }
  {       ÀÄ                                                                 }
  { 5. Setelah Selesai Pencarian maka Close( f ) dan                         }
  {    Nilai Temp, Ketemu, dan Nomor akan Secara automatis kirim kembali     }
  {    kepada pemanggil.                                                     }
  {    Procedure Cari_Data Selesai Proses.                                   }
  { ************************************************************************ }

    Procedure Cari_Data( Var Ketemu  : Boolean ;
                         Var Nomor   : Integer ;
                         Var Temp    : MhsRec ;
                             Nim_S   : String ) ;
    Begin
      Ketemu := False ;
      Nomor  := 0 ;
      Open_File ;
      While not EOF( f ) and Not Ketemu do
      Begin Seek( f, Nomor ) ; Read( f ,Temp ) ;
            If Temp.Nim = Nim_S then Ketemu := True
            Else Inc ( Nomor ) ;
      End ;
      Close( f ) ;
    End ;



  { ************************************************************************ }
  { Procedure Merubah_Data :                                                 }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                 }
  { Pada Procedure Merubah data ini sebenarnya Hampir sama dengan Procedure  }
  { Tambah Data cuma Bedanya adalah Kita harus tahu apakah data yang akan    }
  { kita ubah itu ada / tidak ada di dalam File 'Lesson.txt'.                }
  { Penjelasan Logika :                                                      }
  { 1. Manhapus Layar.                                                       }
  {     * ClrScr                                                             }
  {                                                                          }
  { 2. Menampilkan Judul Procedure                                           }
  {     * gotoxy( 05, 02 ); write('Procedure Menabah Data') ;                }
  {     * gotoxy( 05, 03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;                }
  {                                                                          }
  { 3. Mengisi Temp.Nim sebagai variabel pembandingan                        }
  {                                                                          }
  { 4. Memanggil Procedure Cari_Data( Ada, Nomor, Data, Data.Nim )           }
  {                                                                          }
  { 5. Setelah Mendapatkan Nilai Balik dari Procedure Cari_Data              }
  {    Maka Kita Melakukan Periksaan apakah data itu ada dalam file          }
  {                                                                          }
  {    Jika  Variabel Ada := True maka                                       }
  {    kita tampilkan data tersebut yang diterima oleh variabel "data" tsb   }
  {    dan menanya apakah akan melakukan proses perubahan.                   }
  {    Seandainya Variabel Ubah = 'Y' maka Kita Panggil                      }
  {    Procedure Baca( Data ) dan proses selanjutnya seperti Procedure       }
  {    Tambah Data.                                                          }
  {    dan Jika ada := False maka kita tampilkan Pesan.                      }
  { 6. Proses Ubah Selesai dan Kembali Ke Procedure Proses_Utama             }
  { ************************************************************************ }

    Procedure Merubah_Data ;
    Var Save     : Char ;
        Ada      : Boolean ;
        Nomor    : Integer ;
        Ubah     : Char ;
    Begin
      ClrScr ;
      gotoxy( 05,02 ); write('Procedure Merubah Data') ;
      gotoxy( 05,03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;
      gotoxy( 05,05 ); write('Nim         : ') ;ReadLn( Data.Nim ) ;
      If Data.Nim <> '' then
      Begin Cari_Data( Ada, Nomor, Data, Data.Nim ) ;
            If Ada then
            Begin Tampil_Data( Data ) ;
                  Tanya( 05, 13, Ubah, 'Apakah Data ini Akan di Ubah (Y/T) : ') ;
                  If Ubah = 'Y' then
                  Begin
                    Keterangan ;
                    Baca( Data ) ;
                    Tanya( 05, 13, Save,'Apakah Data ini Akan disimpan (Y/T) : ') ;
                    If Save = 'Y' then
                    Begin Open_File ;
                          Seek( f, Nomor ) ;
                          Write( f, Data ) ;
                          Close( f ) ;
                    End ;
                  End ;
            End
            Else Pesan ;
      End ;
    End ;



  { ************************************************************************ }
  { Procedure Hapus_Proses :                                                 }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                 }
  { Pada Procedure ini ia sendiri menerima parameter masukkan berupa         }
  { nomor yang akan di hapus.                                                }
  {                                                                          }
  { Penjelasan Logika :                                                      }
  { 1. Posisi record pada File di Nolkan ( Menuju ke Posisi Pertama file )   }
  {                                                                          }
  { 2. Memanggil Procedure Open_File.                                        }
  {                                                                          }
  { 3. Assign ( f_Bantu, 'Temp.$$$' )                                        }
  {    Rewrite( f_Bantu )                                                    }
  {                                                                          }
  {    Tujuan :                                                              }
  {    Perintah diatas Berarti Bahwa Kita Meminta sebuah file bantu          }
  {    untuk menampung isi-isi dari file Lesson.txt yang dianggap            }
  {    masih tetap akan ada di dalam File.                                   }
  {                                                                          }
  { 4. Baca File Utama( Lesson.txt ) sampai Habis.                           }
  {    Jika Nomor_Ke sama dengan Posisi maka Record tsb jangan pindahkan     }
  {    ke file Bantu tsb( 'Temp.$$$' ) dan Jika Tidak sama, maka record      }
  {    yang kita baca tsb Pindahkan ke File Temp.$$$ itu.                    }
  {                                                                          }
  {    Ingat : Jangan lupa tambahkan 1 ke dalam Variabel 'Posisi'            }
  {            karena Posisi ini yang mengatur pemindahan                    }
  {            arah pembacaan ke record berikutnya.                          }
  {                                                                          }
  {    Keterangan : File Utama = Lesson.txt                                  }
  {                 File Bantu = Temp.$$$                                    }
  {                                                                          }
  { 5. Pada Perintah Seek( f, Posisi )                                       }
  {                  Read( f, Data )                                         }
  {         berarti  Baca file Utama ke dalam variabel Data                  }
  {                                                                          }
  {    Bandingkan Posisi dengan Nomor_Ke dan Jika sama lewatkan saja         }
  {    dan Jika Berbeda maka Tulis ke File bantu dengan Perintah             }
  {    Write( f_bantu, Data ).                                               }
  {                                                                          }
  {    Setelah write posisi yang akan ditulis secara automatis akan          }
  {    tambah satu atau dengan kata lain Posisi pada File                    }
  {    Bantu akan selalu di paling akhir.                                    }
  {                                                                          }
  { 6. Setelah Pemindahan selesai, lakukan CLose( f ) dan Close( f_Bantu )   }
  {    Hapus file Utama dengan Perintah - Erase( f ) - Lesson.txt            }
  {    Ganti Nama File bantu dari Temp.$$$ manjadi Lesson.txt                }
  {    dengan perintah Rename( f_Bantu, 'Lesson.txt' )                       }
  {                    atau                                                  }
  {                    Rename( f_Bantu, NamaData ).                          }
  {                                                                          }
  { 7. Setelah itu kembali ke Procedure Hapus_Data.                          }
  { ************************************************************************ }

    Procedure Hapus_Proses( Nomor_Ke : Integer ) ;
    Var f_Bantu : TypeFile ;
        Posisi  : Integer ;
    Begin
      Posisi := 0 ;
      Open_File ;
      Assign( f_Bantu, 'Temp.$$$' ) ;
      ReWrite( f_bantu ) ;
      While not EOF( f ) do
      Begin Seek( f, Posisi ) ;
            Read( f, Data ) ;
            If Posisi <> Nomor_Ke then Write( f_Bantu, Data ) ;
            Inc( Posisi ) ;
      End ;
      Close( f ) ;
      Close( f_Bantu ) ;
      Erase( f ) ;
      ReName( f_Bantu, NamaData ) ;
    End ;



  { ************************************************************************ }
  { Procedure Menhapus_Data :                                                }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                                }
  {  Procedure ini Logikanya Hampir sama dengan Procedure Merubah_Data       }
  {  dan Parameter parameter - nya juga sama.                                }
  {  Yang Beda cuma Hapus_Proses pada procedure ini saja                     }
  {  Penjelas Logika :                                                       }
  {  1. Kita Harus Memasukkan Nis pembanding dari Keyboard                   }
  {     dan setelah itu memanggil Procedure Cari_Data.                       }
  {  2. Setelah Mendapatkan Nilai Balik dari Procedure Cari_Data             }
  {     ( eg : Ada, Temp, Nomor )                                            }
  {                                                                          }
  {   ÚÄMaka Kita Membandingkan Nilai Ada dengan True                        }
  {   ³ Jika sama maka Kita tanyakan apakah Data ini Akan dihapus            }
  {   ³ dan Jika Hapus = 'Y' Maka Kita memanggil Procedure                   }
  {   ³ Hapus_Proses( Nomor ).                                               }
  {   ³ Ingat : Nomor yang dikirimkan ke Procedure Hapus_Proses adalah       }
  {   ³         bertujuan untuk mengetahui posisi berapa yang akan dihapus.  }
  {   ³                                                                      }
  {   À Seandainya tidak sama , maka Tampilkan Pesan Bahwa Nim ini tidak     }
  {     ada dalam File.                                                      }
  {  3. Proses Hapus_Data Selesai dan Kembali ke Procedure Proses_Utama.     }
  { ************************************************************************ }

    Procedure Hapus_Data ;
    Var Hapus    : Char ;
        Ada      : Boolean ;
        Nomor    : Integer ;
    Begin
      ClrScr ;
      gotoxy( 05,02 ); write('Procedure Merubah Data') ;
      gotoxy( 05,03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;
      gotoxy( 05,05 ); write('Nim         : ') ;ReadLn( Data.Nim ) ;
      If Data.Nim <> '' then
      Begin
            Cari_Data( Ada, Nomor, Data, Data.Nim ) ;
            If Ada then
            Begin Tampil_Data( Data ) ;
                  Tanya( 05,13,Hapus,'Apakah Data ini Akan diHapus (Y/T) : ') ;
                  If Hapus = 'Y' then Hapus_Proses( Nomor ) ;
            End
            Else Pesan ;
      End ;
    End ;



    Procedure Proses_Utama ;
    Var Choice : Char ;
    Begin
      Repeat
        ClrScr ;
        gotoxy( 05,02 ); write('     MENU UTAMA    ') ;
        gotoxy( 05,03 ); write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ') ;
        gotoxy( 05,05 ); write('1. Menambah Data   ') ;
        gotoxy( 05,06 ); write('2. Merubah Data    ') ;
        gotoxy( 05,07 ); write('3. Menghapus Data  ') ;
        gotoxy( 05,08 ); write('4. Mencetak Data   ') ;
        gotoxy( 05,09 ); write('5. Selesai         ') ;
        Repeat
          gotoxy( 05,11 ); write('Pilihan Anda (1..5) : ') ;
          Choice := UpCase( ReadKey ) ;
        Until Choice in [ '1'..'5' ] ;
        Case Choice of
             '1' : Tambah_data ;
             '2' : Merubah_Data ;
             '3' : Hapus_Data ;
             '4' : Cetak_Laporan ;
        End ;
      Until Choice = '5' ;
    End ;



    Begin
      Proses_Utama ;
    End .
