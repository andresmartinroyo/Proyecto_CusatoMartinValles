--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-24 20:05:07

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
-- TOC entry 5 (class 2615 OID 16473)
-- Name: star_wars; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA star_wars;


ALTER SCHEMA star_wars OWNER TO postgres;

--
-- TOC entry 851 (class 1247 OID 16481)
-- Name: dieta_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['Herbívoro'::character varying, 'Carnívoro'::character varying, 'Omnívoros'::character varying, 'Carroñeros'::character varying, 'Geófagos'::character varying, 'Electrófago'::character varying])::text[])));


ALTER DOMAIN star_wars.dieta_dom OWNER TO postgres;

--
-- TOC entry 859 (class 1247 OID 16475)
-- Name: genero_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.genero_dom AS character varying(10)
	CONSTRAINT genero_check CHECK (((VALUE)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying, 'Desc.'::character varying, 'Otro'::character varying])::text[])));


ALTER DOMAIN star_wars.genero_dom OWNER TO postgres;

--
-- TOC entry 847 (class 1247 OID 16478)
-- Name: rating_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.rating_dom AS integer
	CONSTRAINT rating_dom_check CHECK (((VALUE >= 1) AND (VALUE <= 5)));


ALTER DOMAIN star_wars.rating_dom OWNER TO postgres;

--
-- TOC entry 855 (class 1247 OID 16484)
-- Name: tipo_actor_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['Interpreta'::character varying, 'Presta su voz'::character varying])::text[])));


ALTER DOMAIN star_wars.tipo_actor_dom OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16610)
-- Name: afiliacion; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliacion (
    nombre_af character varying(50) NOT NULL,
    tipo_af character varying(50) NOT NULL,
    nombre_planeta character varying(50)
);


ALTER TABLE star_wars.afiliacion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16699)
-- Name: afiliado; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliado (
    nombre_personaje character varying(50) NOT NULL,
    nombre_afiliacion character varying(50),
    fecha_afiliacion date
);


ALTER TABLE star_wars.afiliado OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16632)
-- Name: ciudad; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.ciudad (
    nombre_ciudad character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.ciudad OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16728)
-- Name: criatura; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.criatura (
    nombre_especie character varying(50) NOT NULL,
    color_piel character varying(50) NOT NULL,
    dieta star_wars.dieta_dom NOT NULL
);


ALTER TABLE star_wars.criatura OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16486)
-- Name: especie; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.especie (
    nombre_especie character varying(30) NOT NULL,
    idioma character varying(20) NOT NULL
);


ALTER TABLE star_wars.especie OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16740)
-- Name: humano; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.humano (
    nombre_especie character varying(50) NOT NULL,
    fecha_nacimiento character varying(15) NOT NULL,
    fecha_muerte character varying(15)
);


ALTER TABLE star_wars.humano OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16620)
-- Name: idioma; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.idioma (
    nombre_idioma character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.idioma OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16671)
-- Name: lugares_interes; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.lugares_interes (
    nombre_lugar_de_interes character varying(50) NOT NULL,
    nombre_ciudad character varying(50),
    nombre_planeta character varying(50)
);


ALTER TABLE star_wars.lugares_interes OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16589)
-- Name: personaje; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.personaje (
    nombre_personaje character varying(50) NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    altura double precision,
    peso double precision,
    nombre_especie character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.personaje OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16491)
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
-- TOC entry 222 (class 1259 OID 16718)
-- Name: robot; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.robot (
    nombre_especie character varying(50) NOT NULL,
    creador character varying(50) NOT NULL,
    clase character varying(50) NOT NULL
);


ALTER TABLE star_wars.robot OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 16610)
-- Dependencies: 217
-- Data for Name: afiliacion; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3430 (class 0 OID 16699)
-- Dependencies: 221
-- Data for Name: afiliado; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--



--
-- TOC entry 3428 (class 0 OID 16632)
-- Dependencies: 219
-- Data for Name: ciudad; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3432 (class 0 OID 16728)
-- Dependencies: 223
-- Data for Name: criatura; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3423 (class 0 OID 16486)
-- Dependencies: 214
-- Data for Name: especie; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3433 (class 0 OID 16740)
-- Dependencies: 224
-- Data for Name: humano; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3427 (class 0 OID 16620)
-- Dependencies: 218
-- Data for Name: idioma; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3429 (class 0 OID 16671)
-- Dependencies: 220
-- Data for Name: lugares_interes; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3425 (class 0 OID 16589)
-- Dependencies: 216
-- Data for Name: personaje; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--



