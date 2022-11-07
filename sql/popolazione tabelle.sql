INSERT INTO Agriturismo
	VALUES ("Farmhouse","Via diotisalvi, 2",07643520567,37500,3715140594);
INSERT INTO Stalla
	VALUES (01,"Farmhouse",800,0,0),(02,"Farmhouse",800,0,30),(03,"Farmhouse",800,0,60),(04,"Farmhouse",800,0,90),(05,"Farmhouse",800,0,120);
INSERT INTO Locale
	VALUES (01,01,"Nord",20,10,10,"Terra"),(02,01,"Est",20,10,10,"Terra"),(03,01,"Sud",20,10,10,"Terra"),(04,01,"Ovest",20,10,10,"Terra"),
		   (05,02,"Nord",20,10,10,"Terra"),(06,02,"Est",20,10,10,"Terra"),(07,02,"Sud",20,10,10,"Terra"),(08,02,"Ovest",20,10,10,"Terra"),
           (09,03,"Nord",20,10,10,"Terra"),(10,03,"Est",20,10,10,"Terra"),(11,03,"Sud",20,10,10,"Terra"),(12,03,"Ovest",20,10,10,"Terra"),
           (13,04,"Nord",20,10,10,"Terra"),(14,04,"Est",20,10,10,"Terra"),(15,04,"Sud",20,10,10,"Terra"),(16,04,"Ovest",20,10,10,"Terra"),
           (17,05,"Nord",20,10,10,"Terra"),(18,05,"Est",20,10,10,"Terra"),(19,05,"Sud",20,10,10,"Terra"),(20,05,"Ovest",20,10,10,"Terra");
INSERT INTO Specie
	VALUES ("Bovina",0.1,0.1,0.1,0.1),("Ovina",0.2,0.1,0.1,0.1),("Caprina",0.2,0.1,0.1,0.1);
INSERT INTO Animale
	VALUES ("c001","Caprina","M","Caprinae","Capra nana nigeriana",'2017-03-10',01),("c002","Caprina","F","Caprinae","Capra nana nigeriana",'2017-04-09',01),
		   ("c003","Caprina","M","Caprinae","Capra nana nigeriana",'2017-05-29',03),("c004","Caprina","F","Caprinae","Camosciata delle Alpi",'2017-07-27',04),
           ("c005","Caprina","F","Caprinae","Camosciata delle Alpi",'2018-07-02',04),("c006","Caprina","M","Caprinae","Camosciata delle Alpi",'2018-09-29',05),
           ("c007","Caprina","M","Caprinae","Capra Lamancha",'2017-09-01',06),("c008","Caprina","F","Caprinae","Capra Lamancha",'2017-05-16',06),
           ("b001","Bovina","M","Bovinae","Bruna Svizzera",'2017-03-22',07),("b002","Bovina","M","Bovinae","Bruna Svizzera",'2018-05-19',07),
           ("b003","Bovina","F","Bovinae","Bruna Svizzera",'2018-11-26',08),("b004","Bovina","M","Bovinae","Bianca nera polacca",'2018-11-29',10),
           ("b005","Bovina","F","Bovinae","Bianca nera polacca",'2017-02-05',10),("b006","Bovina","F","Bovinae","Bianca nera polacca",'2017-07-06',10),
           ("b007","Bovina","F","Bovinae","Jersey",'2017-10-12',11),("b008","Bovina","M","Bovinae","Jersey",'2019-03-04',13),
           ("b009","Bovina","M","Bovinae","Jersey",'2018-04-24',13),("o001","Ovina","M","Ovis Aries","Altamurana",'2018-09-03',15),
           ("o002","Ovina","F","Ovis Aries","Altamurana",'2017-01-02',15),("o003","Ovina","M","Ovis Aries","Massese",'2017-04-29',16),
           ("o004","Ovina","M","Ovis Aries","Massese",'2018-06-10',18),("o005","Ovina","M","Ovis Aries","Massese",'2018-04-10',20),
           ("o006","Ovina","F","Ovis Aries","Massese",'2018-09-25',20);
INSERT INTO Fornitore
	VALUES (40739631537,"S.r.l","Spaccio Animali","Via Gamerra,1"),(87530606693,"S.s","Pecoraro Ascanio","Via delle felci,32"),
		   (11874198505,"S.s","Oronzo Greco","Via Carlo Cattaneo, 74");
INSERT INTO Acquisto
	VALUES ("b006",11874198505,'2017-11-06',1399,'2017-11-09'),("c007",40739631537,'2018-06-05',859,'2018-06-08'),("o006",87530606693,'2018-12-26',789,'2018-12-31'),
		   ("b009",11874198505,'2018-07-26',1399,'2018-07-29');
INSERT INTO Zona
	VALUES ("Bosco Fiorito","Farmhouse",15),("Foresta Ululo","Farmhouse",19),("Campo Tramontana","Farmhouse",23);
INSERT INTO Recinzione	-- xa,ya,xb,yb
	VALUES (001,80,0,150,0),(002,80,0,100,35),(003,150,0,100,35),
		   (004,80,0,80,65),(005,80,65,150,65),(006,150,65,100,35),
           (007,150,65,150,0);
INSERT INTO GeografiaZone
	VALUES ("Bosco Fiorito",001),("Bosco Fiorito",002),("Bosco Fiorito",003),("Foresta Ululo",002),("Foresta Ululo",004),("Foresta Ululo",005),("Foresta Ululo",006),
		   ("Campo Tramontana",003),("Campo Tramontana",007);
INSERT INTO Foraggio
	VALUES (01,6.3,5.3,3.5,27,31,42,"Fresco"),(02,5.1,6.2,2.2,45,22,33,"Insilato"),(03,9.8,3.9,6.9,17,54,29,"Fieno");
