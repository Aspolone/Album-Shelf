USE albumshelf_db;

INSERT INTO utente (nome_utente, email, password, descrizione, nazione, ruolo) VALUES
('marco_vinyl',  'marco@test.com',       'HASH_PLACEHOLDER_1', 'Collezionista di vinili dal 2010',           'Italia',       'cliente'),
('anna_cd',      'anna@test.com',        'HASH_PLACEHOLDER_2', 'Appassionata di musica alternativa',         'Italia',       'cliente'),
('john_rock',    'john@test.com',        'HASH_PLACEHOLDER_3', 'Record store owner based in London',         'Regno Unito',  'cliente'),
('laura_jazz',   'laura@test.com',       'HASH_PLACEHOLDER_4', 'Ascolto di tutto, dal jazz al grunge',       'Italia',       'cliente'),
('admin',        'admin@albumshelf.com', 'HASH_PLACEHOLDER_5', 'Amministratore del sito',                    'Italia',       'admin');

INSERT INTO componente (nome, cognome, data_nascita, strumento) VALUES
('Thom',      'Yorke',       '1968-10-07', 'voce'),
('Jonny',     'Greenwood',   '1971-11-05', 'chitarra'),
('Colin',     'Greenwood',   '1969-06-26', 'basso'),
('Ed',        'O Brien',     '1968-04-15', 'chitarra'),
('Philip',    'Selway',      '1967-05-23', 'batteria'),
('Roger',     'Waters',      '1943-09-06', 'basso'),
('David',     'Gilmour',     '1946-03-06', 'chitarra'),
('Nick',      'Mason',       '1944-01-27', 'batteria'),
('Richard',   'Wright',      '1943-07-28', 'tastiere'),
('Kurt',      'Cobain',      '1967-02-20', 'chitarra'),
('Krist',     'Novoselic',   '1965-05-16', 'basso'),
('Dave',      'Grohl',       '1969-01-14', 'batteria'),
('Ian',       'Curtis',      '1956-07-15', 'voce'),
('Bernard',   'Sumner',      '1956-01-04', 'chitarra'),
('Peter',     'Hook',        '1956-02-13', 'basso'),
('Stephen',   'Morris',      '1957-10-28', 'batteria');

INSERT INTO componente (nome, cognome, data_nascita, data_morte, strumento) VALUES
('Kurt', 'Cobain (morte)', '1967-02-20', '1994-04-05', NULL),
('Ian',  'Curtis (morte)', '1956-07-15', '1980-05-18', NULL);

DELETE FROM componente WHERE cognome = 'Cobain (morte)';
DELETE FROM componente WHERE cognome = 'Curtis (morte)';

UPDATE componente SET data_morte = '1994-04-05' WHERE nome = 'Kurt' AND cognome = 'Cobain';
UPDATE componente SET data_morte = '1980-05-18' WHERE nome = 'Ian'  AND cognome = 'Curtis';

INSERT INTO gruppo (nome, data_creazione, nazione, file_immagine) VALUES
('Radiohead',    '1985-01-01', 'Regno Unito',  'radiohead.jpg'),
('Pink Floyd',   '1965-01-01', 'Regno Unito',  'pinkfloyd.jpg'),
('Nirvana',      '1987-01-01', 'Stati Uniti',  'nirvana.jpg'),
('Joy Division', '1976-01-01', 'Regno Unito',  'joydivision.jpg');

UPDATE gruppo SET data_scioglimento = '1980-05-18' WHERE nome = 'Joy Division';

--Radiohead (id_gruppo = 1)
INSERT INTO composizione (id_componente, id_gruppo, data_ingresso, ruolo) VALUES
(1, 1, '1985-01-01', 'voce'),
(2, 1, '1985-01-01', 'chitarra'),
(3, 1, '1985-01-01', 'basso'),
(4, 1, '1985-01-01', 'chitarra'),
(5, 1, '1985-01-01', 'batteria');

--Pink Floyd (id_gruppo = 2)
INSERT INTO composizione (id_componente, id_gruppo, data_ingresso, ruolo) VALUES
(6, 2, '1965-01-01', 'basso'),
(7, 2, '1968-01-01', 'chitarra'),
(8, 2, '1965-01-01', 'batteria'),
(9, 2, '1965-01-01', 'tastiere');

UPDATE composizione SET data_uscita = '1985-12-15'
WHERE id_componente = 6 AND id_gruppo = 2;