--
-- TOC entry 3424 (class 0 OID 16491)
-- Dependencies: 215
-- Data for Name: planeta; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3431 (class 0 OID 16718)
-- Dependencies: 222
-- Data for Name: robot; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3239 (class 2606 OID 16614)
-- Name: afiliacion afiliación_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_pkey" PRIMARY KEY (nombre_af);


--
-- TOC entry 3259 (class 2606 OID 16707)
-- Name: afiliado afiliado_fecha_afiliacion_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_fecha_afiliacion_key UNIQUE (fecha_afiliacion);


--
-- TOC entry 3261 (class 2606 OID 16705)
-- Name: afiliado afiliado_nombre_afiliacion_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_key UNIQUE (nombre_afiliacion);


--
-- TOC entry 3263 (class 2606 OID 16703)
-- Name: afiliado afiliado_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3245 (class 2606 OID 16638)
-- Name: ciudad ciudad_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3247 (class 2606 OID 16636)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (nombre_ciudad);


--
-- TOC entry 3249 (class 2606 OID 16670)
-- Name: ciudad ciudad_unico_nombre_planeta; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_unico_nombre_planeta UNIQUE (nombre_ciudad, nombre_planeta);


--
-- TOC entry 3267 (class 2606 OID 16734)
-- Name: criatura criatura_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.criatura
    ADD CONSTRAINT criatura_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3229 (class 2606 OID 16490)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3269 (class 2606 OID 16744)
-- Name: humano humano_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.humano
    ADD CONSTRAINT humano_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3241 (class 2606 OID 16626)
-- Name: idioma idioma_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3243 (class 2606 OID 16624)
-- Name: idioma idioma_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (nombre_idioma);


--
-- TOC entry 3253 (class 2606 OID 16677)
-- Name: lugares_interes lugares_interes_nombre_ciudad_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_key UNIQUE (nombre_ciudad);


--
-- TOC entry 3255 (class 2606 OID 16679)
-- Name: lugares_interes lugares_interes_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3257 (class 2606 OID 16675)
-- Name: lugares_interes lugares_interes_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_pkey PRIMARY KEY (nombre_lugar_de_interes);


--
-- TOC entry 3251 (class 2606 OID 16659)
-- Name: ciudad nombre_planeta_unique; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT nombre_planeta_unique UNIQUE (nombre_planeta);


--
-- TOC entry 3233 (class 2606 OID 16597)
-- Name: personaje personaje_nombre_especie_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3231 (class 2606 OID 16495)
-- Name: planeta planeta_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.planeta
    ADD CONSTRAINT planeta_pkey PRIMARY KEY (nombre_planeta);


--
-- TOC entry 3265 (class 2606 OID 16722)
-- Name: robot robot_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.robot
    ADD CONSTRAINT robot_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3272 (class 2606 OID 16615)
-- Name: afiliacion afiliación_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_nombre_planeta_fkey" FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3276 (class 2606 OID 16713)
-- Name: afiliado afiliado_nombre_afiliacion_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_fkey FOREIGN KEY (nombre_afiliacion) REFERENCES star_wars.afiliacion(nombre_af);


--
-- TOC entry 3277 (class 2606 OID 16708)
-- Name: afiliado afiliado_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3274 (class 2606 OID 16639)
-- Name: ciudad ciudad_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3279 (class 2606 OID 16735)
-- Name: criatura criatura_nombre_especie_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.criatura
    ADD CONSTRAINT criatura_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


--
-- TOC entry 3270 (class 2606 OID 16600)
-- Name: personaje fk_nombre_especie; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_especie FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


--
-- TOC entry 3271 (class 2606 OID 16605)
-- Name: personaje fk_nombre_planeta; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_planeta FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3280 (class 2606 OID 16745)
-- Name: humano humano_nombre_especie_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.humano
    ADD CONSTRAINT humano_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


--
-- TOC entry 3273 (class 2606 OID 16627)
-- Name: idioma idioma_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3275 (class 2606 OID 16680)
-- Name: lugares_interes lugares_interes_nombre_ciudad_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_ciudad, nombre_planeta) REFERENCES star_wars.ciudad(nombre_ciudad, nombre_planeta) ON DELETE CASCADE;


