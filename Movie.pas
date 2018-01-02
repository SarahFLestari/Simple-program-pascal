Program Movie;
uses crt;
const
	C_FNAME = 'DataFilm.txt';
	RATE_D  = 'D ';
	RATE_R  = 'R ';
	RATE_SU = 'SU ';
type 
	TShow = record
			nama	 : string;
			rate 	 : string;
			harga 	 : longint;
			hargaanak: longint;
			jum_cetak: integer;
	end;
var
	daftarshow 			: array [1..100] of TShow;
	jumlahfilm 			: integer;
	Pilihan,i			: integer;
	fileinput			: TextFile; 
procedure GetDataFromText(var daftar : array of TShow); //Prosedur Mengambil Data Dari Text
var
	text,s 	: string;
	i 		: integer;
	count	: integer;
begin
	Assign(fileinput, C_FNAME);
	reset(fileinput);
	while not eof(fileinput) do
	begin	
		read(fileinput, text);
	end;	
	s 			:= '';
	count 		:= 0;
	jumlahfilm 	:= 1;
	for i := 1 to length(text) do
	begin
		s := s + text[i];		
		if text[i] = ' ' then
		begin
			if count = 0 then
			begin
				daftarshow[jumlahfilm].nama := s;
				count := count + 1;
			end
			else
			begin
				daftarshow[jumlahfilm].rate := s;
				case s of //Memberi harga per-Rate
					RATE_D 	: daftarshow[jumlahfilm].harga 		:= 50000;
					RATE_R	: daftarshow[jumlahfilm].harga 		:= 45000;
				end;
				if s = RATE_SU then
				begin
					daftarshow[jumlahfilm].hargaanak 	:= 20000;
					daftarshow[jumlahfilm].harga 		:= 35000;
				end;				
				count 						:= 0;
				jumlahfilm 					:= jumlahfilm + 1;
			end;
			s := '';
		end;
	end;
end;
procedure pemesanan (var inputfilm: integer );
var
	jumlahdewasa	: integer;
	jumlahanak		: integer;
	Sum 			: integer;
begin
	Write('Silahkan Memilih Film Sesuai Nomor Film : '); 
	readln(inputfilm);
	if inputfilm <> 0 then
	begin
		if daftarshow[inputfilm+(100-jumlahfilm+1)].rate = 'SU ' then
		begin
			Write('Jumlah Tiket Dewasa                     : ');readln(jumlahdewasa);
			Write('Jumlah Tiket Anak ( Anak < 12 Tahun     : ');readln(jumlahanak);
			sum := jumlahdewasa + jumlahanak;
			writeln('-------------------------------------------');
			daftarshow[Pilihan+(100-jumlahfilm+1)].jum_cetak := daftarshow[Pilihan+(100-jumlahfilm+1)].jum_cetak + sum;
			writeln('Title                    : ',daftarshow[Pilihan+(100-jumlahfilm+1)].nama);
			Writeln('Rate                     : ', daftarshow[Pilihan+(100-jumlahfilm+1)].rate);
			Writeln('Jumlah Tiket Untuk Dewasa: ',jumlahdewasa);
			Writeln('Jumlah Tiket Untuk Anak  : ',jumlahanak);
			Writeln('Jumlah Tiket             : ', sum);
			Writeln('Total Bayar              : ', (daftarshow[Pilihan+(100-jumlahfilm+1)].harga * jumlahdewasa) + (daftarshow[Pilihan+(100-jumlahfilm+1)].hargaanak * jumlahanak) );
			Write('Lanjutkan?               : '); readln; 
		end
		else
		begin
			write('Jumlah Tiket                            : ');readln(jumlahdewasa);
			writeln('-------------------------------------------'); 
			daftarshow[Pilihan+(100-jumlahfilm+1)].jum_cetak := daftarshow[Pilihan+(100-jumlahfilm+1)].jum_cetak + jumlahdewasa;
			writeln('Title       : ',daftarshow[Pilihan+(100-jumlahfilm+1)].nama);
			Writeln('Rate        : ', daftarshow[Pilihan+(100-jumlahfilm+1)].rate);
			Writeln('Jumlah Tiket: ', jumlahdewasa);
			Writeln('Total Bayar : ', daftarshow[Pilihan+(100-jumlahfilm+1)].harga * jumlahdewasa);
			Write('Lanjutkan?  : '); readln;
		end;
	end;
