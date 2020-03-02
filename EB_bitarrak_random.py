import random

def getOkerrak(zuzena):
    oker1 = random.randint(2,31)  #Erantzun oker bat hartu posible guztien artetik
    oker2 = random.randint(2,31)  #Erantzun oker bat hartu posible guztien artetik
    while oker1 == zuzena: oker1 = random.randint(0,31) #Ziurtatu zuzena ez dela oker bezala sartzen
    while oker2 == zuzena or oker1 == oker2: oker2 = random.randint(2,31) #Ziurtatu zuzena eta lehen okerra ez direla bigarren oker bezala sartzen
    return oker1, oker2

#Elementua eta erantzun posible guztiak pasata, lortu honi buruzko galdera bat
def getGaldera(n):
    mota='bitarrak' #Galdera mota
    iturria='https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar' #Galderaren jatorria edo iturria
    galdera="Zein da {:05b} zenbaki bitarraren baliokidea?".format(n) #Testuzko galdera
    irudia = '' #  adibide batzuk bitarren argazkia?
    zuzena = n 
    link = "https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar"
    oker1, oker2 = getOkerrak(n)
    galdera_osoa = "%s;%s;%s;%s;%s;%s;%s;%s;%s" % (mota,galdera,irudia,zuzena,oker1,oker2,iturria,link,'') #galdera osatu csv formaturako prestatuz
    print(oker1, oker2)
    return galdera_osoa

def generateGalderak(zenbat, irteera):
    f = open(irteera, 'w')
    f.write("%s;%s;%s;%s;%s;%s;%s;%s;%s;%s" % ('Mota','Galdera','Irudia','Zuzena','Oker1','Oker2','Jatorria','Esteka','Egilea','\n')) #csv fitxategian idatzi goiburua
    print("#### galderak sortzen ####")
    for x in range(zenbat):
        n = random.randint(2,31)  
        print("{} bitarrean: {:05b}".format(n, n))
        galdera_osoa = getGaldera(n) #Elementuarekin erlazionatutako galdera lortu 
        f.write("%s;%s" % (galdera_osoa,'\n')) #csv fitxategian idatzi galdera
    print('\nEginda!')
    f.close()

generateGalderak(100, 'galderak_bitarrak_random.csv')

