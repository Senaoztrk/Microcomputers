;Senanur Öztürk 152120211050
;<Program title>

jmp start

;data
;A: Genel amaçlı register.
;B: Geçici depolama için kullanılan register.
;C: Üs değerini tutan register.
;D: Çarpma işleminin sonucunu tutan register.
;E: Üs-taban değerini azaltmak için kullanılan geçici register.
;code
start: nop
 
IN 01H; 01h portunda bulunan taban değerini input alıyorum.
RLC; (Rotate accumulator left)komutu sayıyı sola doğru bir pozisyon kaydırır 
;ve bu, sayıyı ikiyle çarpmak anlamına gelir.
MOV B, A; RLC komutu çıkan değeri B registerına kopyalıyorum.
IN 00h; 00h portunda bulunan üs değerini input alıyorum.
RRC; (Rotate Right through Carry) komutu sayıyı sağa doğru bir pozisyon kaydırır ve 
;en sağdaki biti en sola taşır. 
;Bu işlem, sayıyı ikiye bölmek ve taşıma bayrağını kullanmak suretiyle gerçekleşir.
MVI D, 01; D registerında çarpma işlemi sonuçlarını toplayacağım için. (4+4+4+4)+... şeklinde
MOV C, A; üs değerini C registerına taşıyorum.
MVI A, 00; Accumulatoru sıfırlıyorum.
CMP C; C registerınını kontrol ediyorum.

;Zero bayrağı, çeşitli işlemlerin sonuçlarını değerlendirmek için kullanılan bir bayraktır 
;ve bir işlem sonucu sıfır ise bu bayrak set (1), yani 1 değerindedir.

POW:  JZ OP; Eğer Z (Zero) bayrağı set (1) ise,E register'ı sıfıra eşitse, OP etiketine atlar. Bu durumda, üs olarak alınacak sayı sıfır olduğu 
;için herhangi bir üs alma işlemine gerek kalmaz ve program OP etiketindeki komutlara geçer.
      MVI A, 00; Her işlem için accumulatoru temizliyorum.
      MOV E, B; B registerındaki değeri E'ye kopyalıyorum, E burada her adımda azaltacağım tabanı temsil ediyor.
      CMP E; E register'ının sıfır olup olmadığını kontrol ediyorum. 
;Eğer sıfırsa, yani taban değeri 0 ise, POWE etiketine atlıyorum.
      
      MUL: JZ POWE; yani çarpma işlemi sonucu elde edilen değer sıfırsa, POWE etiketine atlar. 
;Bu durumda, çarpma işlemi sona ermiş demektir.
           ADD D; Çarpma işleminde elde ettiğim değeri bir önceki adımla topluyorum.
           DCR E; Üs değerini azaltıyorum.
           JMP MUL; Çarpma işlemini tekrarlıyorum.
;MUL etiketinde aslında örneğin 4üssü3 için 4*1 şeklinde 4'den 1'e kadar kendiyle topluyorum (4+4+4+4)

POWE: MOV D, A; Çarpma işleminin sonlandığı etikettir. E sıfır olduğunds POWE etiketine atlanır.
      DCR C; Bir sonraki üs alma işlemi için C registerındaki değeri azaltıyorum.
      JMP POW
;POWE etiketinde ise (4+4+4+4) işlemlerini üs değeri 0 olana kadar topluyorum.
;(4+4+4+4)+(4+4+4+4)+(4+4+4+4)+(4+4+4+4)

OP:   MOV A, D; Bu etiket aslında üs işleminin sonlandığı etiket.
      OUT 02H; Sonucu 02h portuna yazdırıyorum.
      HLT;

hlt