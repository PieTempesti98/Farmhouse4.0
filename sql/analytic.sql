-- Analytic 1: Trovare le posizioni più frequentate dagli animali, e i tempi medi in cui ci sostano.

create or replace view Tempi as
select pg.Latitudine, pg.Longitudine, pg.Animale, pg.Timestamp as ts1, pg1.Timestamp as TS2
from PosizioneGPS pg left outer join PosizioneGPS pg1 
     on (pg.Latitudine = pg1.Latitudine
         and pg.Longitudine = pg1.Longitudine 
         and pg.Animale = pg1.Animale 
         and pg.Timestamp < pg1.Timestamp)
where not exists( select *
	from PosizioneGPS pg2
    where pg2.Timestamp between pg.Timestamp and pg1.Timestamp
		and pg.Animale = pg2.Animale and (
			pg.Latitudine <> pg2.Latitudine or
            pg.Longitudine <> pg2.Longitudine)) and
	not exists (
		select *
        from PosizioneGPS pg3
        where pg3.Animale = pg.Animale and
			pg3.Latitudine = pg.Latitudine and
            pg3.Longitudine = pg.Longitudine and
            pg3.Timestamp > pg1.Timestamp and 
            not exists( select *
				from PosizioneGPS pg2
				where pg2.Timestamp between pg1.Timestamp and pg3.Timestamp
					and pg1.Animale = pg2.Animale and (
						pg1.Latitudine <> pg2.Latitudine or
						pg1.Longitudine <> pg2.Longitudine))) and
	pg.latitudine between 60 and 150 and
	pg.Longitudine between 0 and 90;


create or replace view Af1 as
select p1.Latitudine, p1.Longitudine, d.MediaTempo, count(*) as Passaggi
from 
	(Posizionegps p1 inner join posizionegps p2 on (p1.Animale <> p2.Animale and p1.Timestamp <> p2.Timestamp))
inner join(
	select t.Latitudine, t.Longitudine, avg(if(ts2 is not null,timestampdiff(minute, t.ts2, t.Ts1), 5)) as MediaTempo
    from Tempi t
    group by t.Latitudine, t.Longitudine
  )as d on (d.Latitudine = p1.Latitudine and d.Longitudine = p1.Longitudine)
where abs(p1.Latitudine - p2.Latitudine) <= 10 and
	abs(p1.Longitudine - p2.Longitudine) <= 10
group by p1.Latitudine, p1.Longitudine;

select a.Latitudine, a.Longitudine, a.MediaTempo, a.Passaggi, dense_rank() over (order by a.Passaggi desc) as Classifica
from af1 a
where not exists(
	select *
    from af1 a1
    where a1.Passaggi > a.Passaggi and
    abs(a.Latitudine - a1.Latitudine) <= 20 and
	abs(a.Longitudine - a1.Longitudine) <= 20
    );

-- analytic 2: Controllo qualità di processo
create or replace view contavalori as
select vp.Prodotto, count(*) as NumeroValori
from Valoreproduzione vp
group by vp.Prodotto
having Count(*) = (
	select count(*)
    from valoreidealericetta
    where Formaggio in (
		select NomeFormaggio
        from Prodotto
        where CodProdotto = vp.Prodotto));

create or replace view erroreperprodotto as        
select p.Lotto, p.CodProdotto, sum(100 * abs(vp.Valore * p.Peso/1000- vi.Valore) /vi.Valore)/c.NumeroValori as TassoErroreMedio
from 
	Prodotto p 
    inner join valoreproduzione vp 
		on p.CodProdotto = vp.Prodotto 
	inner join valoreidealericetta vi 
		on (
			vi.Formaggio = p.NomeFormaggio and
            vi.Fase = vp.NumeroFase and
            vi.Nome = vp.Nome)
	natural join contavalori c
group by p.CodProdotto;

select rank() over ( order by d.TassoErroreLotto) as Classifica, d.Lotto, TassoErroreLotto 
from
	(select Lotto, sum(TassoErroreMedio)/count(*) as TassoErroreLotto
	from erroreperprodotto
	group by Lotto) as d;
    
-- Analytic 3: Analisi della tracciabilità di filiera
create or replace view indicedeperibilita as
select r.Prodotto, sum(100 * abs(vp.Valore - vr.valore)/vp.Valore)/count(*) as PercDeperibilita
	from 
		ValoreReso vr 
		natural join reso r
		inner join valoreproduzione vp
			on vp.Prodotto = r.prodotto and vp.Nome = vr.Nome
	where vp.NumeroFase = (
			select max(NumeroFase)
			from ValoreProduzione
			where Prodotto = r.Prodotto)
	group by r.Prodotto;
    
