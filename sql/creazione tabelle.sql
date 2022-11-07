drop schema if exists farmhouse;
create schema farmhouse;
use farmhouse;

-- Creazione di tutte le tabelle del database --
-- importante! per i sensori usare il tipo di dato datetime che ha sia data che ora

CREATE TABLE Agriturismo (
    NomeAgriturismo CHAR(50) NOT NULL,
    Indirizzo VARCHAR(255) NOT NULL,
    PartitaIVA BIGINT NOT NULL UNIQUE,
    Estensione INT NOT NULL,
    NumTelefono BIGINT NOT NULL,
    PRIMARY KEY (NomeAgriturismo)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Stalla (
    NumStalla INT AUTO_INCREMENT,
    Agriturismo CHAR(50) NOT NULL,
    Dimensione INT NOT NULL,
    Latitudine DOUBLE NOT NULL,
    Longitudine DOUBLE NOT NULL,
    PRIMARY KEY (NumStalla),
    CONSTRAINT vr6 FOREIGN KEY (Agriturismo)
        REFERENCES agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Locale (
    CodLocale INT AUTO_INCREMENT,
    Stalla INT NOT NULL,
    OrientamentoFinestre CHAR(50) NOT NULL,
    Larghezza DOUBLE NOT NULL,
    Lunghezza DOUBLE NOT NULL,
    Altezza DOUBLE NOT NULL,
    Pavimentazione CHAR(50) NOT NULL,
    PRIMARY KEY (CodLocale),
    CONSTRAINT vr3 FOREIGN KEY (stalla)
        REFERENCES stalla (NumStalla)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE specie (
    NomeSpecie CHAR(50) NOT NULL,
    AnimaliPerMQ DOUBLE NOT NULL,
    MangiatoiePerMQ DOUBLE NOT NULL,
    AbbeveratoiPerMQ DOUBLE NOT NULL,
    CondizionatoriPerMQ DOUBLE NOT NULL,
    PRIMARY KEY (NomeSpecie)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Animale (
    CodAnimale CHAR(50) NOT NULL,
    Specie CHAR(50) NOT NULL,
    Sesso CHAR(1) NOT NULL,
    Famiglia CHAR(50) NOT NULL,
    Razza CHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    Locale INT,
    PRIMARY KEY (CodAnimale),
    CONSTRAINT vr1 FOREIGN KEY (Locale)
        REFERENCES locale (CodLocale)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT vr2 FOREIGN KEY (Specie)
        REFERENCES specie (NomeSpecie)
        ON UPDATE NO ACTION ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE fornitore (
    PartitaIva BIGINT NOT NULL,
    RagioneSociale CHAR(50) NOT NULL,
    Nome CHAR(50) NOT NULL,
    Indirizzo VARCHAR(255) NOT NULL,
    PRIMARY KEY (PartitaIva)
)  ENGINE=INNODB , DEFAULT CHARSET=LATIN1;

CREATE TABLE acquisto (
    Animale CHAR(50) NOT NULL,
    Fornitore BIGINT NOT NULL,
    DataAcquisto DATE NOT NULL,
    Importo INT NOT NULL,
    DataArrivo DATE NOT NULL,
    PRIMARY KEY (Animale),
    CONSTRAINT vr4 FOREIGN KEY (Animale)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr5 FOREIGN KEY (Fornitore)
        REFERENCES fornitore (PartitaIva)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE zona (
    NomeZona CHAR(50),
    Agriturismo CHAR(50) NOT NULL,
    Estensione INT NOT NULL,
    PRIMARY KEY (NomeZona),
    CONSTRAINT vr7 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE recinzione (
    CodRecinzione INT AUTO_INCREMENT,
    LatitudineA DOUBLE NOT NULL,
    LongitudineA DOUBLE NOT NULL,
    LatitudineB DOUBLE NOT NULL,
    LongitudineB DOUBLE NOT NULL,
    PRIMARY KEY (CodRecinzione)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE geografiazone (
    Zona CHAR(50),
    Recinzione INT,
    PRIMARY KEY (Zona , Recinzione),
    CONSTRAINT vr8 FOREIGN KEY (Zona)
        REFERENCES Zona (NomeZona)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr9 FOREIGN KEY (Recinzione)
        REFERENCES Recinzione (CodRecinzione)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE foraggio (
    CodForaggio INT AUTO_INCREMENT,
    Fibre DOUBLE NOT NULL,
    Proteine DOUBLE NOT NULL,
    Glucidi DOUBLE NOT NULL,
    Piante INT NOT NULL,
    Cereali INT NOT NULL,
    Frutta INT NOT NULL,
    Conservazione CHAR(50) NOT NULL,
    PRIMARY KEY (CodForaggio)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE mangiatoia (
    CodMangiatoia INT AUTO_INCREMENT,
    Locale INT,
    Marca CHAR(50) NOT NULL,
    Modello CHAR(50) NOT NULL,
    Capacita INT NOT NULL,
    Foraggio INT,
    PRIMARY KEY (CodMangiatoia),
    CONSTRAINT vr10 FOREIGN KEY (Locale)
        REFERENCES Locale (CodLocale)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT vr11 FOREIGN KEY (Foraggio)
        REFERENCES Foraggio (CodForaggio)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE statomangiatoia (
    Mangiatoia INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    LivelloForaggio DOUBLE NOT NULL,
    Foraggio INT NOT NULL,
    PRIMARY KEY (Mangiatoia , `Timestamp`),
    CONSTRAINT vr12 FOREIGN KEY (Mangiatoia)
        REFERENCES mangiatoia (CodMangiatoia)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr13 FOREIGN KEY (Foraggio)
        REFERENCES foraggio (CodForaggio)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE sensorevisivo (
    CodSensoreV INT AUTO_INCREMENT,
    Marca CHAR(50) NOT NULL,
    Modello CHAR(50) NOT NULL,
    Locale INT,
    RichiestaPulizia CHAR(50),
    PRIMARY KEY (CodSensoreV),
    CONSTRAINT vr14 FOREIGN KEY (Locale)
        REFERENCES Locale (CodLocale)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE statosensorev (
    SensoreV INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    LivSporcizia INT NOT NULL,
    LivCompostiVolatili INT NOT NULL,
    PRIMARY KEY (SensoreV , `Timestamp`),
    CONSTRAINT vr15 FOREIGN KEY (SensoreV)
        REFERENCES sensorevisivo (CodSensoreV)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE condizionatore (
    CodCondizionatore INT AUTO_INCREMENT,
    Locale INT,
    Marca CHAR(50) NOT NULL,
    Modello CHAR(50) NOT NULL,
    PRIMARY KEY (CodCondizionatore),
    CONSTRAINT vr16 FOREIGN KEY (Locale)
        REFERENCES Locale (CodLocale)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE statocondizionatore (
    Condizionatore INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Temperatura DOUBLE NOT NULL,
    Luminosità DOUBLE NOT NULL,
    Umidità DOUBLE NOT NULL,
    PRIMARY KEY (Condizionatore , `Timestamp`),
    CONSTRAINT vr17 FOREIGN KEY (Condizionatore)
        REFERENCES Condizionatore (CodCondizionatore)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE abbeveratoio (
    CodAbbeveratoio INT AUTO_INCREMENT,
    Locale INT,
    Marca CHAR(50) NOT NULL,
    Modello CHAR(50) NOT NULL,
    Capacità INT NOT NULL,
    PRIMARY KEY (CodAbbeveratoio),
    CONSTRAINT vr18 FOREIGN KEY (Locale)
        REFERENCES Locale (CodLocale)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE integratore (
    Nome CHAR(50),
    Vitamine DOUBLE NOT NULL,
    SaliMinerali DOUBLE NOT NULL,
    PRIMARY KEY (Nome)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE statoabbeveratoio (
    Abbeveratoio INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    LivelloAcqua DOUBLE NOT NULL,
    Integratore CHAR(50),
    PRIMARY KEY (Abbeveratoio , `Timestamp`),
    CONSTRAINT vr19 FOREIGN KEY (Abbeveratoio)
        REFERENCES abbeveratoio (CodAbbeveratoio)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr20 FOREIGN KEY (Integratore)
        REFERENCES integratore (Nome)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE posizionegps (
    Animale CHAR(50),
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Latitudine DOUBLE NOT NULL,
    Longitudine DOUBLE NOT NULL,
    PRIMARY KEY (Animale , `Timestamp`),
    CONSTRAINT vr21 FOREIGN KEY (Animale)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE pascolo (
    Locale INT,
    `Data` DATE,
    OraInizio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DurataInMinuti INT NOT NULL,
    Zona CHAR(50) NOT NULL,
    PRIMARY KEY (Locale , `Data`),
    CONSTRAINT vr22 FOREIGN KEY (Locale)
        REFERENCES Locale (CodLocale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr23 FOREIGN KEY (Zona)
        REFERENCES Zona (NomeZona)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE veterinario (
    CodVeterinario INT AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(50) NOT NULL,
    Specializzazione CHAR(50) NOT NULL,
    PRIMARY KEY (CodVeterinario)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE riproduzione (
    CodRiproduzione INT AUTO_INCREMENT,
    CodPadre CHAR(50) NOT NULL,
    CodMadre CHAR(50) NOT NULL,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Veterinario INT NOT NULL,
    PRIMARY KEY (CodRiproduzione),
    CONSTRAINT vr24 FOREIGN KEY (CodMadre)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr25 FOREIGN KEY (CodPadre)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr26 FOREIGN KEY (Veterinario)
        REFERENCES Veterinario (CodVeterinario)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE gestazione (
    CodRiproduzione INT,
    Stato CHAR(50) NOT NULL,
    NumeroFeti INT NOT NULL DEFAULT 1,
    DataInizio DATE NOT NULL,
    DataFine DATE,
    Veterinario INT NOT NULL,
    PRIMARY KEY (CodRiproduzione),
    CONSTRAINT vr27 FOREIGN KEY (CodRiproduzione)
        REFERENCES Riproduzione (CodRiproduzione)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr28 FOREIGN KEY (Veterinario)
        REFERENCES Veterinario (CodVeterinario)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE visitacontrollo (
    CodVisita INT AUTO_INCREMENT,
    Animale CHAR(50) NOT NULL,
    Veterinario INT,
    Stato CHAR(50) NOT NULL,
    DataVisita DATE NOT NULL,
    PRIMARY KEY (CodVisita),
    CONSTRAINT vr29 FOREIGN KEY (Animale)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr30 FOREIGN KEY (Veterinario)
        REFERENCES Veterinario (CodVeterinario)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    INDEX vr39 (Animale , DataVisita)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE esame (
    CodEsame INT AUTO_INCREMENT,
    Visita INT NOT NULL,
    NomeEsame CHAR(50) NOT NULL,
    DataEsame DATE NOT NULL,
    DescrizioneTestuale VARCHAR(255) NOT NULL,
    Macchinario CHAR(50) NOT NULL,
    Veterinario INT NOT NULL,
    PRIMARY KEY (CodEsame),
    CONSTRAINT vr31 FOREIGN KEY (Visita)
        REFERENCES visitacontrollo (CodVisita)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr32 FOREIGN KEY (Veterinario)
        REFERENCES Veterinario (CodVeterinario)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE patologia (
    Nome CHAR(50),
    ParteCorpo CHAR(50) NOT NULL,
    Gravità INT NOT NULL,
    PRIMARY KEY (Nome)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE farmaco (
    Nome CHAR(50),
    DoseConsigliataInGrammi DOUBLE NOT NULL,
    Costo DOUBLE NOT NULL,
    PrincipioAttivo CHAR(50),
    PRIMARY KEY (Nome)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE terapia (
    CodTerapia INT AUTO_INCREMENT,
    Visita INT NOT NULL,
    Patologia CHAR(50) NOT NULL,
    DataInizio DATE NOT NULL,
    DurataInGiorni INT NOT NULL,
    Rimedio CHAR(50) NOT NULL,
    Veterinario INT NOT NULL,
    PRIMARY KEY (CodTerapia),
    CONSTRAINT vr33 FOREIGN KEY (Visita)
        REFERENCES visitacontrollo (CodVisita)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr34 FOREIGN KEY (Patologia)
        REFERENCES patologia (Nome)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr37 FOREIGN KEY (Veterinario)
        REFERENCES Veterinario (CodVeterinario)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

delimiter $$
create trigger vr35_36
	before insert on terapia for each row
begin
    if (new.Rimedio not in (
			select Nome
			from farmaco) and 
        new.Rimedio not in(
			select Nome
            from Integratore))
	then signal sqlstate "45000"
		set message_text = "Errore: rimedio non trovato";
	end if;
end $$
delimiter ;

CREATE TABLE posologia (
    Terapia INT,
    Giorno INT,
    Orario TIME,
    DosaggioInGrammi DOUBLE NOT NULL,
    PRIMARY KEY (Terapia , Giorno , Orario),
    CONSTRAINT vr38 FOREIGN KEY (Terapia)
        REFERENCES terapia (CodTerapia)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE parametrooggettivo (
    Animale CHAR(50),
    NomeParametro CHAR(50),
    DataRilevazione DATE,
    Valore DOUBLE NOT NULL,
    PRIMARY KEY (Animale , NomeParametro , DataRilevazione),
    CONSTRAINT vr39 FOREIGN KEY (Animale , dataRilevazione)
        REFERENCES visitacontrollo (Animale , DataVisita)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE lesione (
    Animale CHAR(50),
    Tipologia CHAR(50),
    DataRilevazione DATE,
    ParteCorpo CHAR(50) NOT NULL,
    Entità INT NOT NULL,
    PRIMARY KEY (Animale , Tipologia , DataRilevazione),
    CONSTRAINT vr40 FOREIGN KEY (Animale , dataRilevazione)
        REFERENCES visitacontrollo (Animale , DataVisita)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE disturbocomportamentale (
    Animale CHAR(50),
    Nome CHAR(50),
    DataRilevazione DATE,
    Entità INT NOT NULL,
    PRIMARY KEY (Animale , Nome , DataRilevazione),
    CONSTRAINT vr41 FOREIGN KEY (Animale , dataRilevazione)
        REFERENCES visitacontrollo (Animale , DataVisita)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE parametrigravidanza (
    CodRiproduzione INT,
    dataRilevazione DATE,
    LivVigilanza INT NOT NULL,
    LivDeambulazione INT NOT NULL,
    LucentezzaPelo CHAR(50) NOT NULL,
    TipoRespirazione CHAR(50) NOT NULL,
    LivIdratazione INT NOT NULL,
    PRIMARY KEY (CodRiproduzione , DataRilevazione),
    CONSTRAINT vr42 FOREIGN KEY (CodRiproduzione)
        REFERENCES gestazione (CodRiproduzione)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

delimiter $$
create trigger vr43
	before insert on parametrigravidanza for each row
begin
	select CodMadre into @madre
    from Riproduzione
    where CodRiproduzione = new.CodRiproduzione;
    if not exists(
		select *
        from visitacontrollo
        where Animale = @madre and
			dataVisita = new.DataRilevazione)
	then signal sqlstate '45000'
		set message_text = 'Errore';
	end if;
end $$
delimiter ;

CREATE TABLE quarantena (
    Animale CHAR(50),
    DataInizio DATE NOT NULL,
    Durata INT NOT NULL,
    PRIMARY KEY (Animale , DataInizio),
    CONSTRAINT vr44 FOREIGN KEY (Animale)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE nascita (
    Cucciolo CHAR(50),
    Gestazione INT,
    PRIMARY KEY (Cucciolo , Gestazione),
    CONSTRAINT vr46 FOREIGN KEY (Cucciolo)
        REFERENCES animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr47 FOREIGN KEY (Gestazione)
        REFERENCES gestazione (CodRiproduzione)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Mungitrice (
    CodMungitrice INT AUTO_INCREMENT,
    Agriturismo VARCHAR(50),
    Marca VARCHAR(50) NOT NULL,
    Modello VARCHAR(50) NOT NULL,
    Latitudine DOUBLE NOT NULL,
    Longitudine DOUBLE NOT NULL,
    PRIMARY KEY (CodMungitrice),
    CONSTRAINT vr48 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Silos (
    CodSilos INT AUTO_INCREMENT,
    Capacita INT NOT NULL,
    QuantitaAttuale INT NOT NULL,
    MediaProteine INT NOT NULL,
    MediaLipidi INT NOT NULL,
    MediaZuccheri INT NOT NULL,
    MediaVitamine INT NOT NULL,
    MediaMinerali INT NOT NULL,
    MediaEnzimi INT NOT NULL,
    PRIMARY KEY (CodSilos)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Mungitura (
    CodMungitura INT AUTO_INCREMENT,
    Mungitrice INT,
    Animale CHAR(50) NOT NULL,
    Silos INT DEFAULT NULL,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    VolumeLatte DOUBLE NOT NULL,
    Proteine DOUBLE NOT NULL,
    Enzimi DOUBLE NOT NULL,
    Lipidi DOUBLE NOT NULL,
    Zuccheri DOUBLE NOT NULL,
    Vitamine DOUBLE NOT NULL,
    Minerali DOUBLE NOT NULL,
    PRIMARY KEY (CodMungitura),
    CONSTRAINT vr49 FOREIGN KEY (Mungitrice)
        REFERENCES Mungitrice (CodMungitrice)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT vr50 FOREIGN KEY (Animale)
        REFERENCES Animale (CodAnimale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr51 FOREIGN KEY (Silos)
        REFERENCES Silos (CodSilos)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
    
CREATE TABLE Lotto (
    CodLotto INT AUTO_INCREMENT,
    `Data` DATE NOT NULL,
    CodLaboratorio INT NOT NULL,
    PRIMARY KEY (CodLotto)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE LatteUtilizzato (
    Lotto INT,
    Silos INT,
    QuantitaPrelevata INT NOT NULL,
    Proteine DOUBLE NOT NULL,
    Minerali DOUBLE NOT NULL,
    Lipidi DOUBLE NOT NULL,
    Zuccheri DOUBLE NOT NULL,
    Enzimi DOUBLE NOT NULL,
    Vitamine DOUBLE NOT NULL,
    PRIMARY KEY (Lotto , Silos),
    CONSTRAINT vr52 FOREIGN KEY (Lotto)
        REFERENCES Lotto (CodLotto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr53 FOREIGN KEY (Silos)
        REFERENCES Silos (CodSilos)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Dipendente (
    CodDipendente INT AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(50) NOT NULL,
    PRIMARY KEY (CodDipendente)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Impiegati (
    Lotto INT,
    Dipendente INT,
    PRIMARY KEY (Lotto , Dipendente),
    CONSTRAINT vr54 FOREIGN KEY (Lotto)
        REFERENCES Lotto (CodLotto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr55 FOREIGN KEY (Dipendente)
        REFERENCES Dipendente (CodDipendente)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Formaggio (
    Nome CHAR(50),
    Deperibilita CHAR(50) NOT NULL,
    ZonaGeografica CHAR(50) NOT NULL,
    LatteAlKG INT NOT NULL,
    PRIMARY KEY (Nome)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Formato (
    NomeFormaggio CHAR(50),
    Peso INT,
    Costo INT NOT NULL,
    PRIMARY KEY (NomeFormaggio , Peso),
    CONSTRAINT vr58 FOREIGN KEY (NomeFormaggio)
        REFERENCES Formaggio (Nome)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Prodotto (
    CodProdotto INT AUTO_INCREMENT,
    Lotto INT NOT NULL,
    NomeFormaggio CHAR(50) NOT NULL,
    PesoFormato INT NOT NULL,
    Peso INT NOT NULL,
    Stato CHAR(50) NOT NULL,
    DataScadenza DATE NOT NULL,
    PRIMARY KEY (CodProdotto),
    CONSTRAINT vr56 FOREIGN KEY (Lotto)
        REFERENCES Lotto (CodLotto)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr57 FOREIGN KEY (NomeFormaggio , PesoFormato)
        REFERENCES Formato (NomeFormaggio , Peso)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE FaseRicetta (
    Formaggio CHAR(50),
    NumeroFase INT,
    Durata CHAR(50) NOT NULL,
    Descrizione VARCHAR(255),
    PRIMARY KEY (Formaggio , NumeroFase),
    CONSTRAINT vr59 FOREIGN KEY (Formaggio)
        REFERENCES Formaggio (Nome)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX vr63 (NumeroFase)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ValoreIdealeRicetta (
    Formaggio CHAR(50),
    Fase INT,
    Nome CHAR(50),
    Valore INT NOT NULL,
    PRIMARY KEY (Formaggio , Fase , Nome),
    CONSTRAINT vr60 FOREIGN KEY (Formaggio , Fase)
        REFERENCES FaseRicetta (Formaggio , NumeroFase)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX vr62 (Nome)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ValoreProduzione (
    Prodotto INT,
    Nome CHAR(50),
    NumeroFase INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Valore INT NOT NULL,
    PRIMARY KEY (Prodotto , Nome , NumeroFase),
    CONSTRAINT vr61 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr62 FOREIGN KEY (Nome)
        REFERENCES ValoreIdealeRicetta (Nome)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr63 FOREIGN KEY (NumeroFase)
        REFERENCES FaseRicetta (NumeroFase)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Cantina (
    CodCantina INT AUTO_INCREMENT,
    Agriturismo CHAR(50) NOT NULL,
    Altezza INT NOT NULL,
    Lunghezza INT NOT NULL,
    Larghezza INT NOT NULL,
    PRIMARY KEY (CodCantina),
    CONSTRAINT vr67 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ScaffaleCantina (
    CodScaffale INT AUTO_INCREMENT,
    Cantina INT NOT NULL,
    Capacita INT NOT NULL,
    PRIMARY KEY (CodScaffale),
    CONSTRAINT vr66 FOREIGN KEY (Cantina)
        REFERENCES Cantina (CodCantina)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ProdottiDaStagionare (
    Prodotto INT,
    Scaffale INT,
    DataInizioStagionatura DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Prodotto , Scaffale),
    CONSTRAINT vr64 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr65 FOREIGN KEY (Scaffale)
        REFERENCES ScaffaleCantina (CodScaffale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Magazzino (
    CodMagazzino INT AUTO_INCREMENT,
    Agriturismo CHAR(50) NOT NULL,
    Altezza INT NOT NULL,
    Lunghezza INT NOT NULL,
    Larghezza INT NOT NULL,
    PRIMARY KEY (CodMagazzino),
    CONSTRAINT vr71 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ScaffaleMagazzino (
    CodScaffale INT AUTO_INCREMENT,
    Magazzino INT NOT NULL,
    Capacita INT NOT NULL,
    PRIMARY KEY (CodScaffale),
    CONSTRAINT vr70 FOREIGN KEY (Magazzino)
        REFERENCES Magazzino (CodMagazzino)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE StoccaggioProdotti (
    Prodotto INT,
    Scaffale INT,
    DataStoccaggio DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Prodotto , Scaffale),
    CONSTRAINT vr68 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr69 FOREIGN KEY (Scaffale)
        REFERENCES ScaffaleMagazzino (CodScaffale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE SensoreCantina (
    CodSensoreC INT AUTO_INCREMENT,
    Cantina INT NOT NULL,
    Marca CHAR(50) NOT NULL,
    Modello CHAR(50) NOT NULL,
    PRIMARY KEY (CodSensoreC),
    CONSTRAINT vr72 FOREIGN KEY (Cantina)
        REFERENCES Cantina (CodCantina)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE StatoSensoreCantina (
    SensoreC INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Ventilazione INT NOT NULL,
    Temperatura INT NOT NULL,
    Umidita INT NOT NULL,
    PRIMARY KEY (SensoreC , `Timestamp`),
    CONSTRAINT vr73 FOREIGN KEY (SensoreC)
        REFERENCES SensoreCantina (CodSensoreC)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Cliente (
    CodFiscale VARCHAR(16),
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(50) NOT NULL,
    Indirizzo VARCHAR(255) NOT NULL,
    Telefono INT NOT NULL,
    PRIMARY KEY (CodFiscale)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Documento (
    CodDocumento VARCHAR(50),
    CodFiscale VARCHAR(16) NOT NULL,
    Tipologia CHAR(50) NOT NULL,
    Scadenza DATE NOT NULL,
    EnteRilascio CHAR(50) NOT NULL,
    PRIMARY KEY (CodDocumento),
    CONSTRAINT vr90 FOREIGN KEY (CodFiscale)
        REFERENCES Cliente (CodFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE `Account` (
    Username VARCHAR(50),
    CodFiscale VARCHAR(16) NOT NULL,
    `Password` VARCHAR(50) NOT NULL,
    DomandaSicurezza VARCHAR(255) NOT NULL,
    Risposta VARCHAR(255) NOT NULL,
    DataIscrizione DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Username),
    CONSTRAINT vr91 FOREIGN KEY (CodFiscale)
        REFERENCES Cliente (CodFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Pagamento (
    CodRicevuta INT AUTO_INCREMENT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Importo INT NOT NULL,
    PRIMARY KEY (CodRicevuta)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE CartaCredito (
    CodCarta bigINT,
    Scadenza DATE NOT NULL,
    CVV INT NOT NULL,
    PRIMARY KEY (CodCarta)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ArchivioCarte (
    Ricevuta INT,
    Carta bigINT,
    PRIMARY KEY (Ricevuta , Carta),
    CONSTRAINT vr92 FOREIGN KEY (Ricevuta)
        REFERENCES Pagamento (CodRicevuta)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr93 FOREIGN KEY (Carta)
        REFERENCES CartaCredito (CodCarta)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE PayPal (
    IdTransazione BIGINT,
    Ricevuta INT NOT NULL,
    NomeUtente VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdTransazione),
    CONSTRAINT vr94 FOREIGN KEY (Ricevuta)
        REFERENCES Pagamento (CodRicevuta)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE PrenotazioneCamera (
    CodPrenotazioneC INT AUTO_INCREMENT,
    CodFiscale VARCHAR(16) NOT NULL,
    DataPrenotazione DATE NOT NULL,
    DataArrivo DATE NOT NULL,
    DataPartenza DATE NOT NULL,
    PRIMARY KEY (CodPrenotazioneC),
    CONSTRAINT vr74 FOREIGN KEY (CodFiscale)
        REFERENCES Cliente (CodFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Letto (
    CodLetto INT AUTO_INCREMENT,
    Tipologia CHAR(50) NOT NULL,
    PRIMARY KEY (CodLetto)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Camera (
    CodCamera INT AUTO_INCREMENT,
    Tipologia CHAR(50) NOT NULL,
    Prezzo INT NOT NULL,
    Agriturismo CHAR(50) NOT NULL,
    PRIMARY KEY (CodCamera),
    CONSTRAINT vr79 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE DisposizioneLetto (
    Letto INT,
    Camera INT,
    PRIMARY KEY (Letto , Camera),
    CONSTRAINT vr77 FOREIGN KEY (Letto)
        REFERENCES Letto (CodLetto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr78 FOREIGN KEY (Camera)
        REFERENCES Camera (CodCamera)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE CamerePrenotate (
    Camera INT,
    Prenotazione INT,
    PRIMARY KEY (Camera , Prenotazione),
    CONSTRAINT vr80 FOREIGN KEY (Camera)
        REFERENCES Camera (CodCamera)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr81 FOREIGN KEY (Prenotazione)
        REFERENCES PrenotazioneCamera (CodPrenotazioneC)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ServizioAggiuntivo (
    Nome CHAR(50),
    Camera INT,
    DataInizio DATE,
    Prezzo INT NOT NULL,
    PRIMARY KEY (Nome , Camera , DataInizio),
    CONSTRAINT vr82 FOREIGN KEY (Camera)
        REFERENCES Camera (CodCamera)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Guida (
    CodGuida INT AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(50) NOT NULL,
    PRIMARY KEY (CodGuida)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Escursione (
    CodEscursione INT AUTO_INCREMENT,
    Guida INT,
    Giorno DATE NOT NULL,
    OraInizio TIME NOT NULL,
    MaxPersone INT NOT NULL,
    Prezzo INT NOT NULL,
    PRIMARY KEY (CodEscursione),
    CONSTRAINT vr83 FOREIGN KEY (Guida)
        REFERENCES Guida (CodGuida)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE `Area` (
    NomeArea CHAR(50),
    Agriturismo CHAR(50) NOT NULL,
    Descrizione VARCHAR(255) NOT NULL,
    PRIMARY KEY (NomeArea),
    CONSTRAINT vr84 FOREIGN KEY (Agriturismo)
        REFERENCES Agriturismo (NomeAgriturismo)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE PrenotazioneEscursione (
    CodPrenotazioneE INT AUTO_INCREMENT,
    CodFiscale VARCHAR(16) NOT NULL,
    Escursione INT NOT NULL,
    Ricevuta INT,
    DataPrenotazione DATE NOT NULL,
    DataEscursione DATE NOT NULL,
    NumeroPersone INT NOT NULL,
    PRIMARY KEY (CodPrenotazioneE),
    CONSTRAINT vr75 FOREIGN KEY (CodFiscale)
        REFERENCES Cliente (CodFiscale)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr76 FOREIGN KEY (Escursione)
        REFERENCES Escursione (CodEscursione)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr89 FOREIGN KEY (Ricevuta)
        REFERENCES Pagamento (CodRicevuta)
        ON UPDATE CASCADE ON DELETE SET NULL
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE PercorsoEscursione (
    Escursione INT,
    `Area` CHAR(50),
    Durata INT NOT NULL,
    PRIMARY KEY (Escursione , `Area`),
    CONSTRAINT vr85 FOREIGN KEY (Escursione)
        REFERENCES Escursione (CodEscursione)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr86 FOREIGN KEY (`Area`)
        REFERENCES `Area` (NomeArea)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE DatiPagamentoC (
    Prenotazione INT,
    Ricevuta INT,
    PRIMARY KEY (Prenotazione , Ricevuta),
    CONSTRAINT vr87 FOREIGN KEY (Prenotazione)
        REFERENCES PrenotazioneCamera (CodPrenotazioneC)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr88 FOREIGN KEY (Ricevuta)
        REFERENCES Pagamento (CodRicevuta)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Ordine (
    CodOrdine INT AUTO_INCREMENT,
    CodFiscale CHAR(16) NOT NULL,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Ricevuta INT,
    Stato CHAR(50) NOT NULL DEFAULT 'in processazione',
    PRIMARY KEY (CodOrdine),
    CONSTRAINT vr95 FOREIGN KEY (Ricevuta)
        REFERENCES Pagamento (CodRicevuta)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT vr105 FOREIGN KEY (CodFiscale)
        REFERENCES `Account` (codFiscale)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE AssegnazioneProdotti (
    Ordine INT,
    Prodotto INT,
    PRIMARY KEY (Ordine , Prodotto),
    CONSTRAINT vr96 FOREIGN KEY (Ordine)
        REFERENCES Ordine (CodOrdine)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr97 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ContenutoOrdine (
    Ordine INT,
    NomeFormaggio CHAR(50),
    Peso INT,
    Quantita INT NOT NULL,
    PRIMARY KEY (Ordine , NomeFormaggio , Peso),
    CONSTRAINT vr98 FOREIGN KEY (Ordine)
        REFERENCES Ordine (CodOrdine)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vr99 FOREIGN KEY (NomeFormaggio , Peso)
        REFERENCES Formato (NomeFormaggio , Peso)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Spedizione (
    CodSpedizione INT AUTO_INCREMENT,
    Ordine INT NOT NULL,
    DataConsegnaPrevista DATE NOT NULL,
    DataConsegnaEffettiva DATE,
    Stato CHAR(50) NOT NULL DEFAULT 'Spedita',
    PRIMARY KEY (CodSpedizione),
    CONSTRAINT vr100 FOREIGN KEY (Ordine)
        REFERENCES Ordine (CodOrdine)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Tracciamento (
    Spedizione INT,
    `Timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    Hub VARCHAR(255) NOT NULL,
    PRIMARY KEY (Spedizione , `Timestamp`),
    CONSTRAINT vr101 FOREIGN KEY (Spedizione)
        REFERENCES Spedizione (CodSpedizione)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Recensione (
    Prodotto INT,
    Conservazione INT NOT NULL,
    Gusto INT NOT NULL,
    Qualita INT NOT NULL,
    Gradimento INT NOT NULL,
    Testo VARCHAR(255),
    PRIMARY KEY (Prodotto),
    CONSTRAINT vr102 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE Reso (
    CodReso INT AUTO_INCREMENT,
    Prodotto INT NOT NULL,
    MotivazioneReso VARCHAR(255) NOT NULL,
    DataReso DATE,
    PRIMARY KEY (CodReso),
    CONSTRAINT vr103 FOREIGN KEY (Prodotto)
        REFERENCES Prodotto (CodProdotto)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE ValoreReso (
    CodReso INT,
    Nome CHAR(50),
    Valore INT NOT NULL,
    PRIMARY KEY (CodReso , Nome),
    CONSTRAINT vr104 FOREIGN KEY (CodReso)
        REFERENCES Reso (CodReso)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;