--Nirvana (id_gruppo = 3)
INSERT INTO composizione (id_componente, id_gruppo, data_ingresso, ruolo) VALUES
(10, 3, '1987-01-01', 'chitarra'),
(11, 3, '1987-01-01', 'basso'),
(12, 3, '1990-01-01', 'batteria');

--Joy Division (id_gruppo = 4)
INSERT INTO composizione (id_componente, id_gruppo, data_ingresso, ruolo) VALUES
(13, 4, '1976-01-01', 'voce'),
(14, 4, '1976-01-01', 'chitarra'),
(15, 4, '1976-01-01', 'basso'),
(16, 4, '1976-01-01', 'batteria');

INSERT INTO nome_gruppo (id_gruppo, nome, data_inizio, data_fine) VALUES
(1, 'On A Friday',       '1985-01-01', '1991-01-01'),
(4, 'Warsaw',            '1976-05-01', '1978-01-01');

INSERT INTO casa_discografica (nome, sede) VALUES
('Parlophone',      'Londra'),
('Harvest Records', 'Londra'),
('DGC Records',     'Los Angeles'),
('Factory Records', 'Manchester'),
('Capitol Records', 'Los Angeles');

INSERT INTO genere (genere, descrizione) VALUES
('Alternative Rock', 'Rock alternativo, nato negli anni 80 come alternativa al mainstream'),
('Art Rock',         'Rock sperimentale con influenze da arte, letteratura e avanguardia'),
('Progressive Rock', 'Rock progressivo, composizioni lunghe e strutture complesse'),
('Grunge',           'Sottogenere del rock alternativo, nato a Seattle a fine anni 80'),
('Electronic',       'Musica prodotta con strumenti elettronici e sintetizzatori'),
('Psychedelic Rock', 'Rock psichedelico, ispirato dalla cultura psichedelica degli anni 60'),
('Post-Punk',        'Evoluzione del punk, piu sperimentale e atmosferico'),
('New Wave',         'Genere emerso dal post-punk con influenze pop ed elettroniche');

INSERT INTO album (nome_album, nazione, tipo, data_rilascio, data_inizio_registrazione, data_fine_registrazione, nome_autore_copertina, file_copertina, descrittori, id_gruppo, id_casa_discografica) VALUES
('OK Computer',               'Regno Unito', 'LP', '1997-06-16', '1996-07-01', '1997-03-01', 'Stanley Donwood',  'okcomputer.jpg',    'alienazione, tecnologia, paranoia',         1, 1),
('Kid A',                     'Regno Unito', 'LP', '2000-10-02', '1999-01-01', '2000-04-01', 'Stanley Donwood',  'kida.jpg',          'elettronica, sperimentale',                 1, 1),
('The Bends',                 'Regno Unito', 'LP', '1995-03-13', '1994-02-01', '1994-11-01', 'Stanley Donwood',  'thebends.jpg',      'britpop, chitarre, emotivita',              1, 1),
('The Dark Side of the Moon', 'Regno Unito', 'LP', '1973-03-01', '1972-06-01', '1973-02-01', 'Storm Thorgerson', 'darkside.jpg',      'concept album, tempo, morte',               2, 2),
('Wish You Were Here',        'Regno Unito', 'LP', '1975-09-12', '1975-01-01', '1975-07-01', 'Storm Thorgerson', 'wishyouwere.jpg',   'assenza, industria musicale',               2, 2),
('The Wall',                  'Regno Unito', 'LP', '1979-11-30', '1978-12-01', '1979-11-01', 'Gerald Scarfe',    'thewall.jpg',       'isolamento, alienazione, educazione',       2, 2),
('Nevermind',                 'Stati Uniti', 'LP', '1991-09-24', '1991-05-01', '1991-06-01', 'Robert Fisher',    'nevermind.jpg',     'angoscia, ribellione, generazione X',       3, 3),
('In Utero',                  'Stati Uniti', 'LP', '1993-09-21', '1993-02-13', '1993-02-26', NULL,               'inutero.jpg',       'rumore, dolore, rifiuto del successo',      3, 3),
('Unknown Pleasures',         'Regno Unito', 'LP', '1979-06-15', '1979-04-01', '1979-04-17', 'Peter Saville',    'unknownpleasures.jpg', 'angoscia, post-punk, atmosferico',       4, 4),
('Closer',                    'Regno Unito', 'LP', '1980-07-18', '1980-03-18', '1980-03-30', 'Peter Saville',    'closer.jpg',        'oscurita, introspezione, fine',             4, 4);

