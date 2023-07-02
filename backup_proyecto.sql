--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-07-02 14:18:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 23469)
-- Name: star_wars; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA star_wars;


ALTER SCHEMA star_wars OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 23471)
-- Name: dieta_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Herbivoro'::character varying)::text, ('Carnivoro'::character varying)::text, ('Omnivoro'::character varying)::text, ('Carronero'::character varying)::text, ('Geofago'::character varying)::text, ('Electrofago'::character varying)::text])));


ALTER DOMAIN star_wars.dieta_dom OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 23474)
-- Name: genero_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.genero_dom AS character varying(10)
	CONSTRAINT genero_check CHECK (((VALUE)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text, ('Desc.'::character varying)::text, ('Otro'::character varying)::text])));


ALTER DOMAIN star_wars.genero_dom OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 23477)
-- Name: rating_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.rating_dom AS integer
	CONSTRAINT rating_dom_check CHECK (((VALUE >= 1) AND (VALUE <= 5)));


ALTER DOMAIN star_wars.rating_dom OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 23480)
-- Name: tipo_actor_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Interpreta'::character varying)::text, ('Presta su voz'::character varying)::text])));


ALTER DOMAIN star_wars.tipo_actor_dom OWNER TO postgres;

--
-- TOC entry 877 (class 1247 OID 23483)
-- Name: tipo_especie_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_especie_dom AS text
	CONSTRAINT tipo_especie_dom_check CHECK ((VALUE = ANY (ARRAY['humano'::text, 'robot'::text, 'criatura'::text])));


ALTER DOMAIN star_wars.tipo_especie_dom OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 23823)
-- Name: verificar_ganancia(); Type: FUNCTION; Schema: star_wars; Owner: postgres
--

CREATE FUNCTION star_wars.verificar_ganancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Ganancia < 0 THEN
        RAISE NOTICE 'La película con ID % tuvo pérdidas', NEW.id_pelicula;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION star_wars.verificar_ganancia() OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 23486)
-- Name: verificar_nave(); Type: FUNCTION; Schema: star_wars; Owner: postgres
--

CREATE FUNCTION star_wars.verificar_nave() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Modelo = 'Destructoras Estelares' AND (NEW.Longitud < 900 OR NEW.Uso != 'Combate') THEN
        RAISE EXCEPTION 'Las naves de tipo "Destructoras Estelares" deben tener una longitud de al menos 900 metros y ser de uso "Combate"';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION star_wars.verificar_nave() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 23487)
-- Name: actor; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.actor (
    nombre_actor character varying(50) NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    nacionalidad character varying(50) NOT NULL,
    tipo_actor star_wars.tipo_actor_dom NOT NULL
);


ALTER TABLE star_wars.actor OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 23492)
-- Name: afiliacion; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliacion (
    nombre_af character varying(50) NOT NULL,
    tipo_af character varying(50) NOT NULL,
    nombre_planeta character varying(50)
);


ALTER TABLE star_wars.afiliacion OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 23885)
-- Name: afiliado; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliado (
    nombre_personaje character varying(255) NOT NULL,
    nombre_afiliacion character varying(255) NOT NULL,
    fecha_afiliacion character varying(50) NOT NULL
);


ALTER TABLE star_wars.afiliado OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 23927)
-- Name: aparece; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.aparece (
    nombre_personaje character varying(100) NOT NULL,
    titulo character varying(100) NOT NULL,
    fecha_estreno date NOT NULL
);


ALTER TABLE star_wars.aparece OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 23501)
-- Name: ciudad; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.ciudad (
    nombre_ciudad character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.ciudad OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 23962)
-- Name: combate; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.combate (
    participante1 character varying(100) NOT NULL,
    participante2 character varying(100) NOT NULL,
    id_medio integer NOT NULL,
    fecha_combate character varying(20) NOT NULL,
    lugar character varying(100)
);


ALTER TABLE star_wars.combate OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 23912)
-- Name: dueno; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.dueno (
    nombre_personaje character varying(100) NOT NULL,
    id_nave integer NOT NULL,
    fecha_compra character varying(20) NOT NULL
);


ALTER TABLE star_wars.dueno OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 23805)
-- Name: especie; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.especie (
    nombre_especie character varying(50) NOT NULL,
    nombre_idioma character varying(50)
);


ALTER TABLE star_wars.especie OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 23763)
-- Name: idioma; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.idioma (
    nombre_planeta character varying(50) NOT NULL,
    nombre_idioma character varying(50) NOT NULL
);


ALTER TABLE star_wars.idioma OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 23942)
-- Name: interpreta; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.interpreta (
    nombre_personaje character varying(100) NOT NULL,
    nombre_actor character varying(100) NOT NULL,
    id_medio integer NOT NULL
);


ALTER TABLE star_wars.interpreta OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 23778)
-- Name: lugares_interes; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.lugares_interes (
    nombre_lugar_interes character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL,
    nombre_ciudad character varying(50) NOT NULL
);


ALTER TABLE star_wars.lugares_interes OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 23522)
-- Name: medio; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.medio (
    id_medio integer NOT NULL,
    titulo character varying(50) NOT NULL,
    fecha_estreno date NOT NULL,
    rating star_wars.rating_dom,
    sinopsis character varying(300) NOT NULL
);


ALTER TABLE star_wars.medio OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23525)
-- Name: medio_id_seq; Type: SEQUENCE; Schema: star_wars; Owner: postgres
--

CREATE SEQUENCE star_wars.medio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE star_wars.medio_id_seq OWNER TO postgres;

--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 219
-- Name: medio_id_seq; Type: SEQUENCE OWNED BY; Schema: star_wars; Owner: postgres
--

ALTER SEQUENCE star_wars.medio_id_seq OWNED BY star_wars.medio.id_medio;