INSERT INTO Mangiatoia(CodMangiatoia,Locale,Marca,Modello,Capacita)
	VALUES (01,01,"Mangiatroiaium","MT Deluxe",75),(03,03,"Mangiatroiaium","MT Deluxe",75),(04,04,"Mangiatroiaium","MT Deluxe",75),
           (05,05,"Mangiatroiaium","MT Deluxe",75),(06,06,"Mangiatroiaium","MT Deluxe",75),(07,07,"Mangiatroiaium","MT Deluxe",75),
           (08,08,"Mangiatroiaium","MT Deluxe",75),(10,10,"Mangiatroiaium","MT Deluxe",75),(11,11,"Mangiatroiaium","MT Deluxe",75),
           (13,13,"Mangiatroiaium","MT Deluxe",75),(15,15,"Mangiatroiaium","MT Deluxe",75),(16,16,"Mangiatroiaium","MT Deluxe",75),
           (18,18,"Mangiatroiaium","MT Deluxe",75),(20,20,"Mangiatroiaium","MT Deluxe",75);
INSERT INTO StatoMangiatoia
	VALUES (01,'2019-04-26 00:35:16',08,01),(01,'2017-03-27 03:46:24',65,02),(01,'2017-05-30 17:43:16',79,03),(03,'2019-06-25 04:21:01',53,01),(03,'2018-06-20 09:04:32',24,02),
		   (03,'2018-04-21 12:23:36',25,03),(04,'2017-10-02 16:59:33',12,01),(04,'2019-03-16 20:29:19',74,02),(04,'2017-06-07 21:24:06',73,03),(05,'2018-01-26 21:48:13',94,01),
           (05,'2017-06-09 01:48:27',36,02),(05,'2018-07-15 06:57:06',93,03),(06,'2018-01-23 04:47:56',43,01),(06,'2018-01-25 18:24:45',30,02),(06,'2018-11-07 11:09:24',89,03),
           (07,'2019-02-09 12:13:07',34,01),(07,'2017-07-30 10:56:12',93,02),(07,'2017-02-25 03:07:09',96,03),(08,'2017-07-28 20:50:47',18,01),(08,'2019-03-26 16:05:56',71,02),
           (08,'2017-10-06 16:22:57',69,03),(10,'2019-04-13 05:42:38',21,01),(10,'2018-05-15 15:40:53',07,02),(10,'2017-07-04 15:45:08',69,03),(11,'2018-04-04 15:26:58',06,01),
           (11,'2017-06-25 16:42:49',34,02),(11,'2017-11-13 20:29:50',45,03),(13,'2019-06-27 06:48:58',82,01),(13,'2017-08-12 14:18:23',66,02),(13,'2017-10-12 01:24:28',47,03),
           (15,'2019-06-18 03:55:01',46,01),(15,'2017-07-02 00:35:42',81,02),(15,'2018-09-08 15:48:32',23,03),(16,'2017-09-20 22:59:00',41,01),(16,'2017-03-09 11:56:33',18,02),
           (16,'2019-02-10 12:21:45',52,03),(18,'2017-11-05 07:42:52',48,01),(18,'2018-06-28 12:38:10',48,02),(18,'2017-09-28 20:26:39',52,03),(20,'2018-08-15 16:03:03',74,01),
           (20,'2018-12-22 23:06:08',67,02),(20,'2019-05-17 08:51:33',25,03);
INSERT INTO SensoreVisivo
	VALUES (01,"Vision","V Premium",01,''),(03,"Vision","V Premium",02,''),(05,"Vision","V Premium",03,''),(07,"Vision","V Premium",04,''),(09,"Vision","V Premium",05,''),
           (11,"Vision","V Premium",06,''),(13,"Vision","V Premium",07,''),(15,"Vision","V Premium",08,''),(17,"Vision","V Premium",09,''),(19,"Vision","V Premium",10,''),
           (21,"Vision","V Premium",11,''),(23,"Vision","V Premium",12,''),(25,"Vision","V Premium",13,''),(27,"Vision","V Premium",14,''),(29,"Vision","V Premium",15,''),
           (31,"Vision","V Premium",16,''),(33,"Vision","V Premium",17,''),(35,"Vision","V Premium",18,''),(37,"Vision","V Premium",19,''),(39,"Vision","V Premium",20,'');
INSERT INTO StatoSensoreV
	VALUES (01,'2019-04-26 00:35:16',79,82),(01,'2017-03-27 03:46:24',21,30),(01,'2017-05-30 17:43:16',93,46),(03,'2017-10-02 16:59:33',47,26),(03,'2019-03-16 20:29:19',21,32),
           (03,'2017-06-07 21:24:06',72,95),(05,'2018-01-23 04:47:56',21,41),(05,'2018-01-25 18:24:45',76,17),(05,'2018-11-07 11:09:24',44,51),(07,'2017-07-28 20:50:47',20,40),
           (07,'2019-03-26 16:05:56',37,79),(07,'2017-10-06 16:22:57',39,79),(09,'2018-04-04 15:26:58',45,01),(09,'2017-06-25 16:42:49',33,17),(09,'2017-11-13 20:29:50',60,73),
           (11,'2019-06-18 03:55:01',57,20),(11,'2017-07-02 00:35:42',10,53),(11,'2018-09-08 15:48:32',42,30),(13,'2017-11-05 07:42:52',86,15),(13,'2018-06-28 12:38:10',03,49),
           (13,'2017-09-28 20:26:39',85,17),(15,'2019-04-26 00:35:16',67,26),(15,'2017-03-27 03:46:24',30,80),(15,'2017-05-30 17:43:16',59,93),(17,'2017-06-07 21:24:06',73,66),
           (17,'2018-01-26 21:48:13',94,91),(17,'2017-06-09 01:48:27',36,12),(19,'2018-11-07 11:09:24',89,22),(19,'2019-02-09 12:13:07',34,76),(21,'2017-07-30 10:56:12',93,68),
           (21,'2019-03-26 16:05:56',71,84),(21,'2017-10-06 16:22:57',69,03),(21,'2019-04-13 05:42:38',21,41),(23,'2017-06-25 16:42:49',34,69),(23,'2017-11-13 20:29:50',45,39),
           (23,'2019-06-27 06:48:58',82,05),(25,'2017-07-02 00:35:42',81,90),(25,'2018-09-08 15:48:32',23,03),(25,'2017-09-20 22:59:00',41,12),(27,'2018-06-28 12:38:10',48,91),
           (27,'2017-09-28 20:26:39',52,80),(27,'2018-08-15 16:03:03',74,96),(29,'2018-01-26 21:48:13',94,19),(29,'2017-06-09 01:48:27',36,14),(29,'2018-11-07 11:09:24',89,70),
           (31,'2019-02-09 12:13:07',34,50),(31,'2017-07-30 10:56:12',93,52),(31,'2019-03-26 16:05:56',71,10),(33,'2017-10-06 16:22:57',69,85),(33,'2019-04-13 05:42:38',21,40),
           (33,'2017-06-25 16:42:49',34,59),(35,'2017-11-13 20:29:50',45,99),(35,'2019-06-27 06:48:58',82,72),(35,'2017-07-02 00:35:42',81,21),(37,'2018-09-08 15:48:32',23,52),
           (19,'2017-09-20 22:59:00',41,01),(21,'2018-06-28 12:38:10',48,02),(39,'2017-09-28 20:26:39',52,84),(39,'2018-08-15 16:03:03',74,43),(39,'2018-08-15 16:03:07',74,12);
