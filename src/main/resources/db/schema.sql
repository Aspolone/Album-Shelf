CREATE DATABASE IF NOT EXISTS albumshelf_db;
USE albumshelf_db;

CREATE TABLE utente (
    id_utente INT AUTO_INCREMENT PRIMARY KEY,
    nome_utente VARCHAR(100) NOT NULL,
    descrizione TEXT,
    nazione VARCHAR(100),
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    data_iscrizione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ruolo ENUM('cliente', 'admin') NOT NULL DEFAULT 'cliente'  --aggiunto per distinguere tra utenti normali e amministratori
);

CREATE TABLE componente (
    id_componente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    titolo VARCHAR(150) NOT NULL,        --ruolo nella sua band
    data_nascita DATE NOT NULL,
    data_morte DATE,
    strumento VARCHAR(100)
);

CREATE TABLE gruppo (
    id_gruppo INT AUTO_INCREMENT PRIMARY KEY,
    data_creazione DATE NOT NULL,
    nazione VARCHAR(100) NOT NULL,
    data_scioglimento DATE
);

CREATE TABLE nome_gruppo (
    id_gruppo INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_inizio DATE NOT NULL,
    data_fine DATE,
    PRIMARY KEY (id_gruppo, data_inizio),
    FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo)
);

CREATE TABLE composizione (
    id_componente INT NOT NULL,
    id_gruppo INT NOT NULL,
    data_ingresso DATE NOT NULL,
    data_uscita DATE,
    ruolo VARCHAR(100),
    PRIMARY KEY (id_componente, id_gruppo, data_ingresso),
    FOREIGN KEY (id_componente) REFERENCES componente(id_componente),
    FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo)
);

CREATE TABLE casa_discografica (
    id_casa_discografica INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    sede VARCHAR(150)
);

CREATE TABLE album (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    nome_album VARCHAR(150) NOT NULL,
    nazione VARCHAR(100),
    data_rilascio DATE,
    data_inizio_registrazione DATE,
    data_fine_registrazione DATE,
    tipo VARCHAR(50),
    nome_autore_copertina VARCHAR(150),
    file_copertina VARCHAR(255),
    descrittori TEXT,
    id_gruppo INT NOT NULL,
    id_casa_discografica INT NOT NULL,
    FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo),
    FOREIGN KEY (id_casa_discografica) REFERENCES casa_discografica(id_casa_discografica)
);

CREATE TABLE genere (
    genere VARCHAR(100) PRIMARY KEY,
    descrizione TEXT
);

CREATE TABLE canzone (
    id_canzone INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    testo TEXT,
    durata INT NOT NULL,        --durata in secondi
    id_album INT NOT NULL,
    FOREIGN KEY (id_album) REFERENCES album(id_album)
);

CREATE TABLE canzone_genere (
    id_canzone INT NOT NULL,
    genere VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_canzone, genere),
    FOREIGN KEY (id_canzone) REFERENCES canzone(id_canzone),
    FOREIGN KEY (genere) REFERENCES genere(genere)
);

CREATE TABLE edizione (
    id_edizione INT AUTO_INCREMENT PRIMARY KEY,
    anno_stampa INT,
    formato VARCHAR(50),
    etichetta VARCHAR(150),
    paese VARCHAR(100),
    id_album INT NOT NULL,
    FOREIGN KEY (id_album) REFERENCES album(id_album)
);

CREATE TABLE esemplare (
    id_esemplare INT AUTO_INCREMENT PRIMARY KEY,
    prezzo DECIMAL(10,2) NOT NULL,
    iva DECIMAL(4,2) NOT NULL DEFAULT 22.00,
    condizione_supporto VARCHAR(50),
    condizione_confezione VARCHAR(50),
    impellicolato BOOLEAN NOT NULL DEFAULT FALSE,
    attivo BOOLEAN NOT NULL DEFAULT TRUE,
    id_edizione INT NOT NULL,
    id_utente INT NOT NULL,
    FOREIGN KEY (id_edizione) REFERENCES edizione(id_edizione),
    FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
);

CREATE TABLE recensione (
    id_recensione INT AUTO_INCREMENT PRIMARY KEY,
    data_recensione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    voto INT NOT NULL CHECK (voto BETWEEN 1 AND 5),
    commento TEXT,
    id_utente INT NOT NULL,
    id_album INT,
    id_canzone INT,
    FOREIGN KEY (id_utente) REFERENCES utente(id_utente),
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_canzone) REFERENCES canzone(id_canzone)
);

CREATE TABLE ordine (
    id_ordine INT AUTO_INCREMENT PRIMARY KEY,
    data_ordine TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totale_pagato DECIMAL(10,2) NOT NULL,
    stato_ordine VARCHAR(50) NOT NULL DEFAULT 'confermato',
    voto_feedback INT CHECK (voto_feedback BETWEEN 1 AND 5),  -- opzionale, valorizzato solo dopo che l'acquirente lo lascia
    commento_feedback TEXT,                                    -- opzionale
    id_utente INT NOT NULL,
    FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
);

CREATE TABLE riga_ordine (      --Ogni riga e' un "esemplare" acquistato
    id_riga_ordine INT AUTO_INCREMENT PRIMARY KEY,
    id_ordine INT NOT NULL,
    id_esemplare INT,
    prezzo_storico DECIMAL(10,2) NOT NULL,      --prezzo al momento dell'acquisto
    iva_storica DECIMAL(4,2) NOT NULL,
    quantita INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_ordine) REFERENCES ordine(id_ordine) ON DELETE CASCADE,    
    FOREIGN KEY (id_esemplare) REFERENCES esemplare(id_esemplare) ON DELETE SET NULL        --Se l'esemplare viene eliminato, la riga_ordine rimane ma con id_esemplare a NULL  
);