end;
procedure sortrate (var daftar : array of TShow); //Sorting data berdasarkan rate nya 
var
	temp : TShow;
	i,j : integer;
begin
	For i := (length(daftar)-1) downto 1 do 
		for j := 1 to i do
			if(daftar[j-1].rate <  daftar[j].rate) then
			begin
				temp		:= daftar[j-1];
				daftar[j-1] := daftar[j];
				daftar[j]	:= temp;
			end;
end;
procedure listpembelian();
begin
for i := 100-jumlahfilm+2 to 100 do
	begin
		writeln(i-(100-jumlahfilm+1) ,'. ', daftarshow[i].nama , daftarshow[i].jum_cetak); //Menampilkan banyaknya film yang dibeli tiketnya
	end;
end; 
procedure getMin(var daftar : array of TShow); //Mencari pencetakan tiket paling sedikit
var
	i,temp : integer;
begin
	temp := daftar[100-jumlahfilm+1].jum_cetak;	
	for i := 100-jumlahfilm+1 to 99 do
	begin		
		if temp > daftar[i].jum_cetak then
			temp := daftar[i].jum_cetak;
	end;	
	for i := 100-jumlahfilm+1 to 99 do
	begin
		if temp = daftar[i].jum_cetak then
			Writeln(daftar[i].nama);
	end;  	
end;
procedure getMax(var daftar : array of TShow); //Mencari pencetakan tiket paling banyak 
var
	i,temp : integer;
begin
	temp := daftar[100-jumlahfilm+1].jum_cetak;
	for i := 100-jumlahfilm+1 to 99 do
	begin
		if temp < daftar[i].jum_cetak then
			temp := daftar[i].jum_cetak;
	end;	
	for i := 100-jumlahfilm+1 to 99 do
	begin
		if temp = daftar[i].jum_cetak then
			Writeln(daftar[i].nama);
	end;  	
end;
begin
	ClrScr;
	//Pemesan Teater Hari H
	GetDataFromText(daftarshow);
	sortrate(daftarshow);
	Repeat 
		ClrScr;
		Writeln('=====Selamat Datang di Smart-06 Teater=====');
		Writeln('===========================================');		
		Writeln('Daftar Film: '); //Menampilkan Menu Film yang sudah di sorting
		for i := 100-jumlahfilm+2 to 100 do
		begin
			writeln(i-(100-jumlahfilm+1) ,'. ', daftarshow[i].nama , daftarshow[i].rate); //Menampilkan posisi film yang sudah disorting yang berada diakhir
		end;
		Writeln('0. Keluar dan Laporan Penjualan');
		writeln('-------------------------------------------');
		writeln('Keterangan Rate: ');
		writeln('D : Dewasa');
		writeln('SU: Semua Umur');
		writeln('R : Remaja');
		Writeln('===========================================');
		Writeln('========== Pemesanan Tiket Teater==========');
		pemesanan(Pilihan); //Memasukkan Pemesanan / Inputan
	until Pilihan = 0; //Pemesanan berakhir 
	Writeln('=======Laporan Penjualan======='); //Laporan Pemesanan
	listpembelian(); //Prosedur List penjualan tiket masing-masing film
	writeln('-------------------------------------------');
	Writeln('Tiket Banyak Terjual: ');
	getMax(daftarshow);
	Writeln('Tiket Sedikit Terjual: '); 
	getMin(daftarshow);
	Writeln('=======Terimakasih Telah Berkunjung=======');
end.