INSERT INTO Condizionatore
	VALUES (01,01,"Brrrrr","Deluxe"),(03,03,"Brrrrr","Deluxe"),(04,04,"Brrrrr","Deluxe"),
           (05,05,"Brrrrr","Deluxe"),(06,06,"Brrrrr","Deluxe"),(07,07,"Brrrrr","Deluxe"),
           (08,08,"Brrrrr","Deluxe"),(10,10,"Brrrrr","Deluxe"),(11,11,"Brrrrr","Deluxe"),
           (13,13,"Brrrrr","Deluxe"),(15,15,"Brrrrr","Deluxe"),(16,16,"Brrrrr","Deluxe"),
           (18,18,"Brrrrr","Deluxe"),(20,20,"Brrrrr","Deluxe");
INSERT INTO StatoCondizionatore
	VALUES (01,'2019-04-26 00:35:16',20,08,79),(01,'2017-03-27 03:46:24',20,65,21),(01,'2017-05-30 17:43:16',20,79,93),(03,'2019-06-25 04:21:01',20,53,47),(03,'2018-06-20 09:04:32',20,24,21),
		   (03,'2018-04-21 12:23:36',20,25,72),(04,'2017-10-02 16:59:33',20,12,21),(04,'2019-03-16 20:29:19',20,74,76),(04,'2017-06-07 21:24:06',20,73,44),(05,'2018-01-26 21:48:13',20,94,20),
           (05,'2017-06-09 01:48:27',20,36,37),(05,'2018-07-15 06:57:06',20,93,39),(06,'2018-01-23 04:47:56',20,43,45),(06,'2018-01-25 18:24:45',20,30,03),(06,'2018-11-07 11:09:24',20,89,86),
           (07,'2019-02-09 12:13:07',20,34,90),(07,'2017-07-30 10:56:12',20,93,05),(07,'2017-02-25 03:07:09',20,96,70),(08,'2017-07-28 20:50:47',20,18,19),(08,'2019-03-26 16:05:56',20,71,64),
           (08,'2017-10-06 16:22:57',20,69,12),(10,'2019-04-13 05:42:38',20,21,83),(10,'2018-05-15 15:40:53',20,07,49),(10,'2017-07-04 15:45:08',20,69,15),(11,'2018-04-04 15:26:58',20,06,23),
           (11,'2017-06-25 16:42:49',20,34,52),(11,'2017-11-13 20:29:50',20,45,84),(13,'2019-06-27 06:48:58',20,82,69),(13,'2017-08-12 14:18:23',20,66,72),(13,'2017-10-12 01:24:28',20,47,33),
           (15,'2019-06-18 03:55:01',20,46,14),(15,'2017-07-02 00:35:42',20,81,08),(15,'2018-09-08 15:48:32',20,23,22),(16,'2017-09-20 22:59:00',20,41,17),(16,'2017-03-09 11:56:33',20,18,89),
           (16,'2019-02-10 12:21:45',20,52,91),(18,'2017-11-05 07:42:52',20,48,58),(18,'2018-06-28 12:38:10',20,48,64),(18,'2017-09-28 20:26:39',20,52,53),(20,'2018-08-15 16:03:03',20,74,21),
           (20,'2018-12-22 23:06:08',20,67,10),(20,'2019-05-17 08:51:33',20,25,03);
INSERT INTO Abbeveratoio
	VALUES (01,01,"Slurp","Deluxe",75),(03,03,"Slurp","Deluxe",75),(04,04,"Slurp","Deluxe",75),
           (05,05,"Slurp","Deluxe",75),(06,06,"Slurp","Deluxe",75),(07,07,"Slurp","Deluxe",75),
           (08,08,"Slurp","Deluxe",75),(10,10,"Slurp","Deluxe",75),(11,11,"Slurp","Deluxe",75),
           (13,13,"Slurp","Deluxe",75),(15,15,"Slurp","Deluxe",75),(16,16,"Slurp","Deluxe",75),
           (18,18,"Slurp","Deluxe",75),(20,20,"Slurp","Deluxe",75);
INSERT INTO Integratore
	VALUES ("A TUTTO PASTO",17.5,43.6),("ABIES PECTINATA",59.2,14.5),("PERACNIL REDOX",33.7,41.8);
