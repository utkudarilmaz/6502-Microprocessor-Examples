		.DATA $0300			;Calisilan bellek alani
		.BYTE 01,01			;$0300 Low tarafi, $0301 High tarafi temsil ediyor

		.DATA $20			;HIGH biti hesaplarken kullanilan bellek alanlari ve sayac
		.BYTE $00,$00,22		;$22 adresindeki sayi Fibonacci dizisindeki bulmak istenilen elemanin 2 eksigi yani ($22+2). eleman

		.CODE $0200

		CLC
BASLA		LDY #01				;Arka arakaya olan dizi terimlerini toplamak icin kullanilan sayilar
		LDX #00

ARA		LDA $0300,X			;A'ya kucuk sayi atama yapildi
		ADC $0300,Y			;Kucuk sayidan bir sonraki sayi kucuk sayi ile toplandi
		PHA		    		;Yeni sayiyi yigina attik ki, yeni sayinin tasmasi olup olmadigina bakabilelim
		BCS TASMA			;Eger C bayragi 1 ise TASMA etiketine sapilacak, 0 ise TASYOK etiketine sapilacak
		BCC TASYOK

DEVAM		CLC				;Onceki islemden kalma C bayragi bilgisi temizlendi
		LDA $0300,Y			;Toplamasini yapilan buyuk sayiyi A'ya atip bir sonraki satirla, A'yi kucuk sayi kismina atildi
		STA $0300,X
		PLA		    		;Yigindan toplama islemi sonucunu cekerek bir sonraki satirla buyuk sayi kismina atildi
		STA $0300,Y
		DEC $22				;Bir sonraki sayiyi bulmak icin sayaci bir azalttik
		BEQ SOR				;Eger sayac 0 ise SOR etiketine sapildi
		JMP BASLA			;Sart saglanmadiysa dongunun basina dalindi

TASMA		CLC				;Onceki islemden kalma C bayragini islemlere etki etmemesi icin sifirlandi
		LDX $21				;$21 adresindeki degeri kaybetmemek icin X kaydedicisine atandi
		INC $21				;Bu islemle beraber eger yukarida toplanan sayilarda tasma varsa, HIGH biti bir arttirildi
		LDA $20				;Kucuk sayinin HIGH bitini A'ya atandi
		ADC $21				;Kucuk sayi ile buyuk sayiyinin HIGH bitleri toplandi
		STA $21				;Ve buyuk sayinin HIGH bitine atandi
		TXA					;X kaydedicisi A kaydedicisine aktarildi
		STA $20				;Onceki buyuk sayi, yeni kucuk sayi oldu
		LDX #00				;X kaydedicisini yukaridaki islemlerde kullanmaya devam edebilmek icin eski degerine donduruldu
		JMP DEVAM			;DEVAM etiketine dalindi

TASYOK		LDA $20				;TASMA etiketindeki islemleri HIGH bitini arttirma islemi disinda tekrarlandi
		ADC $21				;Boylece tasma olmasa bile HIGH bitleri de dizi elemanlari ile birlikte toplanabilecek
		LDX $21
		STA $21
		TXA
		STA $20
		LDX #00
		JMP DEVAM


SOR		LDA $0300,Y			;Fibonacci dizisinin elemaninin LOW bitlerini $0301 adresinden $0300 adresine tasindi
		STA $0300,X
		LDA $21				;Elemanlarin HIGH bitleri ise $0301 adresine tasindi
		STA $0300,Y
		BRK
		END
