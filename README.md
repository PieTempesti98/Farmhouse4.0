# Farmhouse4.0
A relational database for a smart farmhouse, implemented in MySql 8.0, developed for the Relational Databases exam by Pavel Lombardi and Pietro Tempesti. The documentation is in Italian.
## What is FarmHouse 4.0
FarmHouse 4.0 is a smart farm with sensors for the well-being of the animals who live here. In FarmHouse, we use the milk of the animals to produce different kinds of cheese and ship them via an E-Shop.

Is it also possible to book a room for a night and take part to excursions across the whole farm.

## The documentation and the E-R Diagrams
The documentation is fully written in Italian. It explains the design choices we made in order to build the relational DB. We also made an UnRestructured E-R diagram and a Restructured E-R diagram, explaining the Entity-Relation schema of our database.

## How to run the project
The project is composed of 5 scripts.

In order to deploy the database locally on your machine, you have to run on your MySql these 3 scripts in the following order:
1. creazione tabelle.sql
2. vincoli di integrità generici.sql
3. popolazione tabelle.sql

You can perform some pre-written operations on the DB by using the _operazioni sui dati.sql_ script or the _analytics.sql_ script.
