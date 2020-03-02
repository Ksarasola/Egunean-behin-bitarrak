with Ada.Text_IO, Ada.Integer_Text_Io;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;


procedure Bitarrak_Egunean_Behin is
   
   procedure GetOkerrak (N: in Integer; 
			 Oker1, Oker2: out Integer) is
      --Aurre: 
      --Post:  Oker1 <= 31) and (2 <= Oker2 <= 31) and (Oker2 = N) and (Oker2 = Oker1)
      M : Integer := 29;
      G1 : Generator; -- Ausazko zenbakiak sortzeko G1 sortzailea
   begin
      Reset (G1); -- Ausazko zenbakiak sortzeko G1 sortzailea berrabiatu
      Oker1 := 2 + Integer(Float(M) * Random(G1)) mod M; -- 2 Eta 31 arteko Ausazko zenbakia
      while Oker1 = N loop
	 Oker1 := 2 + Integer(Float(M) * Random(G1)) mod M;
      end loop;
      Ada.Integer_Text_IO.Put (Oker1); 
      
      Oker2 := 2 + Integer(Float(M) * Random(G1)) mod M; -- 2 Eta 31 arteko Ausazko zenbakia
      while (Oker2 = N) and (Oker2 = Oker1) loop
	 Oker2 := 2 + Integer(Float(M) * Random(G1)) mod M;
      end loop;
      Ada.Integer_Text_IO.Put (Oker2); 
   end GetOkerrak;
   
   
   procedure  Idatzi_Galdera (F: Ada.Text_Io.File_Type; N:Integer) is
      --Aurre: (2 <= N <= 31)
      --Post:  N zenbakiarekin galdera batekin lerro bat gehitu da F fitxategian  
      Zuzena, Oker1, Oker2 : Integer;
      
      procedure Idatzi_Bitarrean (N: Positive) is
      --Aurre: (0 <= N <= 31)
      --Post:  N zenbakia sistema bitarrean idatzi da  F fitxategian  
	 I, N2 : Integer;
      begin
	 I := 1;
	 while N / (2**I) > 0 loop
	    I := I + 1;
	 end loop;
	 I := I-1;
	 N2 := 0;
	 while  I >=0 loop
	    N2 := N2 + 10**I * ((N / (2**I)) mod 2);
	    --Ada.Text_Io.Put(F, Integer'Image((N / (2**I)) mod 2));
	    I := I - 1;
	 end loop;
	 Ada.Integer_Text_Io.Put (F, N2);
      end Idatzi_Bitarrean;
      
   begin
      Zuzena := N ;
      GetOkerrak (N, Oker1, Oker2);
      
      --"Mota;Galdera;Irudia;Zuzena;Oker1;Oker2;Jatorria;Esteka;Egilea"
      
      -- Idatzi Mota
      Ada.Text_IO.Put (F, "Bitarra;"); 
      -- Idatzi Galdera
      --Galdera := "Zein da " & IdatziBitarrean(N) & " zenbaki bitarraren baliokidea?"; alternatibao
      Idatzi_Bitarrean (N);
      Ada.Text_IO.Put (F, " zenbaki bitarraren baliokidea?;"); 
      -- Idatzi Irudia
      Ada.Text_IO.Put (F, ";"); 
      -- Idatzi Zuzena
      Ada.Integer_Text_IO.Put (F, Zuzena); 
      Ada.Text_IO.Put (F, ";"); 
      -- Idatzi Oker1
      Ada.Integer_Text_IO.Put (F, Oker1); 
      Ada.Text_IO.Put (F, ";"); 
      -- Idatzi Oker2
      Ada.Integer_Text_IO.Put (F, Oker2); 
      Ada.Text_IO.Put (F, ";"); 
      -- Idatzi Jatorria;Esteka;Egilea
      Ada.Text_IO.Put (F, ";https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar;"); 
      Ada.Text_IO.New_line (F);   
   end Idatzi_Galdera;
   
   
   
   F : Ada.Text_IO.File_Type;
   Zenbat : constant Positive := 3; -- zenbat galdera sortu behar diren
   N: Positive;
   G : Generator;
   M : constant Integer := 29; -- 31-2

begin
   Ada.Text_IO.Create (F, Ada.Text_IO.out_File, "irteera_bitarrak_ada.csv");

   --csv fitxategian idatzi Goiburua
   Ada.Text_IO.Put_line (F, "Mota;Galdera;Irudia;Zuzena;Oker1;Oker2;Jatorria;Esteka;Egilea"); 
   Ada.Text_IO.Put_line ("#### galderak sortzen ####");

   for I in 1..Zenbat loop
      N := Integer(Float(M) * Random(G)) mod M;
      N := N+2 ;-- random 2..31 tartean
      Ada.Integer_Text_IO.Put (N); 
      --Elementuarekin erlazionatutako galdera idatzi F fitxategian
      Idatzi_Galdera(F, N)  ;  
      Ada.Text_IO.New_Line;
   end loop;
   
   Ada.Text_IO.Put_line ("Eginda!");
   Ada.Text_IO.Close (F);

end Bitarrak_Egunean_Behin;


--  EXEKUZIO-ADIBIDEA:

--  Mota;Galdera;Irudia;Zuzena;Oker1;Oker2;Jatorria;Esteka;Egilea
--  Bitarra;       1111 zenbaki bitarraren baliokidea?;;         15;         28;         24;;https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar;
--  Bitarra;         11 zenbaki bitarraren baliokidea?;;          3;          8;          2;;https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar;
--  Bitarra;      10000 zenbaki bitarraren baliokidea?;;         16;         29;          3;;https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar


-- PROGRAMA BALIOKIDEA PYTHONEZ:

--  import random

--  def getOkerrak(zuzena):
--      oker1 = random.randint(2,31)  #Erantzun oker bat hartu posible guztien artetik
--      oker2 = random.randint(2,31)  #Erantzun oker bat hartu posible guztien artetik
--      while oker1 == zuzena: oker1 = random.randint(0,31) #Ziurtatu zuzena ez dela oker bezala sartzen
--      while oker2 == zuzena or oker1 == oker2: oker2 = random.randint(2,31) #Ziurtatu zuzena eta lehen okerra ez direla bigarren oker bezala sartzen
--      return oker1, oker2

--  #Elementua eta erantzun posible guztiak pasata, lortu honi buruzko galdera bat
--  def getGaldera(n):
--      mota='bitarrak' #Galdera mota
--      iturria='https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar' #Galderaren jatorria edo iturria
--      galdera="Zein da {:05b} zenbaki bitarraren baliokidea?".format(n) #Testuzko galdera
--      irudia = '' #  adibide batzuk bitarren argazkia?
--      zuzena = n 
--      link = "https://eu.wikipedia.org/wiki/Zenbaki-sistema_bitar"
--      oker1, oker2 = getOkerrak(n)
--      galdera_osoa = "%s;%s;%s;%s;%s;%s;%s;%s;%s" % (mota,galdera,irudia,zuzena,oker1,oker2,iturria,link,'') #galdera osatu csv formaturako prestatuz
--      print(oker1, oker2)
--      return galdera_osoa

--  def generateGalderak(zenbat, irteera):
--      f = open(irteera, 'w')
--      f.write("%s;%s;%s;%s;%s;%s;%s;%s;%s;%s" % ('Mota','Galdera','Irudia','Zuzena','Oker1','Oker2','Jatorria','Esteka','Egilea','\n')) #csv fitxategian idatzi goiburua
--      print("#### galderak sortzen ####")
--      for x in range(zenbat):
--          n = random.randint(2,31)  
--          print("{} bitarrean: {:05b}".format(n, n))
--          galdera_osoa = getGaldera(n) #Elementuarekin erlazionatutako galdera lortu 
--          f.write("%s;%s" % (galdera_osoa,'\n')) #csv fitxategian idatzi galdera
--      print('\nEginda!')
--      f.close()

--  generateGalderak(100, 'galderak_bitarrak_random.csv')
  
