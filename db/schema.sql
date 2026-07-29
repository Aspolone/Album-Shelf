CREATE DATABASE IF NOT EXISTS albumshelf_db;
USE albumshelf_db;


CREATE TABLE utente (
    id_utente        INT AUTO_INCREMENT PRIMARY KEY,
    nome_utente      VARCHAR(100)  NOT NULL UNIQUE,
    email            VARCHAR(150)  NOT NULL UNIQUE,
    password         VARCHAR(255)  NOT NULL,
    descrizione      TEXT,
    nazione          VARCHAR(100),
    data_iscrizione  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ruolo            ENUM('cliente','admin') NOT NULL DEFAULT 'cliente',

    CONSTRAINT chk_mail_utente CHECK (email LIKE '%_@_%._%')
);


CREATE TABLE componente (
    id_componente  INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cognome        VARCHAR(100) NOT NULL,
    data_nascita   DATE,
    data_morte     DATE,
    strumento      VARCHAR(100),

    CONSTRAINT chk_data_componente
        CHECK (data_morte IS NULL OR data_nascita IS NULL OR data_morte >= data_nascita)
);


CREATE TABLE gruppo (
    id_gruppo          INT AUTO_INCREMENT PRIMARY KEY,
    nome               VARCHAR(150) NOT NULL,
    data_creazione     DATE NOT NULL,
    nazione            VARCHAR(100),
    data_scioglimento  DATE,
    file_immagine      VARCHAR(255),
    visite             INT NOT NULL DEFAULT 0,
 
    CONSTRAINT chk_date_gruppo
        CHECK (data_scioglimento IS NULL OR data_scioglimento >= data_creazione),
    CONSTRAINT chk_visite_gruppo CHECK (visite >= 0)
);


CREATE INDEX idx_nome_gruppo   ON gruppo(nome);
CREATE INDEX idx_visite_gruppo ON gruppo(visite);


CREATE TABLE nome_gruppo (
    id_gruppo    INT          NOT NULL,
    nome         VARCHAR(150) NOT NULL,
    data_inizio  DATE         NOT NULL,
    data_fine    DATE         NOT NULL,

    PRIMARY KEY (id_gruppo, nome),
    CONSTRAINT fk_nome_gruppo_gruppo
        FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo)
        ON DELETE CASCADE,
    CONSTRAINT chk_data_nome_gruppo CHECK (data_fine >= data_inizio)
);


CREATE TABLE composizione (
    id_componente  INT  NOT NULL,
    id_gruppo      INT  NOT NULL,
    data_ingresso  DATE NOT NULL,
    data_uscita    DATE,
    ruolo          VARCHAR(100),

    PRIMARY KEY (id_componente, id_gruppo, data_ingresso),
    CONSTRAINT fk_composizione_componente
        FOREIGN KEY (id_componente) REFERENCES componente(id_componente)
        ON DELETE CASCADE,
    CONSTRAINT fk_composizione_gruppo
        FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo)
        ON DELETE CASCADE,
    CONSTRAINT chk_data_composizione
        CHECK (data_uscita IS NULL OR data_uscita >= data_ingresso)
);


CREATE TABLE casa_discografica (
    id_casa_discografica  INT AUTO_INCREMENT PRIMARY KEY,
    nome                  VARCHAR(150) NOT NULL,
    sede                  VARCHAR(150)
);