INSERT INTO album_genere (id_album, genere) VALUES
(1, 'Alternative Rock'), (1, 'Art Rock'), (1, 'Electronic'),
(2, 'Electronic'), (2, 'Art Rock'),
(3, 'Alternative Rock'), (3, 'Art Rock'),
(4, 'Progressive Rock'), (4, 'Psychedelic Rock'), (4, 'Art Rock'),
(5, 'Progressive Rock'), (5, 'Art Rock'),
(6, 'Progressive Rock'), (6, 'Art Rock'),
(7, 'Grunge'), (7, 'Alternative Rock'),
(8, 'Grunge'), (8, 'Alternative Rock'),
(9, 'Post-Punk'), (9, 'New Wave'),
(10, 'Post-Punk'), (10, 'New Wave');

--OK Computer (id_album = 1)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Airbag',                      282, 1),
('Paranoid Android',            386, 1),
('Subterranean Homesick Alien', 258, 1),
('Exit Music (For a Film)',     258, 1),
('Let Down',                    298, 1),
('Karma Police',                264, 1),
('Fitter Happier',               117, 1),
('Electioneering',              234, 1),
('Climbing Up the Walls',       288, 1),
('No Surprises',                228, 1),
('Lucky',                       271, 1),
('The Tourist',                 323, 1);

--Kid A (id_album = 2)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Everything In Its Right Place', 250, 2),
('Kid A',                         273, 2),
('The National Anthem',           350, 2),
('How to Disappear Completely',   342, 2),
('Treefingers',                   224, 2),
('Optimistic',                    303, 2),
('In Limbo',                      193, 2),
('Idioteque',                     309, 2),
('Morning Bell',                  270, 2),
('Motion Picture Soundtrack',     212, 2);

--The Bends (id_album = 3)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Planet Telex',          259, 3),
('The Bends',             241, 3),
('High and Dry',          257, 3),
('Fake Plastic Trees',    293, 3),
('Bones',                 189, 3),
('Nice Dream',            228, 3),
('Just',                  234, 3),
('My Iron Lung',          276, 3),
('Bullet Proof..I Wish I Was', 212, 3),
('Black Star',            246, 3),
('Sulk',                  220, 3),
('Street Spirit (Fade Out)', 253, 3);

--The Dark Side of the Moon (id_album = 4)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Speak to Me',              68,  4),
('Breathe',                  169, 4),
('On the Run',               216, 4),
('Time',                     414, 4),
('The Great Gig in the Sky', 284, 4),
('Money',                    383, 4),
('Us and Them',              469, 4),
('Any Colour You Like',      206, 4),
('Brain Damage',             228, 4),
('Eclipse',                  131, 4);

--Wish You Were Here (id_album = 5)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Shine On You Crazy Diamond (Parts I-V)',  811, 5),
('Welcome to the Machine',                  450, 5),
('Have a Cigar',                            307, 5),
('Wish You Were Here',                      334, 5),
('Shine On You Crazy Diamond (Parts VI-IX)',738, 5);

--Nevermind (id_album = 7)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Smells Like Teen Spirit', 301, 7),
('In Bloom',                255, 7),
('Come as You Are',         219, 7),
('Breed',                   184, 7),
('Lithium',                 257, 7),
('Polly',                   174, 7),
('Territorial Pissings',    143, 7),
('Drain You',               224, 7),
('Lounge Act',              156, 7),
('Stay Away',               212, 7),
('On a Plain',              192, 7),
('Something in the Way',    232, 7);

--In Utero (id_album = 8)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Serve the Servants',       218, 8),
('Scentless Apprentice',     228, 8),
('Heart-Shaped Box',         281, 8),
('Rape Me',                  170, 8),
('Frances Farmer Will Have Her Revenge on Seattle', 250, 8),
('Dumb',                     149, 8),
('Very Ape',                 114, 8),
('Milk It',                  232, 8),
('Pennyroyal Tea',           228, 8),
('Radio Friendly Unit Shifter', 277, 8),
('Tourettes',                 95, 8),
('All Apologies',            230, 8);

