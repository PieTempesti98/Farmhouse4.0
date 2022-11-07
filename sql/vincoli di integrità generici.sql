delimiter $$
drop trigger if exists vg1$$
drop trigger if exists vg2_m$$
drop trigger if exists vg2_c$$
drop trigger if exists vg2_a$$
drop event if exists vg3$$
drop trigger if exists vg4$$
drop trigger if exists vg5$$
drop trigger if exists vg6$$
drop trigger if exists vg7$$
drop trigger if exists vg8$$
drop trigger if exists vg9$$
drop trigger if exists vg10$$
drop trigger if exists vg11$$
drop trigger if exists vg12$$
drop trigger if exists vg13$$
drop trigger if exists vg14$$
drop trigger if exists vg15$$
drop trigger if exists vg16$$

create trigger vg1 
before insert on animale for each row 
begin
	if exists(
		select *
        from animale
        where Locale = new.Locale)
	then if new.Specie <> (
				select distinct Specie
                from animale
                where Locale = new.Locale)
		then signal sqlstate '45000'
			set message_text = 'Errore: locale adibito ad altra specie';
		end if;
	end if;
end$$

create trigger vg2_m
before insert on mangiatoia for each row
begin
	select distinct Specie into @specie
    from animale
    where Locale = new.Locale;

	if (
			(
			select MangiatoiePerMQ
			from Specie
			where NomeSpecie = @specie
            ) 
		*	
			(
            select Lunghezza * Larghezza as Dimensione
            from Locale
            where CodLocale = new.Locale
            ) 
		) < 
        (
			select count(*) + 1
            from Mangiatoia
            where Locale = new.Locale
		)
        then signal sqlstate '45000'
			set message_text = 'Errore: numero massimo di mangiatoie raggiunto';
	end if;
end $$

create trigger vg2_a
before insert on abbeveratoio for each row
begin
	select distinct Specie into @specie
    from animale
    where Locale = new.Locale;

	if (
			(
			select AbbeveratoiPerMQ
			from Specie
			where NomeSpecie = @specie
            ) 
		*	
			(
            select Lunghezza * Larghezza as DImensione
            from Locale
            where CodLocale = new.Locale
            ) 
		) <
        (
			select count(*) + 1
            from Abbeveratoio
            where Locale = new.Locale
		)
        then signal sqlstate '45000'
			set message_text = 'Errore: numero massimo di abbeveratoi raggiunto';
	end if;
end $$

create trigger vg2_c
before insert on condizionatore for each row
begin
	select distinct Specie into @specie
    from animale
    where Locale = new.Locale;

	if (
			(
			select CondizionatoriPerMQ
			from Specie
			where NomeSpecie = @specie
            ) 
		*	
			(
            select Lunghezza * Larghezza as DImensione
            from Locale
            where CodLocale = new.Locale
            ) 
		) <
        (
			select count(*) + 1
            from Condizionatore
            where Locale = new.Locale
		)
        then signal sqlstate '45000'
			set message_text = 'Errore: numero massimo di condizionatori raggiunto';
	end if;
end $$

create event vg3
on schedule every 3 hour
starts '2019-07-08 00:00'
do
begin
	declare finito int;
    declare mang int;
    declare us datetime;
    declare foraggio int;
	declare UltimaRilevazione cursor for
		select Mangiatoia, max(Timestamp) as ultimostato, Foraggio
        from statomangiatoia
        group by Mangiatoia;
	declare continue handler for not found
		set finito = 1;

	set finito = 0;
	open UltimaRilevazione;
    controllo: loop
		fetch UltimaRilevazione into mang, us, foraggio;
        if 
			finito = 1
        then 
			leave controllo;
        end if;
        if
			us < current_timestamp() - interval 6 hour
		then 
			insert into statomangiatoia values(
				mang, current_timestamp(), 0, foraggio);
		else iterate controllo;
		end if;
	end loop;
end $$

create trigger vg4
	after insert on statosensorev for each row
begin
	if (
		new.livsporcizia > 80 or
        new.LivCompostiVolatili > 80
	)
    then 
		update sensorevisivo
        set RichiestaPulizia = 'Richiesta effettuata'
        where CodSensoreV = new.SensoreV;
	else
		update sensorevisivo
        set RichiestaPulizia = ''
        where CodSensoreV = new.SensoreV;
	end if;
end $$

create trigger vg5
	after insert on visitacontrollo for each row
