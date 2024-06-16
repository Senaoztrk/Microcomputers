
;<Program title>

jmp start

;data


;code 
;okula başlama yılım: 2021 (2021h)
start: nop
;İlk olarak I/O port kısmından sırayla okula giriş yılım (2021h) ve soruda verilen 6789h değerlerini
;sırayla 00h,01h,02h,03h adreslerine output ettim.
 
 
 
 IN 00h; Daha sonra I/O portlardaki değerleri IN komutu ile Accumulatorden input aldım.
 MOV B,A; ve gerekli registerlara kopyaladım.

 IN 01h;
 MOV C,A;

 IN 02h;
 MOV D,A;

 IN 03h;
 MOV E,A;


 

 
 
 MOV A, C; C registerındaki değerimizi Accumulatore kopyaladık ve E registerındaki değerle topladık.
 ADD E          
 DAA ; Daha sonra BCD toplama işlemini gerçekleştirmesi için DAA komutunu kullanıyorum,
;DAA komutu toplama işlemindeki (0-9)aralığının aşılması durumunda işlemi düzeltiyor. (+6 eklemek)           
 MOV E, A ; Elde ettiğim sonucu ise E registerına kopyalıyorum.

 
 MOV A, B; Yukarıda yaptığım işlemi tekrarlıyorum.      
 ADC D; ADD yerine ADC kullanma sebebim, low nibble'dan carry değer gelmesi durumunda bunu da 
; high nibbledaki değere eklemesini istemiş olmam.        
 DAA            
 MOV D, A ; Elde ettiğim sonucu D registerına kopyalıyorum.

; Ben en başta elde ettiğim sonuçları hep M (memory'e) kopyaladım ancak memory table'da bu sefer
; adresler ters şekilde yazdı, ben de size mail aracılığıyla sordum, ardından bu yolu izlemeye karar
; verdim. İşlem sonuçlarını D ve E ya da B ve C registerına kopyalayıp daha sonra memory'e yerleştirmeyi
; deneyince kodumda bir sorun oluşmadı.
 

;Okul numaramın son dört hanesi: 1050
 
 LXI H,1050h; H-L kaydını 1050h adresie yüklüyorum.
 
 MOV A,D; D registerına kopyaladığım toplama sonucunu Accumulatore ardından Memory'e kopyalıyorum.
 MOV M,A;
 

 INX H; Adresi 1 arttırıyorum [H+1]

 MOV A,E; E registerına kopyaladığım toplama sonucunu Accumulatore ardından Memory'e kopyalıyorum.
 MOV M,A;
 
 
 


 




 




 
  

















hlt