INSERT INTO StatoAbbeveratoio
	VALUES (01,'2019-04-26 00:35:16',08,"A TUTTO PASTO"),(01,'2017-03-27 03:46:24',65,"ABIES PECTINATA"),(01,'2017-05-30 17:43:16',79,"PERACNIL REDOX"),(03,'2019-06-25 04:21:01',53,"A TUTTO PASTO"),(03,'2018-06-20 09:04:32',24,"ABIES PECTINATA"),
		   (03,'2018-04-21 12:23:36',25,"PERACNIL REDOX"),(04,'2017-10-02 16:59:33',12,"A TUTTO PASTO"),(04,'2019-03-16 20:29:19',74,"ABIES PECTINATA"),(04,'2017-06-07 21:24:06',73,"PERACNIL REDOX"),(05,'2018-01-26 21:48:13',94,"A TUTTO PASTO"),
           (05,'2017-06-09 01:48:27',36,"ABIES PECTINATA"),(05,'2018-07-15 06:57:06',93,"PERACNIL REDOX"),(06,'2018-01-23 04:47:56',43,"A TUTTO PASTO"),(06,'2018-01-25 18:24:45',30,"ABIES PECTINATA"),(06,'2018-11-07 11:09:24',89,"PERACNIL REDOX"),
           (07,'2019-02-09 12:13:07',34,"A TUTTO PASTO"),(07,'2017-07-30 10:56:12',93,"ABIES PECTINATA"),(07,'2017-02-25 03:07:09',96,"PERACNIL REDOX"),(08,'2017-07-28 20:50:47',18,"A TUTTO PASTO"),(08,'2019-03-26 16:05:56',71,"ABIES PECTINATA"),
           (08,'2017-10-06 16:22:57',69,"PERACNIL REDOX"),(10,'2019-04-13 05:42:38',21,"A TUTTO PASTO"),(10,'2018-05-15 15:40:53',07,"ABIES PECTINATA"),(10,'2017-07-04 15:45:08',69,"PERACNIL REDOX"),(11,'2018-04-04 15:26:58',06,"A TUTTO PASTO"),
           (11,'2017-06-25 16:42:49',34,"ABIES PECTINATA"),(11,'2017-11-13 20:29:50',45,"PERACNIL REDOX"),(13,'2019-06-27 06:48:58',82,"A TUTTO PASTO"),(13,'2017-08-12 14:18:23',66,"ABIES PECTINATA"),(13,'2017-10-12 01:24:28',47,"PERACNIL REDOX"),
           (15,'2019-06-18 03:55:01',46,"A TUTTO PASTO"),(15,'2017-07-02 00:35:42',81,"ABIES PECTINATA"),(15,'2018-09-08 15:48:32',23,"PERACNIL REDOX"),(16,'2017-09-20 22:59:00',41,"A TUTTO PASTO"),(16,'2017-03-09 11:56:33',18,"ABIES PECTINATA"),
           (16,'2019-02-10 12:21:45',52,"PERACNIL REDOX"),(18,'2017-11-05 07:42:52',48,"A TUTTO PASTO"),(18,'2018-06-28 12:38:10',48,"ABIES PECTINATA"),(18,'2017-09-28 20:26:39',52,"PERACNIL REDOX"),(20,'2018-08-15 16:03:03',74,"A TUTTO PASTO"),
           (20,'2018-12-22 23:06:08',67,"ABIES PECTINATA"),(20,'2019-05-17 08:51:33',25,"PERACNIL REDOX");
INSERT INTO Pascolo
	VALUES (01,'2017-05-14','15:01:25',48,"Bosco Fiorito"),(03,'2017-05-14','15:01:25',49,"Foresta Ululo"),(04,'2017-05-14','15:01:25',32,"Campo Tramontana"),(05,'2017-05-14','15:01:25',47,"Bosco Fiorito"),(06,'2017-05-14','15:01:25',15,"Foresta Ululo"),
		   (07,'2017-05-14','15:01:25',51,"Campo Tramontana"),(08,'2017-05-14','15:01:25',40,"Bosco Fiorito"),(10,'2017-05-14','15:01:25',09,"Foresta Ululo"),(11,'2017-05-14','15:01:25',34,"Campo Tramontana"),(13,'2017-05-14','15:01:25',60,"Bosco Fiorito"),
           (15,'2017-05-14','15:01:25',46,"Foresta Ululo"),(16,'2017-05-14','15:01:25',54,"Bosco Fiorito"),(18,'2017-05-14','15:01:25',41,"Campo Tramontana"),(20,'2017-05-14','15:01:25',21,"Foresta Ululo");
INSERT INTO Veterinario
	VALUES (01,"Fedro","Bruno","Sanità Animale"),(02,"Quintina","Monaldo","Patologie"),(03,"Libera","Zetticci","Malattie Infettive");
INSERT INTO Riproduzione
	VALUES (01,"c001","c002",'2016-12-29',01),(02,"o005","o006",'2018-12-29',01),(03,"b001","b003",'2017-05-19',01);