begin
	if 
		new.Stato = 'Negativo'
	then 
		if
			exists	(select t.Patologia
				from Terapia t
				where t.visita in (
						select CodVisita
						from visitacontrollo
						where animale = new.Animale) and
					exists (
						select *
						from terapia t2
						where t2.visita in (
								select CodVisita
								from visitacontrollo
								where Animale = new.Animale) and
							t2.Patologia = t.Patologia and
							not exists (
								select *
                                from terapia t3
                                where t3.visita in (
										select CodVisita
                                        from visitacontrollo
                                        where Animale =new.Animale) and
									t3.DataInizio between t.DataInizio and t2.DataInizio)
                                    )
								)
				then insert into Quarantena(Animale, DataInizio) values(
					new.Animale, current_date()); 
		end if;
	end if;
end $$

create trigger vg6 -- Alla base della prima operazione sui dati
	before insert on mungitura for each row
begin
	-- Calcolo del valore di affinità 
	set @rankmungitura = (((new.Proteine * 3) + (new.Enzimi * 2) + new.Lipidi + new.Zuccheri + (new.Vitamine * 2) + new.Minerali)/10);
   
   -- Scelta del silos più adeguato 
if not exists(
	select *
    from Silos
    where QuantitaAttuale > 0 and
		ABS(((MediaProteine * 3 + MediaLipidi + MediaEnzimi * 2 + MediaZuccheri + MediaVitamine * 2 + MediaMinerali) / 10) - @rankMungitura) > 0.5) and
	exists (
		select *
        from Silos
        where quantitaattuale = 0)
then
	select CodSilos into @silostarget
    from Silos
    where QuantitaAttuale = 0
    limit 1;
else
	SELECT 
		CodSilos
	INTO @silosTarget FROM
		Silos
	WHERE
		Capacita - QuantitaAttuale > new.VolumeLatte
	GROUP BY CodSilos
	HAVING MIN(ABS(((MediaProteine * 3 + MediaLipidi + MediaEnzimi * 2 + MediaZuccheri + MediaVitamine * 2 + MediaMinerali) / 10) - @rankMungitura))
    limit 1;
    
end if;
   -- Aggiornamento del silos di destinazione
SET 
    new.Silos = @silosTarget;
    -- Aggiornamento della ridondanza - aggiunta del latte al silos
UPDATE silos s 
SET 
    MediaProteine = (s.MediaProteine * s.QuantitaAttuale + new.VolumeLatte * new.Proteine) / (s.QuantitaAttuale + new.VolumeLatte),
    MediaEnzimi = (s.MediaEnzimi * s.QuantitaAttuale + new.VolumeLatte * new.Enzimi) / (s.QuantitaAttuale + new.VolumeLatte),
    MediaLipidi = (s.MediaLipidi * s.QuantitaAttuale + new.VolumeLatte * new.Lipidi) / (s.QuantitaAttuale + new.VolumeLatte),
    MediaZuccheri = (s.MediaZuccheri * s.QuantitaAttuale + new.VolumeLatte * new.Zuccheri) / (s.QuantitaAttuale + new.VolumeLatte),
    MediaVitamine = (s.MediaVitamine * s.QuantitaAttuale + new.VolumeLatte * new.Vitamine) / (s.QuantitaAttuale + new.VolumeLatte),
    MediaMinerali = (s.MediaMinerali * s.QuantitaAttuale + new.VolumeLatte * new.Minerali) / (s.QuantitaAttuale + new.VolumeLatte),
    QuantitaAttuale = s.QuantitaAttuale + new.VolumeLatte
WHERE
    codSilos = new.Silos;
end $$

create trigger vg7
	before insert on latteutilizzato for each row