CREATE TABLE album (
    id_album                   INT AUTO_INCREMENT PRIMARY KEY,
    nome_album                 VARCHAR(150) NOT NULL,
    nazione                    VARCHAR(100),
    tipo                       ENUM('LP', 'EP', 'Singolo') NOT NULL,
    data_rilascio              DATE,
    data_inizio_registrazione  DATE,
    data_fine_registrazione    DATE,
    nome_autore_copertina      VARCHAR(150),
    file_copertina             VARCHAR(255),
    descrittori                TEXT,
    id_gruppo                  INT NOT NULL,
    id_casa_discografica       INT NOT NULL,
    visite                     INT NOT NULL DEFAULT 0,

    CONSTRAINT fk_album_gruppo
        FOREIGN KEY (id_gruppo) REFERENCES gruppo(id_gruppo),
    CONSTRAINT fk_album_casa_discografica
        FOREIGN KEY (id_casa_discografica) REFERENCES casa_discografica(id_casa_discografica),
    CONSTRAINT chk_registrazione_album
        CHECK (data_fine_registrazione IS NULL
               OR data_inizio_registrazione IS NULL
               OR data_fine_registrazione >= data_inizio_registrazione),
    CONSTRAINT chk_visite_album CHECK (visite >= 0)
);

CREATE INDEX idx_nome_album   ON album(nome_album);
CREATE INDEX idx_gruppo_album ON album(id_gruppo);
CREATE INDEX idx_visite_album ON album(visite);


CREATE TABLE genere (
    genere       VARCHAR(100) PRIMARY KEY,
    descrizione  TEXT
);


CREATE TABLE album_genere (
    id_album  INT          NOT NULL,
    genere    VARCHAR(100) NOT NULL,

    PRIMARY KEY (id_album, genere),
    CONSTRAINT fk_album_genere_album
        FOREIGN KEY (id_album) REFERENCES album(id_album)
        ON DELETE CASCADE,
    CONSTRAINT fk_album_genere_genere
        FOREIGN KEY (genere) REFERENCES genere(genere)
        ON UPDATE CASCADE
);

CREATE INDEX idx_albumgenere_genere ON album_genere(genere);


CREATE TABLE canzone (
    id_canzone  INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(150) NOT NULL,
    testo       TEXT,
    durata      INT,
    id_album    INT NOT NULL,
    visite      INT NOT NULL DEFAULT 0,

    CONSTRAINT fk_canzone_album
        FOREIGN KEY (id_album) REFERENCES album(id_album)
        ON DELETE CASCADE,
    CONSTRAINT chk_durata_canzone CHECK (durata IS NULL OR durata > 0),
    CONSTRAINT chk_visite_canzone CHECK (visite >= 0)
);

CREATE INDEX idx_canzone_album   ON canzone(id_album);
CREATE INDEX idx_nome_canzone    ON canzone(nome);
CREATE INDEX idx_visite_canzone  ON canzone(visite);


CREATE TABLE canzone_genere (
    id_canzone  INT          NOT NULL,
    genere      VARCHAR(100) NOT NULL,

    PRIMARY KEY (id_canzone, genere),
    CONSTRAINT fk_canzone_genere_canzone
        FOREIGN KEY (id_canzone) REFERENCES canzone(id_canzone)
        ON DELETE CASCADE,
    CONSTRAINT fk_canzone_genere_genere
        FOREIGN KEY (genere) REFERENCES genere(genere)
        ON UPDATE CASCADE
);

CREATE INDEX idx_canzone_genere_genere ON canzone_genere(genere);


CREATE TABLE edizione (
    id_edizione  INT AUTO_INCREMENT PRIMARY KEY,
    anno_stampa  INT,
    formato      ENUM('vinile','cd','cassetta') NOT NULL,
    etichetta    VARCHAR(150),
    paese        VARCHAR(100),
    id_album     INT NOT NULL,

    CONSTRAINT fk_edizione_album
        FOREIGN KEY (id_album) REFERENCES album(id_album)
        ON DELETE CASCADE,
    CONSTRAINT chk_anno_edizione
        CHECK (anno_stampa IS NULL OR anno_stampa BETWEEN 1850 AND 2200)
);

CREATE INDEX idx_edizione_album ON edizione(id_album);