INSERT INTO Gestazione
	VALUES (02,"In corso",02,'2018-12-30',null,01);
 INSERT INTO PosizioneGPS
 	VALUES ("c001",'2019-02-17 15:53:18',94,4),("c002",'2019-01-11 22:45:21',140,17),
		   ("c003",'2019-05-08 11:09:53',87,51),("c004",'2019-06-09 02:46:37',116,64),
           ("c005",'2019-01-03 06:01:41',126,1),("c006",'2019-01-21 06:27:30',98,49),
           ("c007",'2019-06-21 06:46:13',107,40),("c008",'2019-05-21 03:37:35',71,28),
           ("b001",'2019-06-01 21:09:01',71,44),("b002",'2019-05-20 16:43:04',106,58),
           ("b003",'2019-04-19 19:53:35',62,62),("b004",'2019-05-05 01:50:04',147,45),
           ("b005",'2019-04-27 18:40:55',134,34),("b006",'2019-01-08 12:10:28',119,68),
           ("b007",'2019-03-01 12:17:37',65,88),("b008",'2019-04-26 23:51:01',140,71),
           ("b009",'2019-06-28 05:31:18',114,73),("o001",'2019-01-17 16:37:00',76,32),
           ("o002",'2019-07-03 22:27:21',145,64),("o003",'2019-04-16 23:19:12',116,83),
           ("o004",'2019-03-25 02:28:09',114,54),("o005",'2019-04-23 23:49:49',86,29),
           ("o006",'2019-06-13 18:01:05',112,68),("c001",'2019-05-17 15:58:18',94,4),
           ("c001",'2019-02-17 16:03:18',94,65),("c002",'2019-01-11 22:50:21',140,20),
		   ("c003",'2019-05-08 11:14:53',87,80),("c004",'2019-06-09 02:51:37',116,46),
           ("c005",'2019-01-03 06:06:41',126,19),("c006",'2019-01-21 06:32:30',98,57),
           ("c007",'2019-06-21 06:51:13',107,25),("c008",'2019-05-21 03:32:35',71,66),
           ("b001",'2019-06-01 21:14:01',71,41),("b002",'2019-05-20 16:48:04',106,38),
           ("b003",'2019-04-19 19:58:35',62,32),("b004",'2019-05-05 01:55:04',147,68),
           ("b005",'2019-04-27 18:45:55',134,59),("b006",'2019-01-08 12:15:28',119,85),
           ("b007",'2019-03-01 12:22:37',65,73),("b008",'2019-04-26 23:56:01',140,10),
           ("b009",'2019-06-28 05:35:18',114,48),("o001",'2019-01-17 16:42:00',76,41),
           ("o002",'2019-07-03 22:32:21',145,1),("o003",'2019-04-16 23:24:12',116,85),
           ("o004",'2019-03-25 02:33:09',114,83),("o005",'2019-04-23 23:54:49',86,7),
           ("o006",'2019-06-13 18:06:05',112,11),("c001",'2019-05-17 16:08:18',94,65);
INSERT INTO VisitaControllo(Animale,Veterinario,Stato,DataVisita)
	VALUES ("c001",02,"Positivo",'2017-05-15'),("b001",02,"Negativo",'2017-07-24'),("o006",02,"Positivo",'2019-02-28'),
		   ("c002",02,"Programmata",'2019-08-15'),("b002",02,"Negativo",'2018-07-24'),("o002",02,"Negativo",'2019-02-28'),("b001",02,"Negativo",'2019-07-05');
INSERT INTO Esame
	VALUES (01,02,"Esame per malattie infettive",'2017-07-24',"","Microscopio",03);
INSERT INTO Patologia
	VALUES ("Brucellosi","Generale",07),("Febbre catarrale","Generale",05),("Leucosi Enzootica","Generale",09),
		   ("Tubercolosi","Polmoni",06),("Salmonellosi","Tratto Gastrointestinale",06);
INSERT INTO Farmaco
	VALUES ("CARDOTEK",0.5,15,"Ivermectina"),("Aspirina",0.5,5,"Acido Acetilsalicilico"),("SIVASTIN",0.3,10,"Simvastatina"),
		   ("Omeprazolo",0.2,13,"Omeprazolo"),("Ramipril Ratiopharm",0.05,7,"Ramipril");
INSERT INTO Terapia(Visita,Patologia,DataInizio,DurataInGiorni,Rimedio,Veterinario)
	VALUES (02,"Brucellosi",'2017-07-31',14,"CARDOTEK",02),(05,"Febbre catarrale",'2018-07-31',30,"Aspirina",02),(06,"Salmonellosi",'2019-03-10',7,"Omeprazolo",02);
INSERT INTO Posologia
	VALUES (01,1,'12:30',0.2),(01,3,'13:30',0.2),(01,6,'18:00',0.2),(02,1,'12:30',0.2),(02,3,'13:30',0.2),(02,6,'18:00',0.2),
		   (03,1,'12:30',0.2),(03,3,'13:30',0.2),(03,6,'18:00',0.2);
INSERT INTO ParametroOggettivo
	VALUES ("c001","Spessore Zoccolo",'2017-05-15',5),("c001","Risposta Oculare",'2017-05-15',7),("c001","Emocromo",'2017-05-15',3),
		   ("b001","Spessore Zoccolo",'2017-07-24',3),("b001","Risposta Oculare",'2017-07-24',4),("b001","Emocromo",'2017-07-24',6),
           ("o006","Spessore Zoccolo",'2019-02-28',7),("o006","Risposta Oculare",'2019-02-28',7),("o006","Emocromo",'2019-02-28',1),
           ("b002","Spessore Zoccolo",'2018-07-24',4),("b002","Risposta Oculare",'2018-07-24',2),("b002","Emocromo",'2018-07-24',3),
           ("o002","Spessore Zoccolo",'2019-02-28',9),("o002","Risposta Oculare",'2019-02-28',5),("o002","Emocromo",'2019-02-28',3);
INSERT INTO Lesione
	VALUES ("b001","Frattura",'2017-07-24',"Gamba",8),("c001","Slogamento",'2017-05-15',"Malleolo",2),("b002","Stirmaneto",'2018-07-24',"Gamba",6);
INSERT INTO DisturboComportamentale
	VALUES ("b001","Depressione",'2017-07-24',9),("o006","Ansia",'2019-02-28',6),("o002","Aggressività",'2019-02-28',3);
INSERT INTO ParametriGravidanza
	VALUES (02,'2019-02-28',10,3,10,7,9);