--
-- TOC entry 3278 (class 2606 OID 16723)
-- Name: robot robot_nombre_especie_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.robot
    ADD CONSTRAINT robot_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


-- Completed on 2023-06-24 20:05:08

--
-- PostgreSQL database dump complete
--

Tabla de Planetas

INSERT INTO star_wars.planeta (nombre_planeta, sistema_solar, sector, clima)
VALUES
  ('Tatooine', 'Tatoo', 'Arkanis', 'Árido'),
  ('Coruscant', 'Coruscant', 'Coruscant', 'Templado'),
  ('Hoth', 'Hoth', 'Anoat', 'Gélido'),
  ('Endor', 'Endor', 'Moddell', 'Boscoso'),
  ('Naboo', 'Naboo', 'Chommell', 'Húmedo'),
  ('Kashyyyk', 'Kashyyyk', 'Mytaranor', 'Tropical'),
  ('Geonosis', 'Geonosis', 'Geonosis', 'Desértico'),
  ('Yavin IV', 'Yavin', 'Espacio Salvaje', 'Selva'),
  ('Bespin', 'Bespin', 'Anoat', 'Gaseoso'),
  ('Kamino', 'Kamino', 'Kamino', 'Lluvioso'),
  ('Mustafar', 'Mustafar', 'Atravis', 'Volcánico'),
  ('Dagobah', 'Dagobah', 'Sluis', 'Pantano'),
  ('Jakku', 'Jakku', 'Sistema de Jakku', 'Árido'),
  ('Takodana', 'Takodana', 'Territorios del Borde Exterior', 'Boscoso'),
  ('Hosnian Prime', 'Hosnian', 'Territorios del Borde Exterior', 'Templado'),
  ('Lothal', 'Lothal', 'Sector Lothal', 'Templado'),
  ('Sullust', 'Sullust', 'Sistema Sullust', 'Volcánico'),
  ('Scarif', 'Scarif', 'Sector Scarif', 'Tropical'),
  ('Jedha', 'Jedha', 'Sector Jedha', 'Desértico'),
  ('Crait', 'Crait', 'Crait', 'Salino'),
  ('Ahch-To', 'Ahch-To', 'Territorios del Borde Exterior', 'Isleño'),
  ('Batuu', 'Batuu', 'Territorios del Borde Exterior', 'Desértico'),
  ('Exegol', 'Exegol', 'Desconocido', 'Tenebroso'),
  ('Pasaana', 'Pasaana', 'Territorios del Borde Exterior', 'Desértico'),
  ('Kijimi', 'Kijimi', 'Territorios del Borde Exterior', 'Gélido'),
  ('Ajan Kloss', 'Ajan Kloss', 'Territorios del Borde Exterior', 'Boscoso'),
  ('Kef Bir', 'Kef Bir', 'Territorios del Borde Exterior', 'Oceánico'),
  ('Alderaan', 'Alderaan', 'Alderaan', 'Templado'),
  ('Malachor', 'Malachor', 'Territorios del Borde Exterior', 'Desértico'),
  ('Dantooine', 'Dantooine', 'Territorios del Borde Exterior', 'Variado'),
  ('Corellia', 'Corellia', 'Territorios del Borde Exterior', 'Variado'),
  ('Cantonica', 'Cantonica', 'Territorios del Borde Exterior', 'Desértico'),
  ('Cato Neimoidia', 'Cato Neimoidia', 'Territorios del Borde Exterior','Montañoso'),
  ('Ryloth', 'Ryloth', 'Territorios del Borde Exterior', 'Árido'),
  ('Mandalore', 'Mandalore', 'Territorios del Borde Exterior', 'Variado'),
  ('Nal Hutta', 'Nal Hutta', 'Hutt', 'Pantano'),
  ('Ord Mantell', 'Ord Mantell', 'Territorios del Borde Exterior', 'Templado'),
  ('Teth', 'Teth', 'Territorios del Borde Exterior', 'Selva'),
  ('Toydaria', 'Toydaria', 'Territorios del Borde Exterior', 'Boscoso'),
  ('Utapau', 'Utapau', 'Territorios del Borde Exterior', 'Desértico'),
  ('Raxus Prime', 'Raxus', 'Territorios del Borde Exterior', 'Basura'),
  ('Mimban', 'Mimban', 'Territorios del Borde Exterior', 'Lodoso'),
  ('Kessel', 'Kessel', 'Territorios del Borde Exterior', 'Árido'),
  ('Dathomir', 'Dathomir', 'Territorios del Borde Exterior', 'Variado'),
  ('Iridonia', 'Iridonia', 'Territorios del Borde Exterior', 'Templado'),
  ('Rattatak', 'Rattatak', 'Territorios del Borde Exterior', 'Árido'),
  ('Rodia', 'Rodia', 'Territorios del Borde Exterior', 'Selva'),
  ('Trandosha', 'Trandosha', 'Territorios del Borde Exterior', 'Selva'),
  ('Nar Shaddaa', 'Nal Hutta', 'Hutt', 'Ciudad'),
  ('Korriban', 'Korriban', 'Desconocido', 'Árido');



