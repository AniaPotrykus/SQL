--SZKOŁA JĘZYKOWA

SET DATEFORMAT ymd;

CREATE TABLE adres (
  id_adres int not null identity(1,1) PRIMARY KEY,
  nr_domu VARCHAR(12),
  nr_mieszkania VARCHAR(12),
  ulica VARCHAR(50),
  kod_pocztowy VARCHAR(12),
  miejscowosc VARCHAR(50git),
  kraj VARCHAR(50) DEFAULT 'Polska'
);

INSERT INTO adres (nr_domu, nr_mieszkania, ulica, kod_pocztowy, miejscowosc)
VALUES
(20, null, 'Sportowa', '84-103', 'Polchowo'),
(26, 5, 'Sloneczna', '84-100', 'Puck'),
(24, 2, 'Spokojna', '80-105', 'Mrzezino');

CREATE TABLE placacy (
  id_placacy int not null identity(1,1) PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(50),
  nr_telefonu VARCHAR(9) check(nr_telefonu like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  adres_email VARCHAR(50),
  termin_platnosci DATE,
  sposob_platnosci VARCHAR(12),
  id_adres int FOREIGN KEY REFERENCES adres(id_adres)
);

INSERT INTO placacy (imie, nazwisko, nr_telefonu, adres_email, termin_platnosci, sposob_platnosci, id_adres)
VALUES
('Martyna', 'Ziółko', '503523963', 'm.ziółko@gamil.com', '2024-05-06', 'karta', 1),
('Adam', 'Małysz', '509903786', 'a.małysz@gmail.com', '2024-05-03', 'karta', 2),
('Michal', 'Lis', '609765246', 'm.lis@gmail.com', '2024-05-05', 'gotowka', 3);
 
CREATE TABLE student (
  id_student int not null identity(1,1) PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(50),
  nr_indeksu int UNIQUE,
  data_urodzenia DATE,
  id_adres int FOREIGN KEY references adres(id_adres),
  pesel VARCHAR(11) UNIQUE check(pesel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  nr_telefonu VARCHAR(9) UNIQUE check(nr_telefonu like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  adres_email VARCHAR(50) UNIQUE,
  id_placacy int FOREIGN KEY references placacy(id_placacy)
);

INSERT INTO student (imie, nazwisko, nr_indeksu, data_urodzenia, id_adres, pesel, nr_telefonu, adres_email, id_placacy)
VALUES
('Weronika', 'Kasztan', 275465, '2000-01-15', 1, '12345678901', '123456789', 'w.kasztan@gmail.com', 1),
('Julia', 'Zbyszko', 286543,'1999-05-20', 2, '23456789012', '234567890', 'j.zbyszko@gmail.com', 2),
('Patrycja', 'Sałata', 247653, '2001-10-08', 3, '34567890123', '345678901', 'p.sałata@gmail.com', 3);

CREATE TABLE nauczyciel (
  id_nauczyciel int not null identity(1,1) PRIMARY KEY,
  imie VARCHAR(50),
  nazwisko VARCHAR(50),
  id_adres int FOREIGN KEY references adres(id_adres),
  pesel VARCHAR(11) UNIQUE check(pesel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  tytul_stopien_naukowy VARCHAR(12),
  status_studenta VARCHAR(1) check(status_studenta like '[0-1]'),
  nr_telefonu VARCHAR(9) UNIQUE check(nr_telefonu like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  adres_email VARCHAR(50) UNIQUE,
  nr_konta VARCHAR(26) check(nr_konta like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
);

INSERT INTO nauczyciel (imie, nazwisko, id_adres, pesel, tytul_stopien_naukowy, status_studenta, nr_telefonu, adres_email, nr_konta)
VALUES
('Michal', 'Nowak', 1, '45678901234', 'dr', '1', '456789012', 'm.nowak@gmail.com', '12345678901234567890123456'),
('Anna', 'Kowalczyk', 2, '56789012345', 'lic', '0', '567890123', 'a.kowalczyk@gmail.com', '23456789012345678901234567'),
('Katarzyna', 'Wójcik', 3, '67890123456', 'dr', '1', '678901234', 'k.wojcik@gmail.com', '34567890123456789012345678');

CREATE TABLE sala (
  id_sala int not null identity(1,1) PRIMARY KEY,
  nr_sali int,
  typ_sali VARCHAR(20)
);

INSERT INTO sala (nr_sali, typ_sali)
VALUES
(101, 'interaktywna'),
(102, 'komputerowa'),
(103, 'tradycyjna');
    
CREATE TABLE typ_zajec (
  id_typ_zajec int not null identity(1,1) PRIMARY KEY,
  nazwa VARCHAR(20),
  cena DECIMAL(10,2)
);
     
INSERT INTO typ_zajec (nazwa, cena)
VALUES
('grupowe', 80.00),
('w parach', 100.00),
('indywidualne', 120.00);
      
CREATE TABLE jezyk (
  id_jezyk int not null identity(1,1) PRIMARY KEY,
  nazwa_jezyk VARCHAR(12)
);

INSERT INTO jezyk (nazwa_jezyk)
VALUES
('angielski'),
('hiszpański'),
('francuski'),
('niemiecki');
     
CREATE TABLE grupa (
  id_grupa int not null identity(1,1) PRIMARY KEY,
  id_typ_zajec int FOREIGN KEY references typ_zajec(id_typ_zajec),
  nazwa_grupy VARCHAR(12),
  id_nauczyciel int FOREIGN KEY REFERENCES nauczyciel(id_nauczyciel),
  id_sala int FOREIGN KEY REFERENCES sala(id_sala),
  dzien_tygodnia VARCHAR(12),
  id_jezyk int FOREIGN KEY REFERENCES jezyk(id_jezyk),
  poziom_zaawansowania VARCHAR(50),
  godzina TIME,
  data_rozpoczecia_roku DATE,
  data_zakonczenia_roku DATE
);
      
INSERT INTO grupa (id_typ_zajec, nazwa_grupy, id_nauczyciel, id_sala, dzien_tygodnia, id_jezyk, poziom_zaawansowania, godzina, data_rozpoczecia_roku, data_zakonczenia_roku)
VALUES
(1, 'Ang1', 1, 1, 'Poniedzialek', 1, 'początkujący', '09:00:00', '2023-09-01', '2024-06-20'),
(2, 'Hisz2', 2, 2, 'Wtorek', 2, 'średnio zaawansowany', '10:00:00', '2023-09-02', '2024-06-21'),
(3, 'Fran3', 3, 3, 'Środa', 3, 'zaawansowany', '11:00:00', '2023-09-03', '2024-06-22');
      
CREATE TABLE student_na_grupe (
  id_student_na_grupe int not null identity(1,1) PRIMARY KEY,
  id_student int FOREIGN KEY REFERENCES student(id_student),
  id_grupa int FOREIGN KEY REFERENCES grupa(id_grupa)
);

INSERT INTO student_na_grupe (id_student, id_grupa)
VALUES
(1, 1),
(2, 2),
(3, 3);
       
CREATE TABLE kto_czego_kogo_uczy (
  id_kto_czego_kogo_uczy int not null identity(1,1) PRIMARY KEY,
  id_nauczyciel int FOREIGN KEY REFERENCES nauczyciel(id_nauczyciel),
  id_jezyk int foreign key references jezyk(id_jezyk),
  id_grupa int foreign key references grupa(id_grupa)
);

INSERT INTO kto_czego_kogo_uczy (id_nauczyciel, id_jezyk, id_grupa)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);


/* 
Wyjaśnienie relacji:
W szkółce pracują nauczyciele uczący różnych języków. 
Jeden nauczyciel może uczyć wielu języków (stąd dodatkowa encja nauczyciel_na_język).
Jeden nauczyciel może uczyć wiele grup (stąd dodatkowa encja nauczyciel_na_grupę).
Zajęcia mogą odbywać się w grupie, parach lub indywidualnie. Od tego zależy cena. 
Jeden uczeń może być w wielu grupach (zajęcia indywidualne to jednoosobowa grupa) (stąd dodatkowa encja student_na_grupę). 
Zajęcia odbywają się w konkretnych salach (typ = interaktywna, tradycyjna, komputerowa; zależy od grupy). 
Adres – jeden klient może mieć więcej adresów, adres może się powtarzać (płacący i student, lub nauczyciel mogą mieć ten sam adres)
*/

-- ZAPYTANIA

--Administracja szkolna mogłaby wykorzystać poniższe zapytania aby:

-- sprawdzić jaki nauczyciel posiada status studenta:
SELECT * FROM nauczyciel where status_studenta = 1

-- sprawdzić czy dla danego studenta termin płatności był uiszczony w danym miesiącu:
SELECT imie_p, nazwisko_p, termin_platnosci from placacy WHERE month(termin_platnosci) = 5 
ORDER BY nazwisko_p asc

-- sprawdzić jacy studenci należą do jakiej grupy i zobaczyć liczbę studentów:
SELECT grupa.nazwa_grupy, student.nazwisko_s, student.imie_s, COUNT(student.id_student) AS 'liczba studentow'
from grupa left join student_na_grupe
on grupa.id_grupa = student_na_grupe.id_grupa
left join student
on student_na_grupe.id_student = student.id_student
GROUP BY grupa.nazwa_grupy, student.nazwisko_s, student.imie_s

-- sprawdzić adres zamieszkania (tylko miejscowość) nauczycieli:
SELECT adres.miejscowosc, nauczyciel.imie_n, nauczyciel.nazwisko_n
FROM adres left join nauczyciel
on adres.id_adres = nauczyciel.id_adres
ORDER BY miejscowosc ASC

-- sprawdzić jaki płacący jest odpowiedzialny za jakiego studenta:
SELECT student.imie_s, student.nazwisko_s, placacy.imie_p, placacy.nazwisko_p
FROM student inner join placacy
ON student.id_placacy = placacy.id_placacy
ORDER BY student.nazwisko_s ASC

-- sprawdzić ile tygodni minęło od rozpoczęcia zajęć dla każdej grupy:
SELECT nazwa_grupy, DATEDIFF(week, data_rozpoczecia_roku, GETDATE()) AS 'tygodnie odbyte' from grupa

-- sprawdzić czy i kiedy zajęcia dla danego studenta są opłacone i w jaki sposób
SELECT student.imie_s, student.nazwisko_s, placacy.sposob_platnosci, placacy.termin_platnosci
FROM student
left JOIN placacy ON student.id_placacy = placacy.id_placacy

-- sprawdzić jakie grupy uczą się języka angielskiego, kiedy i na jakim poziomie. 
SELECT nazwa_grupy, dzien_tygodnia, poziom_zaawansowania FROM grupa WHERE nazwa_grupy LIKE 'Ang%'

-- sprawdzić jaki uczeń uczęszcza na jaki typ zajęć i ile one kosztują:
SELECT student.nazwisko_s, student.imie_s, typ_zajec.nazwa, typ_zajec.cena
FROM student left join student_na_grupe
ON student.id_student = student_na_grupe.id_student
left join grupa
on student_na_grupe.id_grupa = grupa.id_grupa
left join typ_zajec
ON grupa.id_typ_zajec = typ_zajec.id_typ_zajec
ORDER BY student.nazwisko_s ASC

-- sprawdzić jaki nauczyciel uczy jaką grupę:
SELECT nauczyciel.nazwisko_n, nauczyciel.imie_n, grupa.nazwa_grupy
FROM nauczyciel left join kto_czego_kogo_uczy
on nauczyciel.id_nauczyciel = kto_czego_kogo_uczy.id_nauczyciel
left join grupa
on kto_czego_kogo_uczy.id_grupa = grupa.id_grupa
ORDER BY nauczyciel.nazwisko_n ASC



--PROCEDURY: 
/* PROCEDURA DODAJ ADRES 
Procedura dodaj_adres jest odpowiedzialna za dodawanie nowego rekordu do tabeli adres. Umożliwia szybkie dodanie nowego adresu do bazy danych. */ 

CREATE PROCEDURE dodaj_adres  
    @nr_domu VARCHAR(12),  
    @nr_mieszkania VARCHAR(12),  
    @ulica VARCHAR(50),  
    @kod_pocztowy VARCHAR(12),  
    @miejscowosc VARCHAR(50) 
AS 
    INSERT INTO adres (nr_domu, nr_mieszkania, ulica, kod_pocztowy, miejscowosc) 
    VALUES (@nr_domu, @nr_mieszkania, @ulica, @kod_pocztowy, @miejscowosc); 

/* Przykład użycia: */ 
EXEC dodaj_adres  
    @nr_domu = 7,  
    @nr_mieszkania = 14,  
    @ulica = 'Pogodna',  
    @kod_pocztowy = '84-100',  
    @miejscowosc = 'Puck'; 

/*PROCEDURA DODAJ GRUPĘ 
Procedura dodaj_grupe jest odpowiedzialna za dodawanie nowego rekordu do tabeli grupa. Umożliwia administratorom dodanie nowej grupy zajęć do bazy danych wraz z wszystkimi szczegółami. */ 

CREATE PROCEDURE dodaj_grupe  
@id_typ_zajec int,  
    @nazwa_grupy varchar(12),  
    @id_nauczyciel int,  
    @id_sala int,  
    @dzien_tygodnia varchar(12),  
    @id_jezyk int,  
    @poziom_zaawansowania varchar(50),  
    @godzina time,  
    @data_rozpoczecia_roku date,  
    @data_zakonczenia_roku date 
as 
insert into grupa (id_typ_zajec, nazwa_grupy, id_nauczyciel, id_sala, dzien_tygodnia, id_jezyk, poziom_zaawansowania, godzina, 
data_rozpoczecia_roku, data_zakonczenia_roku)  

VALUES (@id_typ_zajec, @nazwa_grupy, @id_nauczyciel, @id_sala, @dzien_tygodnia, @id_jezyk, @poziom_zaawansowania, @godzina, 
@data_rozpoczecia_roku, @data_zakonczenia_roku)  


/* Przykład użycia: */ 
EXEC dodaj_grupe  
    @id_typ_zajec = 2,  
    @nazwa_grupy = 'Ang2',  
    @id_nauczyciel = 3,  
    @id_sala = 2,  
    @dzien_tygodnia = 'Wtorek',  
    @id_jezyk = 1, 
    @poziom_zaawansowania = 'zaawansowany',  
    @godzina = '12:00:00',  
    @data_rozpoczecia_roku = '2023-09-01',  
    @data_zakonczenia_roku = '2024-06-21'; 
 

--FUNCKJE 
/* FUNKCJA NAUCZYCIELE LICZBA 
Funkcja ta wylicza ile jest nauczycieli uczących danego języka. */ 

create function nauczyciele_liczba (@nazwa_jezyka varchar(12)) 
returns INT 
AS 
BEGIN 
return (SELECT COUNT(kto_czego_kogo_uczy.id_nauczyciel) AS liczba 
FROM jezyk 
LEFT JOIN kto_czego_kogo_uczy 
ON jezyk.id_jezyk = kto_czego_kogo_uczy.id_jezyk 
where jezyk.nazwa_jezyk = @nazwa_jezyka) 
end 

/* Przykład użycia */ 
select dbo.nauczyciele_liczba('angielski') 


/* FUKCJA LICZBA STUDENTÓW: 
Funkcja liczba_studentów jest odpowiedzialna za wyliczenie, ile studentów należy do danej grupy. */ 

CREATE FUNCTION liczba_studentow (@id_grupa INT) 
RETURNS INT 
AS 
BEGIN 
    RETURN (SELECT COUNT(*) FROM student_na_grupe WHERE id_grupa = @id_grupa); 
END; 

/* Przykład użycia: */ 
SELECT dbo.liczba_studentow(1) AS Liczba_studentow_w_Grupa_1; 

 

--WIDOKI: 
/* WIDOK JAKI NAUCZYCIEL 
Widok ten łączy tabele nauczyciel, kto_czego_kogo_uczy i grupa, aby pokazać, którzy nauczyciele uczą w poszczególnych grupach. */ 

CREATE VIEW jaki_nauczyciel 
AS 
SELECT nauczyciel.nazwisko, nauczyciel.imie, grupa.nazwa_grupy 
FROM nauczyciel left join kto_czego_kogo_uczy 
on nauczyciel.id_nauczyciel = kto_czego_kogo_uczy.id_nauczyciel 
left join grupa 
on kto_czego_kogo_uczy.id_grupa = grupa.id_grupa  

/* Przykład użycia: */ 
SELECT * from jaki_nauczyciel where nazwa_grupy = 'Ang1' 


/*WIDOK STUDENT TYP ZAJEC I CENA 
Widok ten łączy dane studentów z informacjami o grupach, do których uczęszczają, typie zajęć oraz ich cenie. */ 

CREATE VIEW student_typ_zajec_i_cena 
AS 
SELECT student.nazwisko, student.imie, typ_zajec.nazwa, typ_zajec.cena 
FROM student left join student_na_grupe 
ON student.id_student = student_na_grupe.id_student 
left join grupa 
on student_na_grupe.id_grupa = grupa.id_grupa 
left join typ_zajec 
ON grupa.id_typ_zajec = typ_zajec.id_typ_zajec 
 
/* Przykład użycia */ 
SELECT * from student_typ_zajec_i_cena 