create or replace view DeperibilitaFormaggi as
select p.NomeFormaggio, count(*) as ConteggioFormaggiDeperiti
from Prodotto p inner join indicedeperibilita i on p.CodProdotto = i.Prodotto
where PercDeperibilita >= 10
group by p.NomeFormaggio
union
select p.NomeFormaggio, 0
from Prodotto p
where NomeFormaggio not in (
	select distinct p.NomeFormaggio
    from prodotto p inner join indiceDeperibilita i on p.CodProdotto = i.Prodotto
    where i.PercDeperibilita >= 10);
    
create or replace view ErroreFase as
select Formaggio, Fase, sum(100 * abs(vp.Valore * p.Peso/1000 - vi.valore)/vi.Valore)/count(*) as PercErrore
from 
	ValoreProduzione vp 
	inner join Prodotto p 
		on p.CodProdotto = vp.Prodotto
	inner join valoreidealericetta vi
		on p.NomeFormaggio = vi.Formaggio and vp.NumeroFase = vi.Fase and vp.Nome = vi.Nome
group by vi.Formaggio, vi.Fase;

create or replace view RankFase as
select Formaggio, Fase, rank() over( partition by Formaggio order by PercErrore desc) as classifica
from ErroreFase;

select Formaggio, Fase as FaseCritica, ConteggioFormaggiDeperiti
from RankFase r inner join DeperibilitaFormaggi d on r.Formaggio = d.NomeFormaggio 
where r.classifica = 1;

-- analytic 4: Report delle vendite
create or replace view FormaggiVenduti as
select NomeFormaggio, Peso, sum(Quantita) as Quantita
from contenutoOrdine
group by NomeFormaggio, Peso
union 
select f.NomeFormaggio, f.peso, 0
from Formato f
where not exists (
	select *
    from ContenutoOrdine c
    where c.NomeFormaggio = f.NomeFormaggio and
		c.Peso = f.Peso);
        
create or replace view MediaRecensioni as
select p.NomeFormaggio, p.pesoFormato, avg(r.Conservazione) as Conservazione, avg(r.Gusto) as Gusto, avg(r.Qualita) as Qualita, avg(r.Gradimento) as Gradimento
from prodotto p inner join recensione r on p.CodProdotto = r.Prodotto
group by p.NomeFormaggio, p.PesoFormato
union
select f.NomeFormaggio, f.Peso, null, null, null, null
from formato f
where not exists (
	select *
    from prodotto p1 inner join recensione r on r.Prodotto = p1.CodProdotto
    where f.NomeFormaggio = p1.NomeFormaggio and
		f.Peso = p1.PesoFormato);
        
create or replace view bundle as
select c.NomeFormaggio as Formaggio1, c.Peso as peso1, c1.NomeFormaggio as Formaggio2, c1.Peso as Peso2, sum(c1.Quantita) as Quantita
from ContenutoOrdine c inner join contenutoOrdine c1 on (c.Ordine = c1.ordine and c1.NomeFormaggio <> c.NomeFormaggio)
group by c.NomeFormaggio, c.Peso, c1.NomeFormaggio, c1.Peso;

create or replace view daClassificare as
select distinct
	fv.NomeFormaggio, 
    fv.Peso, 
    fv.Quantita, 
    mr.Conservazione, 
    mr.Gusto,
    mr.Qualita,
    mr.Gradimento,
	b.Formaggio2 as FormaggioBundle,
    b.Peso2 as PesoBundle
from 
	FormaggiVenduti fv
    left outer join mediarecensioni mr
		on (fv.NomeFormaggio = mr.NomeFormaggio and fv.Peso = mr.PesoFormato)
	left outer join bundle b
		on (fv.NomeFormaggio = b.Formaggio1 and fv.Peso = b.Peso1)
where b.Formaggio2 in (
		select b1.Formaggio2
        from bundle b1
        where b.Formaggio1 = b1.Formaggio1 and
			b.Peso1 = b1.Peso1
		group by b1.Formaggio1, b1.Peso1
        having max(b1.Quantita))
	and b.Peso2 in (
		select b1.peso2
        from bundle b1
        where b.Formaggio1 = b1.Formaggio1 and
			b.Peso1 = b1.Peso1
		group by b1.Formaggio1, b1.Peso1
        having max(b1.Quantita))
union 
select distinct
	fv.NomeFormaggio, 
    fv.Peso, 
    fv.Quantita, 
    mr.Conservazione, 
    mr.Gusto,
    mr.Qualita,
    mr.Gradimento,
	null,
    null
from 
	FormaggiVenduti fv
    left outer join mediarecensioni mr
		on (fv.NomeFormaggio = mr.NomeFormaggio and fv.Peso = mr.PesoFormato)
where 
	not exists (
		select *
        from bundle b
        where b.Formaggio1 = fv.NomeFormaggio and
			b.Peso1 = fv.Peso);
            
select 
	    rank() over( order by Quantita desc) as ClassificaVendite,
        NomeFormaggio,
        Peso,
        Quantita,
        Conservazione,
        Gusto,
        Qualita,
        Gradimento,
        FormaggioBundle,
        PesoBundle
from DaClassificare;