begin
	declare prot double;
    declare mine double;
    declare vita double;
    declare enzi double;
    declare lipi double;
    declare zucc double;
    declare quan double;
    declare rankValori double;
    declare silosTarget char(50);
    if new.QuantitaPrelevata > (
		select QuantitaAttuale
        from Silos
        where CodSilos = new.Silos)
	then 
		if exists(
			select *
			from Silos 
			where QuantitaAttuale >= new.QuantitaPrelevata)
		then
			select CodSilos into @SilosTarget
            from Silos
            where QuantitaAttuale >= new.QuantitaPrelevata
            limit 1;
            
            set new.Silos = @SilosTarget;
		else 
			signal sqlstate '45000'
			set message_text = 'Errore: quantità di latte insufficiente';
		end if;
	end if;
	if exists(
		select *
        from latteutilizzato
        where lotto = new.Lotto)
	then 
		set rankValori = (((new.Proteine * 3) + (new.Enzimi * 2) + new.Lipidi + new.Zuccheri + (new.Vitamine * 2) + new.Minerali)/10);
		
        select Proteine, Minerali, Vitamine, Enzimi, Lipidi, Zuccheri, QuantitaPrelevata into prot, mine, vita, enzi, lipi, zucc, quan
        from latteutilizzato
        where lotto = new.Lotto;
		
        if abs( rankValori - ((prot * 3 + mine + vita * 2 + enzi * 2 + lipi + zucc)/10) )
			> any (
            select ABS(((MediaProteine * 3 + MediaLipidi + MediaEnzimi * 2 + MediaZuccheri + MediaVitamine * 2 + MediaMinerali) / 10) - rankValori)
            from silos 
            where new.QuantitaPrelevata > QuantitaAttuale
            )
		then 
			SELECT 
				CodSilos, MediaProteine, MediaLipidi, MediaEnzimi, MediaZuccheri, MediaVitamine, MediaMinerali
			INTO silosTarget, prot, lipi,enzi, zucc, vita, mine FROM
				Silos
			WHERE
				Capacita - QuantitaAttuale > new.QuantitaPrelevata
			GROUP BY CodSilos
			HAVING MIN(ABS(((MediaProteine * 3 + MediaLipidi + MediaEnzimi * 2 + MediaZuccheri + MediaVitamine * 2 + MediaMinerali) / 10) - rankValori));
            set new.Silos = SilosTarget;
            set new.Proteine = prot;
			set new.Minerali = mine;
            set new.Vitamine = vita;
            set new.Lipidi = lipi;
            set new.Enzimi = enzi;
            set new.Zuccheri = zucc;
		end if;
	end if;
end $$

create trigger vg8
	before insert on prodotto for each row
begin
	declare scadenza date;
	if exists (
		select *
        from prodotto
        where Lotto = new.Lotto and
			NomeFormaggio = new.NomeFormaggio
		)
	then 
		select distinct DataScadenza into scadenza
        from prodotto
        where Lotto = new.Lotto and
			NomeFormaggio = new.NomeFormaggio and
            CodProdotto <> new.CodProdotto;
		if
			scadenza <> new.DataScadenza
		then
			set new.DataScadenza = scadenza;
		end if;
	end if;
end $$

create trigger vg9
	before insert on prodottidastagionare for each row
begin
	declare finito int default 0;
    declare scaf char(50);
	declare scaffali cursor for
		select Scaffale
		from prodottidastagionare
		where Prodotto in (
			select CodProdotto
			from Prodotto
			where lotto = (
				select Lotto
				from Prodotto
				where codProdotto = new.Prodotto)
			)
		order by Scaffale;
	declare continue handler for not found
		set finito = 1;
   
	set @scaftarget = null;
    open scaffali; 
    
	controllo : loop
		fetch scaffali into scaf;
        if scaf = new.Scaffale 
        then
			set @scafTarget = null;
			leave controllo;
        end if;
        if finito = 1 
        then leave controllo;
        end if;
        
        if
			(
				select count(*)
                from prodottidastagionare
                where Scaffale = scaf
			) < (
				select Capacita
				from ScaffaleCantina
                where CodScaffale = scaf
			)
		then 
			if @scaftarget = null
            then set @scafTarget = scaf;
            end if;
         end if;
	end loop;
    if @scaftarget <> null
    then 
        set new.Scaffale = @scaftarget;
	end if;
	update prodotto
    set stato = 'In stagionatura'
    where CodProdotto = new.Prodotto;
end $$

create trigger vg10
	before insert on stoccaggioprodotti for each row