INSERT INTO Mungitrice(Agriturismo,Marca,Modello,Latitudine,Longitudine)
	VALUES ("Farmhouse","MilkME!","Deluxe",115,15),("Farmhouse","MilkME!","Deluxe",100,50),("Farmhouse","MilkME!","Deluxe",135,35),
		   ("Farmhouse","MilkME!","Deluxe",20,10),("Farmhouse","MilkME!","Deluxe",20,40),("Farmhouse","MilkME!","Deluxe",20,70),
           ("Farmhouse","MilkME!","Deluxe",20,100),("Farmhouse","MilkME!","Deluxe",20,130);
INSERT INTO Silos(Capacita,QuantitaAttuale,MediaProteine,MediaLipidi,MediaZuccheri,MediaVitamine,MediaMinerali,MediaEnzimi)
	VALUES (5000,0,0,0,0,0,0,0),(5000,0,0,0,0,0,0,0),(5000,0,0,0,0,0,0,0);
INSERT INTO Mungitura(Mungitrice,Animale,`Timestamp`,VolumeLatte,Proteine,Enzimi,Lipidi,Zuccheri,Vitamine,Minerali)
	VALUES (01,"c002",'2017-10-09',5,3,5,7,6,4,8),(02,"c004",'2017-11-27',4.5,7,6,9,4,2,3),(04,"b003",'2019-05-26',7,9,8,3,4,1,6),
		   (06,"b005",'2017-08-05',3.7,5,3,4,1,2,8),(07,"o002",'2017-09-02',4.3,1,5,7,8,6,3),(08,"o006",'2019-06-10',6,5,7,1,9,6,4);
INSERT INTO Lotto(`Data`,CodLaboratorio)
	VALUES ('2018-11-07',01),('2019-05-22',02);
INSERT INTO LatteUtilizzato
	VALUES (01,01,10,5,6,8,4,6,7),(02,03,15,7,5,9,5,1,3);
INSERT INTO Dipendente(Nome,Cognome)
	VALUES ("Livia","Lucciano"),("Fabiola","Rossi"),("Virginio","Romani"),("Alfredino","Endrizzi"),("Isacco","Trentintini"),("Dante","Gallo"),("Annabella","Onio");
INSERT INTO Impiegati
	VALUES (01,01),(01,02),(01,03),(02,04),(02,05),(02,06),(02,07);
INSERT INTO Formaggio
	VALUES ("Fontina Valdostana DOP","Bassa","Valle d'Aosta",1.5),("Pecorino Toscano","Bassa","Toscana",2),("Squacquerone di Romagna DOP","Alta","Emilia-Romanga",3.3);
INSERT INTO Formato
	VALUES ("Fontina Valdostana DOP",100,1),("Fontina Valdostana DOP",250,2.3),("Fontina Valdostana DOP",500,4),
		   ("Pecorino Toscano",100,1.5),("Pecorino Toscano",250,3.3),("Pecorino Toscano",500,6.99),
           ("Squacquerone di Romagna DOP",100,1.99),("Squacquerone di Romagna DOP",250,3.79),("Squacquerone di Romagna DOP",500,8);
INSERT INTO Prodotto(Lotto,NomeFormaggio,PesoFormato,Peso,Stato,DataScadenza)
	VALUES (01,"Squacquerone di Romagna DOP",250,248,"Spedito",'2018-12-07'),(01,"Squacquerone di Romagna DOP",250,247,"Spedito",'2018-12-07'),
		   (01,"Fontina Valdostana DOP",100,101,"Stoccato",'2019-07-30'),(01,"Pecorino Toscano",100,99,"Spedito",'2018-12-07'),
           (02,"Pecorino Toscano",500,489,"Stagionatura",'2020-07-22'),(02,"Pecorino Toscano",250,251,"Stagionatura",'2020-07-22'),
           (02,"Squacquerone di Romagna DOP",500,493,"Spedito",'2019-06-22'),(02,"Fontina Valdostana DOP",250,250,"Stoccato",'2019-12-22');
INSERT INTO FaseRicetta
	VALUES ("Fontina Valdostana DOP",01,1,"Coagulazione"),("Fontina Valdostana DOP",02,1,"Rottura del coagulo"),("Fontina Valdostana DOP",03,1,"Spinatura"),
		   ("Fontina Valdostana DOP",04,1,"Pressatura"),("Fontina Valdostana DOP",05,1,"Salamoia"),("Fontina Valdostana DOP",06,80,"Stagionatura"),
           ("Pecorino Toscano",01,1,"Aggiunta del caglio al latte"), ("Pecorino Toscano",02,1,"Coagulazione"), ("Pecorino Toscano",03,1,"Rottura del coagulo"),
		   ("Pecorino Toscano",04,1,"Spurgo del siero"), ("Pecorino Toscano",05,1,"Salatura"), ("Pecorino Toscano",06,20,"Maturazione"),
           ("Squacquerone di Romagna DOP",01,1,"Pastorizzazione"), ("Squacquerone di Romagna DOP",02,1,"Acidificazione"),("Squacquerone di Romagna DOP",03,1,"Coagulazione"),
		   ("Squacquerone di Romagna DOP",04,1,"Rottura del coagulo"),("Squacquerone di Romagna DOP",05,1,"Salatura");
INSERT INTO ValoreIdealeRicetta
	VALUES ("Fontina Valdostana DOP",01,"pH",5),("Fontina Valdostana DOP",02,"Acqua",38),("Fontina Valdostana DOP",03,"Acido Lattico",1.2),("Fontina Valdostana DOP",04,"Sali Minerali",4.1),("Fontina Valdostana DOP",05,"KJ",1600),
		   ("Fontina Valdostana DOP",06,"pH",5.3),("Pecorino Toscano",01,"pH",4.8),("Pecorino Toscano",02,"Acqua",42),("Pecorino Toscano",03,"Acido Lattico",2.4),("Pecorino Toscano",04,"Sali Minerali",3.7),
           ("Pecorino Toscano",05,"KJ",1450),("Pecorino Toscano",06,"pH",5.2),("Squacquerone di Romagna DOP",01,"pH",4.9),("Squacquerone di Romagna DOP",02,"Acqua",51),("Squacquerone di Romagna DOP",03,"Acido Lattico",1.7),
           ("Squacquerone di Romagna DOP",04,"Sali Minerali",1.2),("Squacquerone di Romagna DOP",05,"KJ",1680);
