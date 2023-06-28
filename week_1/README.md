# Odev Akisi

### Odev'in Beklentisi
----
Odev'de yapmamiz gereken sey ciktidaki bakiyelerin basinda para birimini yani, dolar isaretini duzeltmemiz ve ciktiyi JCL ile birlikte bir output dosyasinda tutmamizdir.

## COBOL Tarafi
----
Bu kisimda yapacagimiz islem basit. Bakiyenin ve limitin tutuldugu degiskenlerin basamak sayisini 'Z' ile degil '$' ile belirtmemiz gerekiyor.

Bu islem ile varolan bakiyenin basina sadece '$' koymus oluyoruz.

## JCL Tarafi
----
Bu kisimda standartin disinda ilgilenecegimiz satir PRTLINE satiridir. Ciktinin tutuldugu dosyayi tanimlamamiz ve yoksa olusturmamiz gerekmektedir.

### **Dosyaya Yonledirmek**
----
**DSN=&SYSUID..OUTPUT** - Bu parametre, çıktı dosyasının adını belirler. &SYSUID, kullanıcının kullanıcı kimliği (user ID) değerini temsil eder. "..OUTPUT" ise çıktı dosyasının adının "OUTPUT" olacağını belirtir.

**DISP=(NEW,CATLG,DELETE)** - Bu parametre, çıktı dosyasının nasıl işleneceğini belirler. "NEW" parametresi, dosyanın oluşturulacağını belirtir. "CATLG", dosyanın kataloglanacağını ve "DELETE" parametresi ise işlem tamamlandığında dosyanın silineceğini belirtir.

**UNIT=SYSDA** - Bu parametre, çıktı dosyasının fiziksel cihazını belirler. "SYSDA" parametresi, çıktı dosyasının sistem diski üzerinde olacağını belirtir.

**SPACE=(TRK,(10,10),RLSE)** - Bu parametre, çıktı dosyası için gereken disk alanını belirler. "TRK" parametresi, disk alanının iz takipçisi (track) olarak belirtileceğini gösterir. "(10,10)" parametresi, 10 iz takipçisi başına minimum ve maksimum iz takipçisi sayısını belirtir. "RLSE" parametresi, boş alanları sistem tarafından otomatik olarak serbest bırakılacağını belirtir.

**DCB=(RECFM=FB,LRECL=119,BLKSIZE=0)** - Bu parametre, dosya kontrol bloğunu (DCB) belirler. "RECFM=FB", kaydedilen verilerin sabit uzunlukta kaydedileceğini gösterir. "LRECL=119", kaydedilen her veri kaydının uzunluğu 119 bayt olacak şekilde belirler. "BLKSIZE=0", sistem tarafından en uygun blok boyutunun kullanılacağını belirtir.