begin
	declare finito int default 0;
    declare scaf char(50);
	declare scaffali cursor for
		select Scaffale
		from stoccaggioprodotti
		where Prodotto in (
			select CodProdotto
			from Prodotto
			where lotto = (
				select Lotto
				from Prodotto
				where codProdotto = new.Prodotto)
			)
		order by Scaffale;
	declare continue handler for not found
		set finito = 1;
   
	set @scaftarget = null;
    open scaffali; 
    
	controllo : loop
		fetch scaffali into scaf;
        if scaf = new.Scaffale 
        then
			set @scafTarget = null;
			leave controllo;
        end if;
        if finito = 1 
        then leave controllo;
        end if;
        
        if
			(
				select count(*)
                from stoccaggioprodotti
                where Scaffale = scaf
			) < (
				select Capacita
				from ScaffaleMagazzino
                where CodScaffale = scaf
			)
		then 
			if @scaftarget = null
            then set @scafTarget = scaf;
            end if;
         end if;
	end loop;
    if @scaftarget <> null
    then 
        set new.Scaffale = @scaftarget;
	end if;
    update prodotto
    set stato = 'Stoccato'
    where CodProdotto = new.Prodotto;
    if exists 
		(
		select *
        from Ordine o
        where o.Stato = 'pendente' and
			(
           o.codOrdine in (
				select Ordine
                from ContenutoOrdine
                where NomeFormaggio = (
					select NomeFormaggio 
                    from Prodotto
                    where CodProdotto = new.Prodotto)
                    and Peso =  (
					select PesoFormato 
                    from Prodotto
                    where CodProdotto = new.Prodotto)
				) and not exists
			( select *
            from assegnazioneProdotti
            where Ordine = o.CodOrdine and
				Prodotto in (
					select CodProdotto
                    from Prodotto 
                     where NomeFormaggio = (
					select NomeFormaggio 
                    from Prodotto
                    where CodProdotto = new.Prodotto)
				and PesoFormato =  (
					select PesoFormato 
                    from Prodotto
                    where CodProdotto = new.Prodotto)))))
		then 
			select CodOrdine, NomeFormato, Peso, Quantita into @ord, @nf, @p, @q
            from Ordine o inner join ContnutoOrdine c on (o.CodOrdine = c.Ordine)
            where NomeFormaggio = (
					select NomeFormaggio 
                    from Prodotto
                    where CodProdotto = new.Prodotto)
				and Peso = (
					select PesoFormato 
                    from Prodotto
                    where CodProdotto = new.Prodotto);
			call GestioneOrdine(@ord, @nf, @p, @q);
	end if;
end $$

create trigger vg11
	before insert on datipagamentoc for each row
begin
	if 
		new.Prenotazione in (
			select CodPrenotazioneC
            from prenotazionecamera
            where CodFiscale not in (
				select CodFiscale
                from `account`
                )
			)
	then 
		if 
			new.ricevuta not in (
				select Ricevuta 
                from ArchivioCarte 
                union 
                select ricevuta 
                from PayPal)
		then 
			signal sqlstate '45000'
			set message_text = 'Errore: avvenuto pagamento in contanti da parte di un cliente non registrato';
		end if;
	end if;
end $$

create trigger vg12
	before insert on disposizioneletto for each row
begin
	if new.Camera in
		(select CodCamera
        from Camera
        where Tipologia = 'Semplice'
		) and exists (
			select *
            from disposizioneletto
            where Camera = new.Camera)
	then
		signal sqlstate '45000'
        set message_text = 'Errore: in questa camera semplice è già presente un letto';
	end if;
end $$

create trigger vg13
	before insert on servizioaggiuntivo for each row
begin
	if 
		new.Camera not in (
			select CodCamera
			from Camera
			where Tipologia = 'Suite'
			)
    then
		signal sqlstate '45000'
        set message_text = 'Errore: le camere semplici non possono prenotare servizi aggiuntivi';
	end if;
end $$

create trigger vg14
	before insert on prenotazioneescursione for each row
begin
	if 
		(((
			select MaxPersone
			from Escursione
            where CodEscursione = new.Escursione
		) - (
			select count(NumeroPersone)
            from prenotazioneescursione
            where Escursione = new.Escursione and
				new.dataEscursione = DataEscursione
		)) < new.NumeroPersone) or (
			new.DataPrenotazione > new.DataEscursione - interval 2 day)
	then
		signal sqlstate '45000'
        set message_text = 'Le prenotazioni per la escursione selezionata sono chiuse';
	end if;
end $$

drop procedure if exists GestioneOrdine $$
create procedure GestioneOrdine(
	in _Ordine int,
	in _NomeFormaggio char(50),
	in _Peso int,
    in _Quantita int)