INSERT INTO ValoreProduzione
	VALUES (01,"pH",01,'2018-11-07 05:00:00',5),(01,"Acqua",02,'2018-11-07 06:00:00',50),(01,"Acido Lattico",03,'2018-11-07 07:00:00',0.9),(01,"Sali Minerali",04,'2018-11-07 08:00:00',1.2),
		   (01,"KJ",05,'2018-11-07 09:00:00',1665),(01,"pH",06,'2018-11-07 10:00:00',5.1),
		   (02,"pH",01,'2018-11-07 05:00:00',5.1),(02,"Acqua",02,'2018-11-07 06:00:00',51),(02,"Acido Lattico",03,'2018-11-07 07:00:00',1),(02,"Sali Minerali",04,'2018-11-07 08:00:00',1.4),
           (02,"KJ",05,'2018-11-07 09:00:00',1698),(02,"pH",06,'2018-11-07 10:00:00',4.9),
           (03,"pH",01,'2018-11-07 05:00:00',5),(03,"Acqua",02,'2018-11-07 06:00:00',33),(03,"Acido Lattico",03,'2018-11-07 07:00:00',1.3),(03,"Sali Minerali",04,'2018-11-07 08:00:00',4.1),
           (03,"KJ",05,'2018-11-07 09:00:00',1630),(03,"pH",06,'2018-11-07 10:00:00',5.2),
           (04,"pH",01,'2018-11-07 05:00:00',4.6),(04,"Acqua",02,'2018-11-07 06:00:00',44),(04,"Acido Lattico",03,'2018-11-07 07:00:00',2.1),(04,"Sali Minerali",04,'2018-11-07 08:00:00',3.7),
           (04,"KJ",05,'2018-11-07 09:00:00',1447),(04,"pH",06,'2018-11-07 10:00:00',5.1),
           (05,"pH",01,'2019-05-22 05:00:00',4.6),(05,"Acqua",02,'2019-05-22 06:00:00',43.7),(05,"Acido Lattico",03,'2019-05-22 07:00:00',2.35),(05,"Sali Minerali",04,'2019-05-22 08:00:00',3.67),
           (05,"KJ",05,'2019-05-22 09:00:00',1495),(05,"pH",06,'2019-05-22 10:00:00',5),
           (06,"pH",01,'2019-05-22 05:00:00',4.7),(06,"Acqua",02,'2019-05-22 06:00:00',45.3),(06,"Acido Lattico",03,'2019-05-22 07:00:00',2.28),(06,"Sali Minerali",04,'2019-05-22 08:00:00',3.8),
           (06,"KJ",05,'2019-05-22 09:00:00',1435),(06,"pH",06,'2019-05-22 10:00:00',5.2),
           (07,"pH",01,'2019-05-22 05:00:00',4.9),(07,"Acqua",02,'2019-05-22 06:00:00',51),(07,"Acido Lattico",03,'2019-05-22 07:00:00',0.97),(07,"Sali Minerali",04,'2019-05-22 08:00:00',1.18),
           (07,"KJ",05,'2019-05-22 09:00:00',1635),(07,"pH",06,'2019-05-22 10:00:00',5.3),
           (08,"pH",01,'2019-05-22 05:00:00',5.18),(08,"Acqua",02,'2019-05-22 06:00:00',35),(08,"Acido Lattico",03,'2019-05-22 07:00:00',1.26),(08,"Sali Minerali",04,'2019-05-22 08:00:00',4.32),
           (08,"KJ",05,'2019-05-22 09:00:00',1600),(08,"pH",06,'2019-05-22 10:00:00',5.29);
INSERT INTO Cantina(Agriturismo,Altezza,Lunghezza,Larghezza)
	VALUES ("Farmhouse",20,20,10),("Farmhouse",20,20,10);
INSERT INTO ScaffaleCantina
	VALUES (01,01,20),(02,01,20),(03,02,20),(04,02,20);
INSERT INTO ProdottiDaStagionare
	VALUES (05,01,'2019-05-30'),(06,03,'2019-05-30');
INSERT INTO Magazzino(Agriturismo,Altezza,Lunghezza,Larghezza)
	VALUES ("Farmhouse",20,20,10),("Farmhouse",20,20,10),("Farmhouse",20,20,10);
INSERT INTO ScaffaleMagazzino
	VALUES (01,01,20),(02,01,20),(03,02,20),(04,02,20),(05,03,20),(06,03,20);
INSERT INTO StoccaggioProdotti
	VALUES (03,04,'2018-11-10'),(08,06,'2019-05-30');
INSERT INTO SensoreCantina(Cantina,Marca,Modello)
	VALUES (01,"Sniff","Premium"),(02,"Sniff","Premium");
INSERT INTO StatoSensoreCantina
	VALUES (01,'2019-05-25 07:37:05',5,17,50),(01,'2019-02-23 07:24:56',5,17,50),(01,'2019-06-23 03:43:25',5,17,50),(01,'2019-02-15 03:28:00',5,17,50),(01,'2019-05-21 12:09:30',5,17,50),
		   (02,'2019-02-06 22:13:55',5,17,50),(02,'2019-05-09 07:18:22',5,17,50),(02,'2019-06-07 07:35:04',5,17,50),(02,'2019-04-02 04:04:24',5,17,50),(02,'2019-06-13 18:53:16',5,17,50);