Tabla Ciudad

INSERT INTO star_wars.ciudad (nombre_ciudad, nombre_planeta)
VALUES
  ('Mos Eisley', 'Tatooine'),
  ('Coruscant', 'Coruscant'),
  ('Echo Base', 'Hoth'),
  ('Bright Tree Village', 'Endor'),
  ('Theed', 'Naboo'),
  ('Kachirho', 'Kashyyyk'),
  ('Geonosis', 'Geonosis'),
  ('Yavin 4', 'Yavin IV'),
  ('Cloud City', 'Bespin'),
  ('Tipoca City', 'Kamino'),
  ('Mustafar', 'Mustafar'),
  ('Swamp of Dagobah', 'Dagobah'),
  ('Niima Outpost', 'Jakku'),
  ('Maz"s Castle', 'Takodana'),
  ('Hosnian Prime', 'Hosnian Prime'),
  ('Capital City', 'Lothal'),
  ('Pinyumb', 'Sullust'),
  ('Citadel Tower', 'Scarif'),
  ('Jedha City', 'Jedha'),
  ('Crait Outpost', 'Crait'),
  ('Ahch-To Village', 'Ahch-To'),
  ('Black Spire Outpost', 'Batuu'),
  ('Exegol', 'Exegol'),
  ('Pasaana', 'Pasaana'),
  ('Kijimi City', 'Kijimi'),
  ('Resistance Base', 'Ajan Kloss'),
  ('Kerath City', 'Kef Bir'),
  ('Aldera', 'Alderaan'),
  ('Hutt Space', 'Nal Hutta');



Tabla de afiliaciones 

INSERT INTO star_wars.afiliacion (nombre_af, tipo_af, nombre_planeta) VALUES
 ('Imperio Galáctico', 'Imperio', 'Coruscant'),
('Alianza Rebelde', 'Rebelión','Yavin IV'),
('República Galáctica', 'República', 'Coruscant'),
('Confederación de Sistemas Independientes', 'Separatistas',´Geonosis´),
('Primera Orden', 'Imperio','Exegol'),
('Resistencia', 'Rebelion','Ajan Kloss');

Tabla Especie