--Unknown Pleasures (id_album = 9)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Disorder',                 209, 9),
('Day of the Lords',         289, 9),
('Candidate',                178, 9),
('Insight',                  246, 9),
('New Dawn Fades',           280, 9),
('She s Lost Control',       270, 9),
('Shadowplay',               228, 9),
('Wilderness',               158, 9),
('Interzone',                132, 9),
('I Remember Nothing',       358, 9);

--Closer (id_album = 10)
INSERT INTO canzone (nome, durata, id_album) VALUES
('Atrocity Exhibition',      362, 10),
('Isolation',                171, 10),
('Passover',                 290, 10),
('Colony',                   234, 10),
('A Means to an End',        252, 10),
('Heart and Soul',           334, 10),
('Twenty Four Hours',        268, 10),
('The Eternal',              360, 10),
('Decades',                  360, 10);

INSERT INTO canzone_genere (id_canzone, genere) VALUES
(1,  'Alternative Rock'),
(2,  'Art Rock'),
(6,  'Alternative Rock'),
(8,  'Alternative Rock'),
(13, 'Electronic'),
(20, 'Electronic'),
(34, 'Progressive Rock'),
(38, 'Progressive Rock'),
(39, 'Psychedelic Rock'),
(49, 'Grunge'),
(51, 'Grunge'),
(53, 'Alternative Rock'),
(61, 'Grunge'),
(63, 'Grunge'),
(73, 'Post-Punk'),
(78, 'Post-Punk'),
(83, 'Post-Punk'),
(88, 'Post-Punk');

INSERT INTO edizione (anno_stampa, formato, etichetta, paese, id_album) VALUES
-- OK Computer
(1997, 'cd',       'Parlophone',      'Regno Unito', 1),
(2008, 'vinile',   'Parlophone',      'Europa',      1),
(2017, 'vinile',   'XL Recordings',   'Europa',      1),
-- Kid A
(2000, 'cd',       'Parlophone',      'Regno Unito', 2),
(2016, 'vinile',   'XL Recordings',   'Europa',      2),
-- The Bends
(1995, 'cd',       'Parlophone',      'Regno Unito', 3),
-- Dark Side
(1973, 'vinile',   'Harvest',         'Regno Unito', 4),
(2016, 'vinile',   'Pink Floyd Rec',  'Europa',      4),
(1984, 'cd',       'Harvest',         'Regno Unito', 4),
-- Wish You Were Here
(1975, 'vinile',   'Harvest',         'Regno Unito', 5),
-- The Wall
(1979, 'vinile',   'Harvest',         'Regno Unito', 6),
(1994, 'cd',       'EMI',             'Europa',      6),
-- Nevermind
(1991, 'cd',       'DGC Records',     'Stati Uniti', 7),
(2013, 'vinile',   'DGC Records',     'Stati Uniti', 7),
(1991, 'cassetta', 'DGC Records',     'Stati Uniti', 7),
-- In Utero
(1993, 'cd',       'DGC Records',     'Stati Uniti', 8),
(2013, 'vinile',   'DGC Records',     'Stati Uniti', 8),
-- Unknown Pleasures
(1979, 'vinile',   'Factory Records', 'Regno Unito', 9),
(2007, 'vinile',   'Factory Records', 'Europa',      9),
-- Closer
(1980, 'vinile',   'Factory Records', 'Regno Unito', 10),
(2007, 'vinile',   'Factory Records', 'Europa',      10);


--marco_vinyl (id_utente = 1)
INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione, impellicolato, id_edizione, id_utente) VALUES
(35.00,  'ottimo',   'buono',    FALSE, 2,  1),   -- OK Computer vinile 2008
(18.50,  'buono',    'discreto', FALSE, 1,  1),   -- OK Computer cd 1997
(120.00, 'ottimo',   'ottimo',   TRUE,  7,  1),   -- Dark Side vinile 1973 originale
(85.00,  'ottimo',   'buono',    FALSE, 18, 1),   -- Unknown Pleasures vinile 1979 originale
(25.00,  'buono',    'buono',    FALSE, 10, 1);   -- Wish You Were Here vinile 1975

--anna_cd (id_utente = 2)
INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione, impellicolato, id_edizione, id_utente) VALUES
(12.00, 'nuovo',    'nuovo',    TRUE,  13, 2),   -- Nevermind cd 1991
(8.50,  'discreto', 'scarso',   FALSE, 13, 2),   -- Nevermind cd 1991 (altra copia)
(15.00, 'ottimo',   'buono',    FALSE, 16, 2),   -- In Utero cd 1993
(10.00, 'buono',    'buono',    FALSE, 6,  2);   -- The Bends cd 1995