--
-- TOC entry 220 (class 1259 OID 23526)
-- Name: nave; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.nave (
    id_nave integer NOT NULL,
    nombre_nave character varying(50) NOT NULL,
    fabricante character varying(50) NOT NULL,
    longitud numeric(10,2) NOT NULL,
    uso character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL
);


ALTER TABLE star_wars.nave OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23529)
-- Name: nave_id_nave_seq; Type: SEQUENCE; Schema: star_wars; Owner: postgres
--

CREATE SEQUENCE star_wars.nave_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE star_wars.nave_id_nave_seq OWNER TO postgres;

--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 221
-- Name: nave_id_nave_seq; Type: SEQUENCE OWNED BY; Schema: star_wars; Owner: postgres
--

ALTER SEQUENCE star_wars.nave_id_nave_seq OWNED BY star_wars.nave.id_nave;


--
-- TOC entry 230 (class 1259 OID 23810)
-- Name: pelicula; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.pelicula (
    id_pelicula integer NOT NULL,
    director character varying(255) NOT NULL,
    duracion time without time zone NOT NULL,
    distribuidor character varying(255) NOT NULL,
    coste_produccion numeric(10,2) NOT NULL,
    tipo_pelicula character varying(255) NOT NULL,
    ingreso_taquilla numeric(10,2) NOT NULL,
    ganancia numeric(10,2) GENERATED ALWAYS AS ((ingreso_taquilla - coste_produccion)) STORED
);


ALTER TABLE star_wars.pelicula OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 23534)
-- Name: personaje; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.personaje (
    nombre_personaje character varying(50) NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    altura double precision,
    peso double precision,
    nombre_especie character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL,
    tipo_especie star_wars.tipo_especie_dom NOT NULL,
    fecha_nacimiento character varying(50),
    fecha_muerte character varying(50),
    creador character varying(50),
    clase character varying(50),
    dieta star_wars.dieta_dom,
    color_piel character varying(50),
    CONSTRAINT chk_especie CHECK (((((tipo_especie)::text = 'humano'::text) AND (dieta IS NULL) AND (clase IS NULL) AND (creador IS NULL) AND (color_piel IS NULL)) OR (((tipo_especie)::text = 'robot'::text) AND (dieta IS NULL) AND (fecha_nacimiento IS NULL) AND (fecha_muerte IS NULL) AND (color_piel IS NULL)) OR (((tipo_especie)::text = 'criatura'::text) AND (clase IS NULL) AND (fecha_nacimiento IS NULL) AND (fecha_muerte IS NULL) AND (creador IS NULL))))
);


ALTER TABLE star_wars.personaje OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 23539)
-- Name: planeta; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.planeta (
    nombre_planeta character varying(50) NOT NULL,
    sistema_solar character varying(50) NOT NULL,
    sector character varying(50) NOT NULL,
    clima character varying(50) NOT NULL
);


ALTER TABLE star_wars.planeta OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 23542)
-- Name: plataformas; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.plataformas (
    nombre_plataforma character varying(50) NOT NULL,
    id_videojuego integer
);


ALTER TABLE star_wars.plataformas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 23545)
-- Name: serie; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.serie (
    id_serie integer NOT NULL,
    creador character varying(50) NOT NULL,
    total_episodios integer NOT NULL,
    canal character varying(50) NOT NULL,
    tipo_serie character varying(50) NOT NULL
);


ALTER TABLE star_wars.serie OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 23982)
-- Name: tripula; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.tripula (
    nombre_personaje character varying(100) NOT NULL,
    id_nave integer NOT NULL,
    tipo_tripulacion character varying(100)
);


ALTER TABLE star_wars.tripula OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 23551)
-- Name: videojuego; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.videojuego (
    id_videojuego integer NOT NULL,
    tipo_juego character varying(50) NOT NULL,
    compania character varying(50) NOT NULL
);


ALTER TABLE star_wars.videojuego OWNER TO postgres;