INSERT INTO star_wars.especie (nombre_especie, idioma)
VALUES
  ('Humano', 'Básico Galáctico'),
  ('Wookiee', 'Shyriiwook'),
  ('Droide', 'Droidspeak'),
  ('Hutt', 'Huttese'),
  ('Rodiano', 'Básico Galáctico'),
  ('Togruta', 'Togruti'),
  ('Trandoshan', 'Dosh'),
  ('Mon Calamari', 'Mon Calamariano'),
  ('Ewok', 'Ewokés'),
  ('Sullustano', 'Sullustese'),
  ('Jawa', 'Jawaés'),
  ('Gungan', 'Gungan Básico'),
  ('Kel Dor', 'Kel Dor'),
  ('Kaleesh', 'Kaleesh'),
  ('Ithoriano', 'Ithoriano'),
  ('Gamorreano', 'Gamorreano'),
  ('Quarren', 'Quarren'),
  ('Miraluka', 'Miraluka'),
  ('Especie de Yoda', 'Desconocido'),
  ('Chiss', 'Cheunh'),
  ('Aqualish', 'Aqualish'),
  ('Mandaloriano', 'Mando''a'),
  ('Sith', 'Desconocido'),
  ('Zabrak', 'Zabrak'),
  ('Bothan', 'Bothanés'),
  ('Kaminoano', 'Kaminoano'),
  ('Nautolano', 'Nautilano'),
  ('Mirialano', 'Mirialano'),
  ('Neimodiano', 'Neimoidiano'),
  ('Saquen', 'Tusken'),
  ('Hapano', 'Hapano'),
  ('Gand', 'Gand'),
  ('Weequay', 'Weequay'),
  ('Geonosiano', 'Geonosiano'),
  ('Falleen', 'Falleen'),
  ('Dathomiriano', 'Dathomiriano'),
  ('Talz', 'Talz'),
  ('Ishi Tib', 'Ishi Tib'),
  ('Umbarano', 'Umbarano'),
  ('Sakiyano', 'Sakiyano'),
  ('Kashyyykiano', 'Shyriiwook'),
  ('Nabooano', 'Básico Galáctico'),
  ('Kiffar', 'Kiffu'),
  ('Echani', 'Echani'),
  ('Siniteen', 'Siniteen'),
  ('Muun', 'Muun'),
  ('Klatooiniano', 'Klatooiniano'),
  ('Verpine', 'Verpino');

Tabla Personajes

INSERT INTO star_wars.personaje (nombre_personaje, genero, altura, peso, nombre_especie, nombre_planeta)
VALUES
  ('Luke Skywalker', 'M', 172, 77, 'Humano', 'Tatooine'),
  ('Leia Organa', 'F', 150, 49, 'Humano', 'Alderaan'),
  ('Darth Vader', 'M', 202, 136, 'Humano', 'Tatooine'),
  ('Han Solo', 'M', 180, 80, 'Humano', 'Corellia'),
  ('Anakin Skywalker', 'M', 188, 84, 'Humano', 'Tatooine'),
  ('Padmé Amidala', 'F', 165, 45, 'Humano', 'Naboo'),
  ('Qui-Gon Jinn', 'M', 193, 89, 'Humano', 'Coruscant'),
  ('Rey', 'F', 170, 65, 'Humano', 'Jakku'),
  ('Poe Dameron', 'M', 180, 80, 'Humano', 'Yavin IV'),
  ('R2-D2', 'Desc.', 109, 32, 'Droide', 'Naboo'),
  ('C-3PO', 'Desc.', 167, 75, 'Droide', 'Tatooine'),
  ('Chewbacca', 'M', 228, 112, 'Wookiee', 'Kashyyyk'),
  ('Lando Calrissian', 'M', 177, 79, 'Humano', 'Sullust'),
  ('Jabba the Hutt', 'Desc.', 367, 1, 'Hutt', 'Nal Hutta'),
  ('Boba Fett', 'M', 183, 78, 'Humano', 'Kamino'),
  ('Darth Maul', 'M', 185, 80, 'Zabrak', 'Dathomir'),
  ('Emperor Palpatine', 'M', 170, 75, 'Humano', 'Naboo'),
  ('Darth Sidious', 'M', 173, 75, 'Humano', 'Naboo'),
  ('Mandalorian', 'M', 183, 80, 'Mandaloriano', 'Mandalore'),
  ('Captain Rex', 'M', 183, 80, 'Humano', 'Kamino'),
  ('Ezra Bridger', 'M', 170, 68, 'Humano', 'Lothal'),
  ('IG-88', 'Desc.', 200, 140, 'Droide', 'Ord Mantell'),
  ('Jar Jar Binks', 'M', 196, 66, 'Gungan', 'Naboo'),
  ('Yoda', 'Desc.', 66, 17, 'Especie de Yoda', 'Dagobah'),
  ('Wicket W. Warrick', 'M', 88, 20, 'Ewok', 'Endor'),
  ('Jawa', 'Desc.', 100, 35, 'Jawa', 'Tatooine'),
  ('Bossk', 'M', 190, 94, 'Trandoshan', 'Trandosha'),
  ('Nien Nunb', 'M', 160, 68, 'Sullustano', 'Sullust'),
  ('Visas Marr', 'F', 170, 55, 'Miraluka', 'Korriban'),
  ('Dengar', 'M', 193, 80, 'Humano', 'Corellia');