INSERT INTO Cliente
	VALUES ("MGGLGU86R26E233Y","Luigi","Maggi","Via Sanzio 112",328894405),("PLOBTN69B06F951T","Bettino","Polo","Via Edolo 136",345810316),("PLDGDL56L14F116V","Gandolfo","Paladini","Piazza Lugano 136",33875491),
		   ("FDEMTR49S24D273B","Amintore","Fede","Piazza S. Marco 89",349925226),("FBALRA93C60E015L","Lara","Fabi","Via Donatello 98",33393698);
INSERT INTO Documento
	VALUES ("UI39380993","MGGLGU86R26E233Y","Carta d'identità",'2022-10-03',"Comune"),("OY66176867","PLOBTN69B06F951T","Carta d'identità",'2022-11-24',"Comune"),("VA38203496","PLDGDL56L14F116V","Carta d'identità",'2021-01-15',"Comune"),
		   ("RP57513187","FDEMTR49S24D273B","Carta d'identità",'2022-09-09',"Comune"),("SI84191932","FBALRA93C60E015L","Carta d'identità",'2020-10-25',"Comune");
INSERT INTO `Account`
	VALUES ("SuperLuigi","MGGLGU86R26E233Y","abcd123","Come ti chiami?","Luigi",'2019-01-01'),("Gandalf01","PLDGDL56L14F116V","abcd123","Come ti chiami?","Gandolfo",'2019-02-04');
INSERT INTO Pagamento(`Timestamp`,Importo)
	VALUES ('2019-01-10 12:00:00',60),('2019-02-15 12:00:00',145),('2019-02-22 09:00:00',30),('2019-01-02 9:00:00',3.79),('2019-01-21 9:00:00',3.79),('2019-02-10 9:00:00',1.5),('2019-07-07 9:00:00',8);
INSERT INTO CartaCredito
	VALUES (4056462753681961,'2022-11-30',334),(4539920468455358,'2022-09-30',362),(378578743246646,'2023-07-31',569);
INSERT INTO ArchivioCarte
	VALUES (01,4056462753681961),(03,378578743246646),(04,378578743246646),(05,378578743246646),(06,378578743246646),(07,378578743246646);
INSERT INTO PayPal
	VALUES (19297522176,02,"Gandalf01");
INSERT INTO PrenotazioneCamera(CodFiscale,DataPrenotazione,DataArrivo,DataPartenza)
	VALUES ("MGGLGU86R26E233Y",'2019-01-10','2019-01-15','2019-01-22'),("PLDGDL56L14F116V",'2019-02-15','2019-02-20','2019-02-27');
INSERT INTO Letto(Tipologia)
	VALUES ("Matrimoniale"),("Singolo"),("Reale"),("A castello"),("Singolo"),("A castello");
INSERT INTO Camera(Tipologia,Prezzo,Agriturismo)
	VALUES ("Semplice",60,"Farmhouse"),("Suite",120,"Farmhouse"),("Semplice",30,"Farmhouse"),("Semplice",30,"Farmhouse"),("Semplice",55,"Farmhouse"),("Semplice",55,"Farmhouse");
INSERT INTO DisposizioneLetto
	VALUES (01,01),(03,02),(02,03),(05,04),(04,05),(06,06);
INSERT INTO CamerePrenotate
	VALUES (01,01),(02,02);
INSERT INTO ServizioAggiuntivo
	VALUES ("Idromassaggio",02,'2019-02-20',25);
INSERT INTO Guida(Nome,Cognome)
	VALUES ("Sandra","Folliero"),("Manfredo","Bianchi");
INSERT INTO Escursione(Guida,Giorno,OraInizio,MaxPersone,Prezzo)
	VALUES (02,'2019-02-23','10:00',10,15);
INSERT INTO `Area`
	VALUES ("Piana Cieloterso","Farmhouse","Bella");
INSERT INTO PrenotazioneEscursione(CodFiscale,Escursione,Ricevuta,DataPrenotazione,DataEscursione,NumeroPersone)
	VALUES ("PLDGDL56L14F116V",01,03,'2019-02-20','2019-02-23',2);
INSERT INTO PercorsoEscursione
	VALUES (01,"Piana Cieloterso",120);
INSERT INTO DatiPagamentoC
	VALUES (01,01),(02,02);
INSERT INTO Ordine(CodFiscale,`Timestamp`,Ricevuta,Stato)
	VALUES ("MGGLGU86R26E233Y",'2019-01-02 9:00:00',04,"In processazione"),("MGGLGU86R26E233Y",'2019-01-21 9:00:00',05,"In processazione"),("MGGLGU86R26E233Y",'2019-02-10 9:00:00',06,"In processazione"),
		   ("MGGLGU86R26E233Y",'2019-07-07 9:00:00',07,"In processazione");
INSERT INTO AssegnazioneProdotti
	VALUES (01,01),(02,02),(03,04),(04,07);
INSERT INTO ContenutoOrdine
	VALUES (01,"Squacquerone di Romagna DOP",250,01),(02,"Squacquerone di Romagna DOP",250,1),(03,"Pecorino Toscano",100,1),(04,"Squacquerone di Romagna DOP",500,1);
INSERT INTO Spedizione(Ordine,DataConsegnaPrevista,DataConsegnaEffettiva,Stato)
	VALUES (01,'2019-01-04','2019-01-04',"Consegnato"),(02,'2019-01-23','2019-01-23',"Consegnato"),(03,'2019-02-12','2019-02-12',"Consegnato"),(04,'2019-07-07',null,"In corso");
INSERT INTO Tracciamento
	VALUES (04,'2019-07-07 9:00:00',"Livorno");
INSERT INTO Recensione
	VALUES (01,10,10,10,10,"Buono");
INSERT INTO Reso(Prodotto,MotivazioneReso,DataReso)
	VALUES (02,"Asciutto",'2019-01-24');
INSERT INTO ValoreReso
	VALUES (01,"Acqua",35);