--
-- TOC entry 3273 (class 2604 OID 23554)
-- Name: medio id_medio; Type: DEFAULT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.medio ALTER COLUMN id_medio SET DEFAULT nextval('star_wars.medio_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 23555)
-- Name: nave id_nave; Type: DEFAULT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.nave ALTER COLUMN id_nave SET DEFAULT nextval('star_wars.nave_id_nave_seq'::regclass);


--
-- TOC entry 3493 (class 0 OID 23487)
-- Dependencies: 215
-- Data for Name: actor; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.actor (nombre_actor, fecha_nacimiento, genero, nacionalidad, tipo_actor) FROM stdin;
Mark Hamill	1951-09-25	M	Estados Unidos	Interpreta
Harrison Ford	1942-07-13	M	Estados Unidos	Interpreta
Daisy Ridley	1992-04-10	F	Reino Unido	Interpreta
Adam Driver	1983-11-19	M	Estados Unidos	Presta su voz
John Boyega	1992-03-17	M	Reino Unido	Interpreta
Oscar Isaac	1979-03-09	M	Guatemala	Interpreta
Anthony Daniels	1946-02-21	M	Reino Unido	Interpreta
Peter Mayhew	1944-05-19	M	Reino Unido	Interpreta
Kenny Baker	1934-08-24	M	Reino Unido	Interpreta
Billy Dee Williams	1937-04-06	M	Estados Unidos	Interpreta
Liam Neeson	1952-06-07	M	Irlanda	Interpreta
Ewan McGregor	1971-03-31	M	Escocia	Interpreta
Natalie Portman	1981-06-09	F	Estados Unidos	Presta su voz
Hayden Christensen	1981-04-19	M	Canadá	Interpreta
Samuel L. Jackson	1948-12-21	M	Estados Unidos	Interpreta
Christopher Lee	1922-05-27	M	Inglaterra	Interpreta
Lupita Nyong'o	1983-03-01	F	Kenia	Interpreta
Benicio del Toro	1967-02-19	M	Puerto Rico	Interpreta
Alec Guinness	1914-04-02	M	Inglaterra	Interpreta
Frank Oz	1944-05-25	M	Estados Unidos	Interpreta
Lando Calrissian	1948-12-21	M	Estados Unidos	Presta su voz
Donald Glover	1983-09-25	M	Estados Unidos	Interpreta
James Earl Jones	1931-01-17	M	Estados Unidos	Interpreta
Temuera Morrison	1960-12-26	M	Nueva Zelanda	Interpreta
Ray Park	1974-08-23	M	Escocia	Interpreta
Peter Cushing	1913-05-26	M	Inglaterra	Interpreta
Gwendoline Christie	1978-10-28	F	Inglaterra	Interpreta
Domhnall Gleeson	1983-05-12	M	Irlanda	Interpreta
Laura Dern	1967-02-10	F	Estados Unidos	Interpreta
Richard E. Grant	1957-05-05	M	Inglaterra	Presta su voz
Billie Lourd	1992-07-17	F	Estados Unidos	Interpreta
Andy Serkis	1964-04-20	M	Inglaterra	Interpreta
Kelly Marie Tran	1989-01-17	F	Estados Unidos	Presta su voz
Naomi Ackie	1992-11-02	F	Inglaterra	Interpreta
Ian McDiarmid	1944-08-11	M	Escocia	Interpreta
Carrie Fisher	1956-10-21	F	Estados Unidos	Presta su voz
\.


--
-- TOC entry 3494 (class 0 OID 23492)
-- Dependencies: 216
-- Data for Name: afiliacion; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.afiliacion (nombre_af, tipo_af, nombre_planeta) FROM stdin;
Imperio Galáctico	Imperio	Coruscant
Alianza Rebelde	Rebelión	Yavin IV
República Galáctica	República	Coruscant
Confederación de Sistemas Independientes	Separatistas	Geonosis
Primera Orden	Imperio	Exegol
Resistencia	Rebelion	Ajan Kloss
\.


--
-- TOC entry 3509 (class 0 OID 23885)
-- Dependencies: 231
-- Data for Name: afiliado; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.afiliado (nombre_personaje, nombre_afiliacion, fecha_afiliacion) FROM stdin;
Darth Vader	Imperio Galáctico	19 BBY
Leia Organa	Alianza Rebelde	0 ABY
Luke Skywalker	Alianza Rebelde	0 ABY
Anakin Skywalker	República Galáctica	22 BBY
Count Dooku	Confederación de Sistemas Independientes	22 BBY
Rey	Resistencia	34 ABY
\.


--
-- TOC entry 3511 (class 0 OID 23927)
-- Dependencies: 233
-- Data for Name: aparece; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.aparece (nombre_personaje, titulo, fecha_estreno) FROM stdin;
Luke Skywalker	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25
Darth Vader	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25
Leia Organa	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25
Han Solo	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25
Chewbacca	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25
Darth Vader	Star Wars: Episodio V - El Imperio Contraataca	1980-02-21
Darth Vader	Star Wars: Episodio VI - El Retorno del Jedi	1983-05-25
Luke Skywalker	Star Wars: Episodio V - El Imperio Contraataca	1980-02-21
Luke Skywalker	Star Wars: Episodio VI - El Retorno del Jedi	1983-05-25
\.


--
-- TOC entry 3495 (class 0 OID 23501)
-- Dependencies: 217
-- Data for Name: ciudad; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.ciudad (nombre_ciudad, nombre_planeta) FROM stdin;
Mos Eisley	Tatooine
Coruscant	Coruscant
Echo Base	Hoth
Bright Tree Village	Endor
Theed	Naboo
Kachirho	Kashyyyk
Geonosis	Geonosis
Yavin 4	Yavin IV
Cloud City	Bespin
Tipoca City	Kamino
Mustafar	Mustafar
Swamp of Dagobah	Dagobah
Niima Outpost	Jakku
Maz"s Castle	Takodana
Hosnian Prime	Hosnian Prime
Capital City	Lothal
Pinyumb	Sullust
Citadel Tower	Scarif
Jedha City	Jedha
Crait Outpost	Crait
Ahch-To Village	Ahch-To
Black Spire Outpost	Batuu
Exegol	Exegol
Pasaana	Pasaana
Kijimi City	Kijimi
Resistance Base	Ajan Kloss
Kerath City	Kef Bir
Aldera	Alderaan
Hutt Space	Nal Hutta
\.


--
-- TOC entry 3513 (class 0 OID 23962)
-- Dependencies: 235
-- Data for Name: combate; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.combate (participante1, participante2, id_medio, fecha_combate, lugar) FROM stdin;
Luke Skywalker	Darth Vader	2	3 ABY, 5:21:80	Ciudad de las Nubes
Obi-Wan Kenobi	Darth Maul	1	32 BBY, 5:19:99	Naboo
Han Solo	Boba Fett	2	3 ABY, 5:21:80	Bespin
\.


--
-- TOC entry 3510 (class 0 OID 23912)
-- Dependencies: 232
-- Data for Name: dueno; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.dueno (nombre_personaje, id_nave, fecha_compra) FROM stdin;
Han Solo	7	0 BBY/0 AC
Luke Skywalker	8	0 BBY/0 AC
Darth Vader	9	0 BBY/0 AC
Moff Gideon	10	0 BBY/0 AC
Darth Vader	11	0 BBY/0 AC
Padmé Amidala	12	32 BBY/0 AC
\.


--
-- TOC entry 3507 (class 0 OID 23805)
-- Dependencies: 229
-- Data for Name: especie; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.especie (nombre_especie, nombre_idioma) FROM stdin;
Humano	Básico Galáctico
Wookiee	Shyriiwook
Droide	Droidspeak
Hutt	Huttese
Rodiano	Básico Galáctico
Togruta	Togruti
Trandoshan	Dosh
Mon Calamari	Mon Calamariano
Ewok	Ewokés
Sullustano	Sullustese
Jawa	Jawaés
Gungan	Gungan Básico
Kel Dor	Kel Dor
Kaleesh	Kaleesh
Ithoriano	Ithoriano
Gamorreano	Gamorreano
Quarren	Quarren
Miraluka	Miraluka
Especie de Yoda	Desconocido
Chiss	Cheunh
Aqualish	Aqualish
Mandaloriano	Mando'a
Sith	Desconocido
Zabrak	Zabrak
Bothan	Bothanés
Kaminoano	Kaminoano
Nautolano	Nautilano
Mirialano	Mirialano
Neimodiano	Neimoidiano
Saquen	Tusken
Hapano	Hapano
Gand	Gand
Weequay	Weequay
Geonosiano	Geonosiano
Falleen	Falleen
Dathomiriano	Dathomiriano
Talz	Talz
Ishi Tib	Ishi Tib
Umbarano	Umbarano
Sakiyano	Sakiyano
Kashyyykiano	Shyriiwook
Nabooano	Básico Galáctico
Kiffar	Kiffu
Echani	Echani
Siniteen	Siniteen
Muun	Muun
Klatooiniano	Klatooiniano
Verpine	Verpino
\.


--
-- TOC entry 3505 (class 0 OID 23763)
-- Dependencies: 227
-- Data for Name: idioma; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.idioma (nombre_planeta, nombre_idioma) FROM stdin;
Tatooine	Jawaese
Tatooine	Huttese
Coruscant	Galactic Basic
Hoth	Huttese
Endor	Ewokese
Naboo	Galactic Basic
Kashyyyk	Shyriiwook
Geonosis	Geonosian
Yavin IV	Massassi
Bespin	Galactic Basic
Kamino	Kaminoan
Mustafar	Galactic Basic
Dagobah	Yoda language
Jakku	Galactic Basic
Takodana	Galactic Basic
Hosnian Prime	Galactic Basic
Lothal	Galactic Basic
Sullust	Sullustese
Scarif	Galactic Basic
Jedha	Galactic Basic
Crait	Galactic Basic
Ahch-To	Galactic Basic
Batuu	Galactic Basic
Exegol	Sith language
Pasaana	Galactic Basic
Kijimi	Galactic Basic
Ajan Kloss	Galactic Basic
Kef Bir	Galactic Basic
Alderaan	Galactic Basic
Malachor	Sith language
Dantooine	Galactic Basic
Corellia	Galactic Basic
Cantonica	Galactic Basic
Cato Neimoidia	Neimoidian
Ryloth	Twi"lek
Mandalore	Galactic Basic
Nal Hutta	Huttese
Ord Mantell	Galactic Basic
Teth	Galactic Basic
Toydaria	Toydarian
Utapau	Utapaun
Raxus Prime	Galactic Basic
Mimban	Galactic Basic
Kessel	Galactic Basic
Dathomir	Sith language
Iridonia	Zabraki
Rattatak	Galactic Basic
Rodia	Rodian
Trandosha	Dosh
Nar Shaddaa	Galactic Basic
Korriban	Sith language
\.


--
-- TOC entry 3512 (class 0 OID 23942)
-- Dependencies: 234
-- Data for Name: interpreta; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.interpreta (nombre_personaje, nombre_actor, id_medio) FROM stdin;
Luke Skywalker	Mark Hamill	1
Luke Skywalker	Mark Hamill	2
Luke Skywalker	Mark Hamill	3
Han Solo	Harrison Ford	1
Han Solo	Harrison Ford	2
Han Solo	Harrison Ford	3
\.


--
-- TOC entry 3506 (class 0 OID 23778)
-- Dependencies: 228
-- Data for Name: lugares_interes; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.lugares_interes (nombre_lugar_interes, nombre_planeta, nombre_ciudad) FROM stdin;
Cantina de Mos Eisley	Tatooine	Mos Eisley
Senado Galáctico	Coruscant	Coruscant
Base Eco	Hoth	Echo Base
Aldea de los Ewoks	Endor	Bright Tree Village
Palacio de Theed	Naboo	Theed
Ciudad Kachirho	Kashyyyk	Kachirho
Fábrica de droides	Geonosis	Geonosis
Templo Jedi	Yavin IV	Yavin 4
Ciudad en las nubes	Bespin	Cloud City
Ciudad Tipoca	Kamino	Tipoca City
Fortaleza de Vader	Mustafar	Mustafar
Pantano de Dagobah	Dagobah	Swamp of Dagobah
Puesto de Niima	Jakku	Niima Outpost
Capital de la Nueva República	Hosnian Prime	Hosnian Prime
Ciudad Capital	Lothal	Capital City
Pinyumb	Sullust	Pinyumb
Torre de la Ciudadela	Scarif	Citadel Tower
Ciudad de Jedha	Jedha	Jedha City
Puesto en Crait	Crait	Crait Outpost
Aldea de los Jedi	Ahch-To	Ahch-To Village
Puesto de avanzada de los contrabandistas	Batuu	Black Spire Outpost
Fortaleza Sith	Exegol	Exegol
Ciudad de Pasaana	Pasaana	Pasaana
Ciudad de Kijimi	Kijimi	Kijimi City
Base de la Resistencia	Ajan Kloss	Resistance Base
Ciudad Kerath	Kef Bir	Kerath City
Aldera	Alderaan	Aldera
Espacio Hutt	Nal Hutta	Hutt Space
\.


--
-- TOC entry 3496 (class 0 OID 23522)
-- Dependencies: 218
-- Data for Name: medio; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.medio (id_medio, titulo, fecha_estreno, rating, sinopsis) FROM stdin;
1	Star Wars: Episodio IV - Una Nueva Esperanza	1977-05-25	5	Un gran clásico de la ciencia ficción que marcó una época.
2	Star Wars: Episodio V - El Imperio Contraataca	1980-05-21	5	Considerada por muchos como la mejor película de Star Wars.
3	Star Wars: Episodio VI - El Retorno del Jedi	1983-05-25	4	El cierre de la trilogía original de Star Wars.
4	Star Wars: Episodio I - La Amenaza Fantasma	1999-05-19	3	El inicio de la trilogía de precuelas de Star Wars.
5	Star Wars: Episodio II - El Ataque de los Clones	2002-05-16	3	La continuación de las precuelas de Star Wars.
6	Star Wars: Episodio III - La Venganza de los Sith	2005-05-19	4	El capítulo final de las precuelas de Star Wars.
7	The Mandalorian	2019-11-12	5	La historia de un cazarrecompensas en solitario en el universo de Star Wars.
8	Star Wars Jedi: Fallen Order	2019-11-15	4	Un videojuego de aventuras y acción en el universo de Star Wars.
9	Star Wars: The Clone Wars	2008-08-15	4	Una serie de animación que expande el universo de Star Wars.
10	Star Wars Rebels	2014-10-03	4	Otra serie de animación que explora el universo de Star Wars.
12	Rogue One: Una Historia de Star Wars	2016-12-16	4	Una película de Star Wars que cuenta la historia de un grupo de rebeldes que intentan robar los planos de la Estrella de la Muerte.
13	Star Wars: El Despertar de la Fuerza	2015-12-18	4	El inicio de una nueva trilogía de Star Wars.
\.


--
-- TOC entry 3498 (class 0 OID 23526)
-- Dependencies: 220
-- Data for Name: nave; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.nave (id_nave, nombre_nave, fabricante, longitud, uso, modelo) FROM stdin;
7	Halcón Milenario	Corellian Engineering Corporation	34.75	Transporte de carga, pasajeros y combate	YT-1300
8	X-wing	Incom Corporation	12.50	Combate espacial	T-65B
9	TIE Fighter	Sistemas de Flota Sienar	6.30	Combate espacial	TIE/LN
10	Estrella de la Muerte	Imperio Galáctico	160000.00	Base militar espacial	DS-1 Orbital Battle Station
11	Destructor Estelar	Kuat Drive Yards	1600.00	Nave de guerra	Imperial-class Star Destroyer
12	Naboo Royal Starship	Theed Palace Space Vessel Engineering Corps	76.00	Transporte diplomático	J-type 327 Nubian
15	X-wing starfighter	Incom Corporation	1000.00	Combate	Destructoras Estelares
17	X starfighter	Incom Corporation	1300.00	Combate	Destructoras Estelares
\.


--
-- TOC entry 3508 (class 0 OID 23810)
-- Dependencies: 230
-- Data for Name: pelicula; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.pelicula (id_pelicula, director, duracion, distribuidor, coste_produccion, tipo_pelicula, ingreso_taquilla) FROM stdin;
1	George Lucas	02:01:00	20th Century Fox	11000000.00	Ciencia ficcion	77539800.00
2	Irvin Kershner	02:02:00	20th Century Fox	18000000.00	Ciencia ficcion	53837506.00
3	Richard Marquand	02:11:00	20th Century Fox	32500000.00	Ciencia ficcion	47510617.00
4	George Lucas	02:16:52	20th Century Fox	99000000.00	Ciencia ficcion	99704467.00
5	George Lucas	02:24:02	20th Century Fox	90000000.00	Ciencia ficcion	64939832.00
6	George Lucas	02:20:10	20th Century Fox	89000000.00	Ciencia ficcion	86835267.00
12	Gareth Edwards	02:13:05	Walt Disney Studios Motion Pictures	20.13	Ciencia ficción	58.69
13	J.J. Abrams	02:34:00	Walt Disney Studios Motion Pictures	50.00	Ciencia ficción	20.00
\.


--
-- TOC entry 3500 (class 0 OID 23534)
-- Dependencies: 222
-- Data for Name: personaje; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.personaje (nombre_personaje, genero, altura, peso, nombre_especie, nombre_planeta, tipo_especie, fecha_nacimiento, fecha_muerte, creador, clase, dieta, color_piel) FROM stdin;
Luke Skywalker	M	1.72	77	Humano	Tatooine	humano	19BBY	34DBY	\N	\N	\N	\N
Leia Organa	F	1.5	49	Humano	Alderaan	humano	19BBY	34ABY	\N	\N	\N	\N
R2-D2	Otro	0.96	32	Robot	Tatooine	robot	\N	\N	Anakin Skywalker	Astromecánico	\N	\N
C-3PO	Otro	1.67	75	Robot	Tatooine	robot	\N	\N	Anakin Skywalker	Protocolo	\N	\N
Chewbacca	M	2.28	112	Wookiee	Kashyyyk	criatura	\N	\N	\N	\N	Omnivoro	Marrón
Jabba el Hutt	Desc.	3.9	1	Hutt	Nal Hutta	criatura	\N	\N	\N	\N	\N	Café
Yoda	Otro	0.66	13	Yodas species	Tatooine	criatura	\N	\N	\N	\N	\N	Verde
Wicket W. Warrick	M	0.8	20	Ewok	Endor	criatura	\N	\N	\N	\N	Omnivoro	\N
Boba Fett	M	1.83	78	Humano	Kamino	humano	31BBY	4DBY	\N	\N	\N	\N
Darth Vader	M	2.03	136	Humano	Tatooine	humano	41.9BBY	4 DBY	\N	\N	\N	\N
Grievous	Otro	2.16	159	Robot	Tatooine	robot	\N	\N	\N	Droide táctico	\N	\N
Rancor	Otro	5.18	1	Rancor	Dathomir	criatura	\N	\N	\N	\N	Carnivoro	Verde
Droideka	Otro	1.83	85	Robot	Tatooine	robot	\N	\N	\N	Droide de combate	\N	\N
Bail Organa	M	1.91	80	Humano	Alderaan	humano	67BBY	0BBY	\N	\N	\N	\N
Padmé Amidala	F	1.65	45	Humano	Naboo	humano	46BBY	19BBY	\N	\N	\N	\N
Jar Jar Binks	Otro	1.96	66	Gungan	Naboo	criatura	\N	\N	\N	\N	Herbivoro	Marrón
Mace Windu	M	1.92	89	Humano	Naboo	humano	72BBY	19BBY	\N	\N	\N	\N
Jango Fett	M	1.83	79	Humano	Tatooine	humano	66BBY	22BBY	\N	\N	\N	\N
Qui-Gon Jinn	M	1.93	89	Humano	Coruscant	humano	92BBY	32BBY	\N	\N	\N	\N
Obi-Wan Kenobi	M	1.82	77	Humano	Naboo	humano	57BBY	0BBY	\N	\N	\N	\N
Anakin Skywalker	M	1.88	84	Humano	Tatooine	humano	41.9BBY	4DBY	\N	\N	\N	\N
Emperor Palpatine	M	1.73	75	Humano	Naboo	humano	84BBY	4DBY	\N	\N	\N	\N
Darth Maul	M	1.75	80	Dathomiriano	Dathomir	criatura	\N	\N	\N	\N	\N	Rojo y negro
Lando Calrissian	M	1.77	79	Humano	Naboo	humano	31BBY	\N	\N	\N	\N	\N
Han Solo	M	1.8	80	Humano	Corellia	humano	29BBY	34ABY	\N	\N	\N	\N
Princesa Amidala	F	1.65	45	Humano	Naboo	humano	46BBY	19BBY	\N	\N	\N	\N
Ahsoka Tano	F	1.68	61	Togruta	Tatooine	criatura	\N	\N	\N	\N	\N	Rojo y blanco
Asajj Ventress	F	1.75	58	Dathomiriano	Dathomir	criatura	\N	\N	\N	\N	\N	Blanco
Cad Bane	M	1.85	84	Duros	Yavin IV	humano	\N	\N	\N	\N	\N	\N
Captain Phasma	F	1.85	76	Humano	Yavin IV	humano	\N	\N	\N	\N	\N	\N
Count Dooku	M	1.93	86	Humano	Naboo	humano	102BBY	19BBY	\N	\N	\N	\N
Darth Sidious	M	1.73	68	Humano	Naboo	humano	84BBY	4DBY	\N	\N	\N	\N
Darth Tyranus	M	1.93	86	Humano	Naboo	humano	102BBY	19BBY	\N	\N	\N	\N
Ezra Bridger	M	1.78	73	Humano	Lothal	humano	19BBY	\N	\N	\N	\N	\N
General Grievous	Otro	2.16	159	Kaleesh	Yavin IV	criatura	\N	\N	\N	\N	\N	Blanco
General Hux	M	1.93	90	Humano	Tatooine	humano	\N	\N	\N	\N	\N	\N
Jyn Erso	F	1.68	55	Humano	Tatooine	humano	22BBY	0BBY	\N	\N	\N	\N
K-2SO	Otro	2.16	159	Droide	Tatooine	robot	\N	\N	Imperial	Droide de seguridad	\N	\N
L3-37	Otro	1.72	54	Droide	Tatooine	robot	\N	\N	Lando Calrissian	Navegante	\N	\N
Maz Kanata	F	1.24	38	Tatooine	Takodana	criatura	\N	\N	\N	\N	\N	Naranja
Moff Gideon	M	1.83	82	Humano	Tatooine	humano	\N	\N	\N	\N	\N	\N
Nien Nunb	M	1.6	68	Sullustano	Sullust	criatura	\N	\N	\N	\N	\N	\N
Qira	F	1.63	52	Humano	Corellia	humano	\N	\N	\N	\N	\N	\N
Rey	F	1.7	54	Humano	Jakku	humano	\N	\N	\N	\N	\N	\N
Sabine Wren	F	1.6	53	Mandaloriana	Tatooine	humano	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3501 (class 0 OID 23539)
-- Dependencies: 223
-- Data for Name: planeta; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.planeta (nombre_planeta, sistema_solar, sector, clima) FROM stdin;
Tatooine	Tatoo	Arkanis	Árido
Coruscant	Coruscant	Coruscant	Templado
Hoth	Hoth	Anoat	Gélido
Endor	Endor	Moddell	Boscoso
Naboo	Naboo	Chommell	Húmedo
Kashyyyk	Kashyyyk	Mytaranor	Tropical
Geonosis	Geonosis	Geonosis	Desértico
Yavin IV	Yavin	Espacio Salvaje	Selva
Bespin	Bespin	Anoat	Gaseoso
Kamino	Kamino	Kamino	Lluvioso
Mustafar	Mustafar	Atravis	Volcánico
Dagobah	Dagobah	Sluis	Pantano
Jakku	Jakku	Sistema de Jakku	Árido
Takodana	Takodana	Territorios del Borde Exterior	Boscoso
Hosnian Prime	Hosnian	Territorios del Borde Exterior	Templado
Lothal	Lothal	Sector Lothal	Templado
Sullust	Sullust	Sistema Sullust	Volcánico
Scarif	Scarif	Sector Scarif	Tropical
Jedha	Jedha	Sector Jedha	Desértico
Crait	Crait	Crait	Salino
Ahch-To	Ahch-To	Territorios del Borde Exterior	Isleño
Batuu	Batuu	Territorios del Borde Exterior	Desértico
Exegol	Exegol	Desconocido	Tenebroso
Pasaana	Pasaana	Territorios del Borde Exterior	Desértico
Kijimi	Kijimi	Territorios del Borde Exterior	Gélido
Ajan Kloss	Ajan Kloss	Territorios del Borde Exterior	Boscoso
Kef Bir	Kef Bir	Territorios del Borde Exterior	Oceánico
Alderaan	Alderaan	Alderaan	Templado
Malachor	Malachor	Territorios del Borde Exterior	Desértico
Dantooine	Dantooine	Territorios del Borde Exterior	Variado
Corellia	Corellia	Territorios del Borde Exterior	Variado
Cantonica	Cantonica	Territorios del Borde Exterior	Desértico
Cato Neimoidia	Cato Neimoidia	Territorios del Borde Exterior	Montañoso
Ryloth	Ryloth	Territorios del Borde Exterior	Árido
Mandalore	Mandalore	Territorios del Borde Exterior	Variado
Nal Hutta	Nal Hutta	Hutt	Pantano
Ord Mantell	Ord Mantell	Territorios del Borde Exterior	Templado
Teth	Teth	Territorios del Borde Exterior	Selva
Toydaria	Toydaria	Territorios del Borde Exterior	Boscoso
Utapau	Utapau	Territorios del Borde Exterior	Desértico
Raxus Prime	Raxus	Territorios del Borde Exterior	Basura
Mimban	Mimban	Territorios del Borde Exterior	Lodoso
Kessel	Kessel	Territorios del Borde Exterior	Árido
Dathomir	Dathomir	Territorios del Borde Exterior	Variado
Iridonia	Iridonia	Territorios del Borde Exterior	Templado
Rattatak	Rattatak	Territorios del Borde Exterior	Árido
Rodia	Rodia	Territorios del Borde Exterior	Selva
Trandosha	Trandosha	Territorios del Borde Exterior	Selva
Nar Shaddaa	Nal Hutta	Hutt	Ciudad
Korriban	Korriban	Desconocido	Árido
\.


--
-- TOC entry 3502 (class 0 OID 23542)
-- Dependencies: 224
-- Data for Name: plataformas; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.plataformas (nombre_plataforma, id_videojuego) FROM stdin;
PlayStation 4	8
Xbox One	8
PC	8
\.


--
-- TOC entry 3503 (class 0 OID 23545)
-- Dependencies: 225
-- Data for Name: serie; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.serie (id_serie, creador, total_episodios, canal, tipo_serie) FROM stdin;
7	Jon Favreau	16	Disney+	Space Western
9	George Lucas	133	Cartoon Network	Animación
10	Simon Kinberg	75	Disney XD	Animación
\.


--
-- TOC entry 3514 (class 0 OID 23982)
-- Dependencies: 236
-- Data for Name: tripula; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.tripula (nombre_personaje, id_nave, tipo_tripulacion) FROM stdin;
Luke Skywalker	7	Piloto
Darth Vader	9	Piloto
Leia Organa	12	Pasajero
C-3PO	7	Pasajero
Han Solo	7	Piloto
Chewbacca	7	Copiloto
\.


--
-- TOC entry 3504 (class 0 OID 23551)
-- Dependencies: 226
-- Data for Name: videojuego; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.videojuego (id_videojuego, tipo_juego, compania) FROM stdin;
8	Acción y aventura	Electronic Arts
\.


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 219
-- Name: medio_id_seq; Type: SEQUENCE SET; Schema: star_wars; Owner: postgres
--

SELECT pg_catalog.setval('star_wars.medio_id_seq', 13, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 221
-- Name: nave_id_nave_seq; Type: SEQUENCE SET; Schema: star_wars; Owner: postgres
--

SELECT pg_catalog.setval('star_wars.nave_id_nave_seq', 17, true);


--
-- TOC entry 3278 (class 2606 OID 23557)
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (nombre_actor);


--
-- TOC entry 3280 (class 2606 OID 23559)
-- Name: afiliacion afiliación_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_pkey" PRIMARY KEY (nombre_af);


--
-- TOC entry 3314 (class 2606 OID 23891)
-- Name: afiliado afiliado_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_pkey PRIMARY KEY (nombre_personaje, nombre_afiliacion, fecha_afiliacion);


--
-- TOC entry 3318 (class 2606 OID 23931)
-- Name: aparece aparece_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_pkey PRIMARY KEY (nombre_personaje, titulo, fecha_estreno);


--
-- TOC entry 3282 (class 2606 OID 23573)
-- Name: ciudad ciudad_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3284 (class 2606 OID 23575)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (nombre_ciudad);


--
-- TOC entry 3286 (class 2606 OID 23577)
-- Name: ciudad ciudad_unico_nombre_planeta; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_unico_nombre_planeta UNIQUE (nombre_ciudad, nombre_planeta);


--
-- TOC entry 3322 (class 2606 OID 23966)
-- Name: combate combate_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_pkey PRIMARY KEY (participante1, participante2, id_medio, fecha_combate);


--
-- TOC entry 3316 (class 2606 OID 23916)
-- Name: dueno dueno_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_pkey PRIMARY KEY (nombre_personaje, id_nave, fecha_compra);


--
-- TOC entry 3310 (class 2606 OID 23809)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3306 (class 2606 OID 23767)
-- Name: idioma idioma_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (nombre_planeta, nombre_idioma);


--
-- TOC entry 3320 (class 2606 OID 23946)
-- Name: interpreta interpreta_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpreta
    ADD CONSTRAINT interpreta_pkey PRIMARY KEY (nombre_personaje, nombre_actor, id_medio);


--
-- TOC entry 3308 (class 2606 OID 23782)
-- Name: lugares_interes lugares_interes_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_pkey PRIMARY KEY (nombre_lugar_interes, nombre_planeta, nombre_ciudad);


--
-- TOC entry 3290 (class 2606 OID 23605)
-- Name: medio medio_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.medio
    ADD CONSTRAINT medio_pkey PRIMARY KEY (id_medio);


--
-- TOC entry 3294 (class 2606 OID 23607)
-- Name: nave nave_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.nave
    ADD CONSTRAINT nave_pkey PRIMARY KEY (id_nave);


--
-- TOC entry 3288 (class 2606 OID 23609)
-- Name: ciudad nombre_planeta_unique; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT nombre_planeta_unique UNIQUE (nombre_planeta);


--
-- TOC entry 3312 (class 2606 OID 23817)
-- Name: pelicula pelicula_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);


--
-- TOC entry 3296 (class 2606 OID 23613)
-- Name: personaje personaje_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3298 (class 2606 OID 23615)
-- Name: planeta planeta_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.planeta
    ADD CONSTRAINT planeta_pkey PRIMARY KEY (nombre_planeta);


--
-- TOC entry 3300 (class 2606 OID 23617)
-- Name: plataformas plataformas_nombre_plataforma_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_nombre_plataforma_key UNIQUE (nombre_plataforma);


--
-- TOC entry 3302 (class 2606 OID 23619)
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (id_serie);


--
-- TOC entry 3292 (class 2606 OID 23621)
-- Name: medio titulo_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.medio
    ADD CONSTRAINT titulo_key UNIQUE (titulo);


--
-- TOC entry 3324 (class 2606 OID 23986)
-- Name: tripula tripula_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_pkey PRIMARY KEY (nombre_personaje, id_nave);


--
-- TOC entry 3304 (class 2606 OID 23625)
-- Name: videojuego videojuego_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_pkey PRIMARY KEY (id_videojuego);


--
-- TOC entry 3349 (class 2620 OID 23626)
-- Name: nave nave_check_longitud_uso; Type: TRIGGER; Schema: star_wars; Owner: postgres
--

CREATE TRIGGER nave_check_longitud_uso BEFORE INSERT OR UPDATE ON star_wars.nave FOR EACH ROW EXECUTE FUNCTION star_wars.verificar_nave();


--
-- TOC entry 3350 (class 2620 OID 23824)
-- Name: pelicula verificar_pelicula_check; Type: TRIGGER; Schema: star_wars; Owner: postgres
--

CREATE TRIGGER verificar_pelicula_check AFTER INSERT OR UPDATE ON star_wars.pelicula FOR EACH ROW EXECUTE FUNCTION star_wars.verificar_ganancia();


--
-- TOC entry 3325 (class 2606 OID 23627)
-- Name: afiliacion afiliación_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_nombre_planeta_fkey" FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3335 (class 2606 OID 23907)
-- Name: afiliado afiliado_nombre_afiliacion_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_fk FOREIGN KEY (nombre_afiliacion) REFERENCES star_wars.afiliacion(nombre_af);


--
-- TOC entry 3336 (class 2606 OID 23902)
-- Name: afiliado afiliado_nombre_personaje_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3339 (class 2606 OID 23932)
-- Name: aparece aparece_nombre_personaje_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_nombre_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3340 (class 2606 OID 23937)
-- Name: aparece aparece_titulo_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_titulo_fk FOREIGN KEY (titulo) REFERENCES star_wars.medio(titulo);


--
-- TOC entry 3326 (class 2606 OID 23652)
-- Name: ciudad ciudad_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3344 (class 2606 OID 23977)
-- Name: combate combate_id_medio_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_id_medio_fk FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3345 (class 2606 OID 23967)
-- Name: combate combate_participante1_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante1_fk FOREIGN KEY (participante1) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3346 (class 2606 OID 23972)
-- Name: combate combate_participante2_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante2_fk FOREIGN KEY (participante2) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3337 (class 2606 OID 23922)
-- Name: dueno dueno_id_nave_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_id_nave_fk FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);


