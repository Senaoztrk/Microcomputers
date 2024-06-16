
;<Program title>

jmp start

;data         2021h:8225->12h;
;code         1050h:4176->34h;
start: nop

LDA 2021h; LDA komutu ile 2021h adresindeki değeri accumulatore (A registerı) yükledim.
;Programlar genellikle bellekten veri okur ve bu veriyi işlemek için accumulatorü kullanır.
;LDA, bir bellek adresinden (2021h) veriyi A registerına yüklediğinde, 
;bu veri üzerinde işlem yapılmasına elverişli hale gelir.
MOV B,A; Accumulatordeki değeri MOV komutuyla B registerına kopyaladım.

LDA 1050h; Yukarıda açıkladığım işlemleri D registerı için de uyguladım.
MOV D,A;

push B; İlk olarak B ve D registerındaki değerleri yedeklemek için stacke push işlemlerini gerçekleştirdim.
push D;
pop B; pop B işlemiyle yığına son push edilen register yani D registerındaki değer B registerına gelmiş oldu.
pop D; pop D işlemi ile ise yığında son kalan değer yani B registerındaki değer D registerına gelmiş oldu.
; böylece B ve D registerındaki değerler swap edilmiş oldu.

MOV A,B; B registerındaki değeri accumulatore (A registerı)kopyalama sebebim 
;OUT komutunun A registerından I/O porta değer gönderebilmesidir.
OUT 00h; ardından accumulatorden soruda verilen 00h adresine değeri outputladım.
MOV A,D; Aynı işlemleri D registerındaki değer için 01h adresine gerçekleştirdim.
OUT 01h;






hlt