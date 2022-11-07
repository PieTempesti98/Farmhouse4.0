-- Operazione 1: stoccaggio del latte munto

insert into Mungitura(Mungitrice, Animale, VolumeLatte, Proteine, Enzimi, Lipidi, Zuccheri, Vitamine, Minerali) 
	values(003, 'o002', 3, 4.2, 6.5, 2, 0.9, 2.5, 9.3);
    
select Silos
from Mungitura
where CodMungitura = (
	select max(CodMungitura)
    from Mungitura);



-- operazione 2: Visualizzare le tipologie di forggio utilizzate in un locale
set @locale = 003;

select *
from Foraggio
where CodForaggio in (
	select Foraggio
	from Mangiatoia
    where Locale = @locale
    );



-- operazione 3: inserimento della prenotazione di una camera con servizi aggiuntivi

set @cf = 'FBALRA93C60E015L';

insert into prenotazionecamera(CodFiscale, DataPrenotazione, DataArrivo, DataPartenza)
values(@cf, current_date(), '2019-07-19', '2019-07-25');

select CodPrenotazioneC, DataArrivo, DataPartenza into @pren, @da, @dp
from prenotazioneCamera
where CodFiscale = @cf and
	DataPrenotazione = current_date();
    
select CodCamera, Prezzo into @camera, @prezzo
from Camera
where Tipologia = 'Suite'and 
	CodCamera not in (
		select Camera
		from CamerePrenotate
		where Prenotazione not in (
			Select CodPrenotazioneC
			from PrenotazioneCamera
			where DataPartenza <= @da));
            
insert into camerePrenotate
values(@camera, @pren);

insert into ServizioAggiuntivo 
values ('Spa', @camera, '2019-07-22', 25), ('Lezione di equitazione', @camera, '2019-07-23', 54);

set @prezzo = @prezzo * (
		select datediff(dataPartenza, DataArrivo) 
		from PrenotazioneCamera 
        where CodPrenotazionec = @pren
    ) + (
		select sum(prezzo) 
        from servizioaggiuntivo 
        where DataInizio between (
					Select DataArrivo 
					from prenotazionecamera 
					where codprenotazionec = @pren) 
				and (
					Select DataPartenza 
					from prenotazionecamera 
					where codprenotazionec = @pren) and 
			camera = @camera
	);
    
Insert into pagamento(Timestamp, Importo)
values(current_timestamp, @prezzo/2),('2019-07-25 00:00:00', @prezzo/2);

select CodRicevuta into @ricevuta1
from pagamento
where codRicevuta = (
	select max(codRicevuta) - 1 
    from Pagamento);

select CodRicevuta into @ricevuta2
from pagamento
where codRicevuta = 
	(select max(CodRicevuta)
		from pagamento);

insert into PayPal
values(0450, @ricevuta1, 'FabiLuca'),(0998, @ricevuta2, 'FabiLuca');

insert into datipagamentoc
values(@pren, @ricevuta1), (@pren, @ricevuta2);

select distinct Prenotazione, Camera, Ricevuta, Nome
from servizioaggiuntivo natural join camereprenotate natural join datipagamentoc
where Prenotazione = @pren and
	datainizio between @da and @dp;

-- operazione 4: Tracciamento di un ordine

set @ordine = 004;

select *
from Tracciamento
where spedizione in (
	Select CodSpedizione
    from Spedizione
    where Ordine = @Ordine)
group by Spedizione
having max(Timestamp);

-- operazione 5: Controllo ultimi parametri soggettivi

select Animale into @animale
from visitacontrollo vc
where CodVisita >= all (
	select CodVisita
    from VisitaControllo);

select dc.Animale, dc.DataRilevazione, dc.Nome, dc.Entità, l.DataRilevazione, l.Tipologia, l.Entità
from disturbocomportamentale dc inner join lesione l on (l.Animale = dc.Animale)
where l.DataRilevazione < current_date() and dc.DataRilevazione < current_date()
group by dc.Animale
having max(dc.DataRilevazione) and max(l.DataRilevazione);

-- operazione 6: Produzione e stoccaggio di un prodotto

select max(CodLotto) into @lotto
from Lotto;

insert into prodotto(Lotto, NomeFormaggio, PesoFormato, Peso, Stato, DataScadenza)
values(@lotto,'Pecorino Toscano', 250, 253, 'In produzione', '2019-07-31');

select max(CodProdotto) into @prod
from Prodotto;

insert into valoreproduzione
values(@prod, 'pH', 1, current_timestamp, 2.8), (@prod, 'acqua',2, current_timestamp, 44),(@prod, 'Acido Lattico', 3, current_timestamp, 2.2),(@prod, 'Sali Minerali', 4, current_timestamp, 3.3),
	(@prod, 'KJ', 5, current_timestamp, 1490),(@prod, 'pH', 6, current_timestamp, 5.2);

create or replace view ConteggioFormaggi as
select Scaffale, count(*) as Prodotti
from stoccaggioprodotti
group by Scaffale;

select Scaffale into @scaf
from ConteggioFormaggi
group by Scaffale
having min(Prodotti)
limit 1;

insert into stoccaggioprodotti
values(@prod, @scaf, current_date());

select scaffale
from stoccaggioprodotti
where Prodotto = @prod;

-- Operazione 7: 
insert into ordine(CodFiscale, Timestamp) values
('MGGLGU86R26E233Y', current_timestamp);

select max(codOrdine) into @ordine
from Ordine;

insert into contenutoOrdine 
values(@ordine, 'Squacquerone di Romagna DOP', 250, 2), (@Ordine, 'Pecorino Toscano', 500, 1);

select sum(f.Costo) into @spesa
from Contenutoordine co natural join formato f
where co.Ordine = @ordine;

insert into Pagamento(timestamp, Importo)
values(current_timestamp, @spesa);

select max(CodRicevuta) into @ricevuta
from Pagamento;

update Ordine
set Ricevuta = @ricevuta
where CodOrdine = @Ordine;

select s.CodSpedizione, o.stato
from Ordine o left outer join Spedizione s on o.CodOrdine = s.Ordine
where o.CodOrdine = @ordine;

-- Operazione 8: Trovare farmaco, Patologia e Paziente data una terapia

set @terapia = 03;
select v.Animale, t.Patologia, t.Rimedio
from Terapia t inner join visitacontrollo v on v.CodVisita = t.Visita
where t.CodTerapia = @terapia;