; 152120211050 Senanur Öztürk
;<Program title>

jmp start

;data

data: db 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh, 10h, 11h, 12h, 13h, 14h
; Soruda verilen notları kaydediyoruz.
;code
start: nop

MVI B, 00h       ; Adres işlemleri için B registerını kullandım, araştırmalarımda genelde o registerın
                 ; kullanıldığını öğrendim.
LXI H, data      ;  Öğrenci notlarının bellekte başladığı adresi H-L register çiftine yükledim. Daha sonra
                 ; bu notları M (memoryden) çekip kullanacağım.

IN 00h            ; 00h portundan geçme notunu alıyorum ve bu değeri Accumulatorden
MOV E, A          ; E registerına kopyalıyorum.


MVI A, 01h       ;  İlk notu Accumulatore yüklüyorum. Daha sonra Loop içerisinde sırayla tüm notlara
                 ;  işlemler uyguluyorum.

LOOP: MOV M, A    ; Belleğe notu yerleştiriyorum.
INX H             ; Bir sonraki bellek adresine geçiyorum ve bu sayede bir sonraki nota ve öğrenciye
                  ; erişmiş oluyorum.
INR B             ; Öğrenci sayısını artmış oluyor ben notları kontrol ettikçe.
ADI 01h           ; 
CPI 15h           ; Son notu kontrol et. (14h değil de 15h olmasının sebebi her seferinde bir sonrakini
                  ;kontrol ediyor oluşumuz. 14h'ın son not olup olmadığını öğrenmek için 15h ile 
                  ; karşılaştırmamız gerekir.
JNZ LOOP          ; Eğer son not değilse, döngüyü sürdürüyoruz.


MVI C, 00h       ; Geçen öğrenci sayısını saklamak için C registerını kullandım.
MVI D, 00h       ; Başarısız olan öğrenci sayısını saklamak için D registerını kullandım.
LXI H, data      ; Daha sonra notları bellekten geri yüklüyorum.

CHECKGRADE: MOV A, M    ; Karşılaştırma yapmak için notları memoryden Accumulatore kopyalıyorum.
CMP E              ; E registerında sakladığım geçme notuyla karşılaştırıyorum.
JNC PASSEDEXAM        ; Eğer not, geçme notundan büyükse, PASSED'e gönderiyorum.
INR D             ; Tam tersiyse başarısız olan öğrenci sayısını artırıyorum.
JMP NEXTSTUDENT          ; Bir sonraki öğrenci için işlemi tekrarlıyorum.

PASSEDEXAM: INR C      ; Geçen öğrenci sayısını artırıyorum.

NEXTSTUDENT: INX H         ; Bir sonraki öğrencinin notuna geç

DCR B              ; Geriye kalan öğrenci sayısını azaltıyorum ki daha sonra geçen ile geçmeyen sayılarını
                   ; yazdırabileyim.
JNZ CHECKGRADE     ; Eğer son öğrenci değilse, döngüyü sürdürüyorum. (CHECKGRADE-> MOV A,M)


MOV A, C          ; Geçen öğrenci sayısını Accumulatore yüklüyorm ardından bu sayıyı 01h
OUT 01h           ; portuna yazdırıyorum.
MOV A, D          ; Daha sonra geçemeyen öğrenci sayısını da aynı şekilde Accumulatore yükleyip
OUT 02h           ; bu sefer 02h portuna yazdırıyorum.


MOV A, C          ; Geçen öğrenci sayısını Accumulatore yükleyip D registerındaki
CMP D             ; geçemeyen öğrenci sayısıyla karşılaştırıyorum.
JNC SET_2         ; Eğer geçen öğrenci sayısı, başarısız öğrenci sayısından büyükse, port 03h'yi 2 yapıyorum
MVI A, 01h        ; tam tersi ise 1 yapıyorum.

SET_1: OUT 03h     ; Port 03h'yi 1 yapma kod etiketi
JMP END            ;eğer geçen öğrenci sayısı başarısız öğrenci sayısından büyükse, 
                   ;1 değeri Port 03h'ye yazılır ve ardından program sona erer.            

SET_2: MVI A, 02h  ; MVI A ile 02h komutu A kaydına 2 değerini yüklüyorum. 
                   ;Ardından OUT 03h komutu kullanılarak A kaydındaki değeri, Port 03h'ye yazdırıyorum.
OUT 03h           

END: HLT           ; Programı durduruyorum.


hlt