begin
	if (
		select count(*)
		from StoccaggioProdotti
        where Prodotto in (
			select CodProdotto
            from Prodotto
            where NomeFormaggio = _NomeFormaggio and
				PesoFormato = _Peso)
		) < _Quantita
	then
		update Ordine
        set Stato = 'pendente'
        where CodOrdine = _Ordine;
	else 
		create temporary table ProdottiDaSpedire (
			Prodotto int,
            Classifica int
		);
        
       insert into ProdottiDaSpedire 
        select sp.Prodotto, row_number() over() as Priorita
        from StoccaggioProdotti sp  inner join Prodotto p on (sp.prodotto = p.CodProdotto)
		where p.NomeFormaggio = _NomeFormaggio and
			p.PesoFormato = _Peso and
            Priorita <= _Quantita
		order by p.DataScadenza desc;
        
		insert into AssegnazioneProdotti
        select Prodotto, _Ordine
        from ProdottiDaSpedire;
        update Prodotto
        set stato = 'spedito'
        where CodProdotto in (
			select Prosotto
            from ProdottiDaSpedire);
        update Ordine
        set Stato = 'In Processazione'
        where CodOrdine = _Ordine;
    end if;
    if (
		select count(distinct p.NomeFormaggio, p.PesoFormato)
        from assegnazioneprodotti a inner join prodotto p on p.CodProdotto = a.Prodotto
        where Ordine = _Ordine) = (
			Select count(*)
            from contenutoOrdine
            where Ordine = _Ordine)
	then
		update ordine
        set stato = 'In preparazione'
        where CodOrdine = _Ordine;
	end if;
        
end $$

create trigger vg15
	after insert on contenutoordine for each row
call GestioneOrdine( new.Ordine, new.NomeFormaggio, new.Peso, new.Quantita) $$

drop trigger if exists avviospedizioni $$
create trigger AvvioSpedizioni
	after insert on spedizione for each row
		update Ordine
        set Stato = 'spedito'
        where codOrdine = new.Ordine $$

drop trigger if exists evasionespedizione$$
create trigger evasionespedizione
	after update on spedizione for each row
begin
	if new.DataConsegnaEffettiva is not null
    then
		update Ordine
        set Stato = 'Evaso'
        where CodOrdine = new.Ordine;
        update spedizione
        set Stato = 'Consegnata'
        where CodSpedizione = new.CodSpedizione;
	end if;
end $$

drop trigger if exists statispedizione $$
create trigger statispedizione
	after insert on Tracciamento for each row
update spedizione 
set Stato = 'In Transito'
where CodSpedizione = new.Spedizione$$

create trigger vg16
	before insert on Reso for each row
begin
	if(
		select s.DataConsegnaEffettiva
        from Spedizione s natural join assegnazioneProdotti ap
        where ap.Prodotto = new.Prodotto
	) < new.dataReso - interval 2 day
    then
		signal sqlstate '45000'
        set message_text = 'Errore: il reso non può essere accettato';
	end if;
end $$

drop trigger if exists op1_rid $$

create trigger op1_rid
	after insert on latteutilizzato for each row
begin
	update Silos s 
    set QuantitaAttuale = s.QuantitaAttuale - new.QuantitaPrelevata
    where s.CodSilos = new.Silos;
    
    update Silos s
    set MediaProteine = (S.MediaProteine * S.quantitaAttuale - new.Proteine * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;
    
     update Silos s
    set MediaMinerali = (S.MediaMinerali * S.quantitaAttuale - new.Minerali * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;
    
     update Silos s
    set MediaEnzimi = (S.MediaEnzimi * S.quantitaAttuale - new.Enzimi * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;
    
     update Silos s
    set MediaLipidi = (S.MediaLipidi * S.quantitaAttuale - new.Lipidi * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;
    
     update Silos s
    set MediaZuccheri = (S.MediaZuccheri * S.quantitaAttuale - new.Zuccheri * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;
    
     update Silos s
    set MediaVitamine = (S.MediaVitamine * S.quantitaAttuale - new.Vitamine * new.QuantitaPrelevata) / (s.QuantitaAttuale - new.QuantitaPrelevata)
    where s.CodSilos = new.Silos;

end $$

drop trigger if exists op2_rid$$

create trigger op2_rid
	after insert on statomangiatoia for each row
begin
	update mangiatoia
    set foraggio = new.Foraggio
    where codMangiatoia = new.Mangiatoia;
end $$

drop event if exists SpedizioneOrdiniPronti$$
create event AvvioSpedizioni
	on schedule every 12 hour
	starts '2019-07-08 06:00:00'
	do
begin
	declare o int;
    declare stato char(50);
	declare finito int default 0;
    declare ordini cursor for
    select CodOrdine, Stato
    from Ordine;
    declare continue handler 
    for not found set finito = 1;
    
    open ordini;
    scan: loop
		if finito = 1
        then leave scan;
        else
			fetch ordini into o, stato;
            if 
				stato = 'in lavorazione' and 
                not exists(
					select *
                    from Spedizione s
                    where s.Ordine = o)
			then
				insert into Spedizione(Ordine, DataConsegnaPrevista)
                values(o, current_date() + interval 1 day);
			end if;
		end if;
	end loop;
end $$
delimiter ;