CREATE TABLE esemplare (
    id_esemplare           INT AUTO_INCREMENT PRIMARY KEY,
    prezzo                 DECIMAL(10,2) NOT NULL,
    condizione_disco       ENUM('nuovo','ottimo','buono','discreto','scarso') NOT NULL,
    condizione_confezione  ENUM('nuovo','ottimo','buono','discreto','scarso') NOT NULL,
    impellicolato          BOOLEAN NOT NULL DEFAULT FALSE,
    id_edizione            INT NOT NULL,
    id_utente              INT NOT NULL,
    disponibile            BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_esemplare_edizione
        FOREIGN KEY (id_edizione) REFERENCES edizione(id_edizione),
    CONSTRAINT fk_esemplare_utente
        FOREIGN KEY (id_utente) REFERENCES utente(id_utente),
    CONSTRAINT chk_esemplare_prezzo CHECK (prezzo > 0)
);

CREATE INDEX idx_esemplare_edizione  ON esemplare(id_edizione);
CREATE INDEX idx_esemplare_venditore ON esemplare(id_utente);


CREATE TABLE recensione (
    id_recensione    INT AUTO_INCREMENT PRIMARY KEY,
    voto             DECIMAL(2,1) NOT NULL,
    commento         TEXT,
    data_recensione  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_utente        INT NOT NULL,
    id_album         INT,
    id_canzone       INT,

    CONSTRAINT fk_recensione_utente
        FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
        ON DELETE CASCADE,
    CONSTRAINT fk_recensione_album
        FOREIGN KEY (id_album) REFERENCES album(id_album)
        ON DELETE CASCADE,
    CONSTRAINT fk_recensione_canzone
        FOREIGN KEY (id_canzone) REFERENCES canzone(id_canzone)
        ON DELETE CASCADE,

    CONSTRAINT chk_target_recensione CHECK (
           (id_album IS NOT NULL AND id_canzone IS NULL)
        OR (id_album IS NULL     AND id_canzone IS NOT NULL)
    ),
    CONSTRAINT chk_voto_recensione CHECK (voto IN (0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0)),

    CONSTRAINT uq_recensione_album   UNIQUE (id_utente, id_album),
    CONSTRAINT uq_recensione_canzone UNIQUE (id_utente, id_canzone)
);


CREATE TABLE ordine (
    id_ordine      INT AUTO_INCREMENT PRIMARY KEY,
    data_ordine    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totale_pagato  DECIMAL(10,2) NOT NULL,
    stato_ordine   ENUM('confermato','spedito','consegnato','annullato')
                   NOT NULL DEFAULT 'confermato',
    id_utente      INT NOT NULL,

    CONSTRAINT fk_ordine_utente
        FOREIGN KEY (id_utente) REFERENCES utente(id_utente),
    CONSTRAINT chk_totale_ordine CHECK (totale_pagato >= 0)
);

CREATE INDEX idx_ordine_utente ON ordine(id_utente);
CREATE INDEX idx_ordine_data   ON ordine(data_ordine);

CREATE TABLE riga_ordine (
    id_riga_ordine  INT AUTO_INCREMENT PRIMARY KEY,
    id_ordine       INT NOT NULL,
    id_esemplare    INT,
    prezzo_storico  DECIMAL(10,2) NOT NULL,
    iva_storica     DECIMAL(5,2)  NOT NULL DEFAULT 22.00,

    CONSTRAINT fk_riga_ordine_ordine
        FOREIGN KEY (id_ordine) REFERENCES ordine(id_ordine)
        ON DELETE CASCADE,
    CONSTRAINT fk_riga_ordine_esemplare
        FOREIGN KEY (id_esemplare) REFERENCES esemplare(id_esemplare)
        ON DELETE SET NULL,

    CONSTRAINT chk_riga_prezzo CHECK (prezzo_storico >= 0),
    CONSTRAINT chk_riga_iva    CHECK (iva_storica BETWEEN 0 AND 100)
);

CREATE INDEX idx_riga_ordine_ordine ON riga_ordine(id_ordine);
