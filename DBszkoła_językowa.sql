#SZKOŁA JĘZYKOWA

SET DATEFORMAT ymd;

CREATE TABLE adres (
  id_adres int not null identity(1,1) PRIMARY KEY,
  nr_domu VARCHAR(12),
  nr_mieszkania VARCHAR(12),
  ulica VARCHAR(50),
  kod_pocztowy VARCHAR(12),
  miejscowosc VARCHAR(50),
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