--john_rock (id_utente = 3)
INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione, impellicolato, id_edizione, id_utente) VALUES
(45.00, 'nuovo',    'nuovo',    TRUE,  14, 3),   -- Nevermind vinile 2013
(5.00,  'discreto', 'discreto', FALSE, 15, 3),   -- Nevermind cassetta 1991
(55.00, 'ottimo',   'ottimo',   TRUE,  3,  3),   -- OK Computer vinile 2017
(40.00, 'ottimo',   'buono',    FALSE, 19, 3);   -- Unknown Pleasures vinile 2007

--laura_jazz (id_utente = 4)
INSERT INTO esemplare (prezzo, condizione_disco, condizione_confezione, impellicolato, id_edizione, id_utente) VALUES
(28.00, 'nuovo',    'nuovo',    TRUE,  5,  4),   -- Kid A vinile 2016
(95.00, 'ottimo',   'ottimo',   TRUE,  20, 4),   -- Closer vinile 1980 originale
(22.00, 'buono',    'buono',    FALSE, 21, 4);   -- Closer vinile 2007

--OK Computer (id_album = 1)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(5.0, 'Capolavoro assoluto, ogni traccia e un mondo.',                            1, 1),
(4.5, 'Tra i migliori album degli anni 90, mai invecchiato.',                     2, 1),
(4.0, 'Ottimo ma un po lungo in alcuni punti, Fitter Happier lo skipper sempre.', 3, 1),
(5.0, 'Il disco che ha cambiato il rock per sempre.',                             4, 1);

--Kid A (id_album = 2)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(4.5, 'Coraggioso e visionario, non facile al primo ascolto.',  1, 2),
(3.5, 'Interessante ma preferisco i lavori piu chitarristici.', 3, 2);

--The Bends (id_album = 3)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(4.0, 'Fake Plastic Trees e Street Spirit sono poesia.',        2, 3),
(4.5, 'Il loro disco piu emotivo, sottovalutato.',              4, 3);

--Dark Side of the Moon (id_album = 4)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(5.0, 'Non c e niente da dire, perfezione.',                    1, 4),
(5.0, 'Lo ascolto da 30 anni, non mi stanca mai.',              3, 4),
(4.5, 'Time e Money sono tra i brani piu belli mai scritti.',   4, 4);

--Wish You Were Here (id_album = 5)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(5.0, 'Shine On You Crazy Diamond e il viaggio musicale definitivo.', 1, 5),
(4.5, 'Piu intimo di Dark Side, forse piu bello.',                   2, 5);

--Nevermind (id_album = 7)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(4.5, 'Ha cambiato la musica, punto.',                                2, 7),
(3.5, 'Bello ma preferisco In Utero, piu grezzo e onesto.',          3, 7),
(4.0, 'Teen Spirit e Lithium sono inni generazionali.',              4, 7);

--In Utero (id_album = 8)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(4.5, 'Il vero Cobain, senza compromessi commerciali.',              1, 8),
(4.0, 'Heart-Shaped Box vale da solo il prezzo del disco.',          3, 8);

--Unknown Pleasures (id_album = 9)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(5.0, 'Disorder e New Dawn Fades: due capolavori assoluti.',         1, 9),
(4.5, 'Atmosfera irripetibile, Martin Hannett era un genio.',        4, 9);

--Closer (id_album = 10)
INSERT INTO recensione (voto, commento, id_utente, id_album) VALUES
(5.0, 'Il disco piu oscuro e bello che abbia mai ascoltato.',        1, 10),
(4.0, 'Denso, quasi soffocante. Non per tutti, ma indimenticabile.', 2, 10),
(4.5, 'Atrocity Exhibition e puro terrore sonoro. Magnifico.',       4, 10);

INSERT INTO recensione (voto, commento, id_utente, id_canzone) VALUES
(5.0, 'Il riff piu iconico di sempre.',                                1, 49),
(5.0, 'Paranoid Android e una suite rock in miniatura.',                2, 2),
(4.5, 'Shine On e il tributo perfetto a Syd Barrett.',                 1, 44),
(5.0, 'She s Lost Control: il battito che non si ferma.',              4, 78),
(4.5, 'Atmosfera claustrofobica perfetta.',                            1, 83);