--
-- TOC entry 3338 (class 2606 OID 23917)
-- Name: dueno dueno_nombre_personaje_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_nombre_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3327 (class 2606 OID 23687)
-- Name: personaje fk_nombre_planeta; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_planeta FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3331 (class 2606 OID 23768)
-- Name: idioma idioma_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta) ON DELETE CASCADE;


--
-- TOC entry 3341 (class 2606 OID 23957)
-- Name: interpreta interpreta_id_medio_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpreta
    ADD CONSTRAINT interpreta_id_medio_fk FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3342 (class 2606 OID 23952)
-- Name: interpreta interpreta_nombre_actor_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpreta
    ADD CONSTRAINT interpreta_nombre_actor_fk FOREIGN KEY (nombre_actor) REFERENCES star_wars.actor(nombre_actor);


--
-- TOC entry 3343 (class 2606 OID 23947)
-- Name: interpreta interpreta_nombre_personaje_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpreta
    ADD CONSTRAINT interpreta_nombre_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3332 (class 2606 OID 23788)
-- Name: lugares_interes lugares_interes_nombre_ciudad_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_fkey FOREIGN KEY (nombre_ciudad) REFERENCES star_wars.ciudad(nombre_ciudad);


--
-- TOC entry 3333 (class 2606 OID 23783)
-- Name: lugares_interes lugares_interes_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta) ON DELETE CASCADE;


--
-- TOC entry 3334 (class 2606 OID 23818)
-- Name: pelicula pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3328 (class 2606 OID 23717)
-- Name: plataformas plataformas_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.videojuego(id_videojuego);


--
-- TOC entry 3329 (class 2606 OID 23722)
-- Name: serie serie_id_serie_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_id_serie_fkey FOREIGN KEY (id_serie) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3347 (class 2606 OID 23992)
-- Name: tripula tripula_id_nave_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_id_nave_fk FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);


--
-- TOC entry 3348 (class 2606 OID 23987)
-- Name: tripula tripula_nombre_personaje_fk; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_nombre_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3330 (class 2606 OID 23742)
-- Name: videojuego videojuego_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.medio(id_medio);


-- Completed on 2023-07-02 14:18:44

--
-- PostgreSQL database dump complete
--

