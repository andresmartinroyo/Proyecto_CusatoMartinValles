--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-24 16:39:32

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
-- TOC entry 843 (class 1247 OID 16481)
-- Name: dieta_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['Herbívoro'::character varying, 'Carnívoro'::character varying, 'Omnívoros'::character varying, 'Carroñeros'::character varying, 'Geófagos'::character varying, 'Electrófago'::character varying])::text[])));


ALTER DOMAIN star_wars.dieta_dom OWNER TO postgres;

--
-- TOC entry 851 (class 1247 OID 16475)
-- Name: genero_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.genero_dom AS character varying(10)
	CONSTRAINT genero_check CHECK (((VALUE)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying, 'Desc.'::character varying, 'Otro'::character varying])::text[])));


ALTER DOMAIN star_wars.genero_dom OWNER TO postgres;

--
-- TOC entry 839 (class 1247 OID 16478)
-- Name: rating_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.rating_dom AS integer
	CONSTRAINT rating_dom_check CHECK (((VALUE >= 1) AND (VALUE <= 5)));


ALTER DOMAIN star_wars.rating_dom OWNER TO postgres;

--
-- TOC entry 847 (class 1247 OID 16484)
-- Name: tipo_actor_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['Interpreta'::character varying, 'Presta su voz'::character varying])::text[])));


ALTER DOMAIN star_wars.tipo_actor_dom OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- TOC entry 3350 (class 0 OID 16486)
-- Dependencies: 214
-- Data for Name: especie; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.especie (nombre_especie, idioma) FROM stdin;
\.


--
-- TOC entry 3352 (class 0 OID 16589)
-- Dependencies: 216
-- Data for Name: personaje; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.personaje (nombre_personaje, genero, altura, peso, nombre_especie, nombre_planeta) FROM stdin;
\.


--
-- TOC entry 3351 (class 0 OID 16491)
-- Dependencies: 215
-- Data for Name: planeta; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--

COPY star_wars.planeta (nombre_planeta, sistema_solar, sector, clima) FROM stdin;
\.


--
-- TOC entry 3197 (class 2606 OID 16490)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3201 (class 2606 OID 16597)
-- Name: personaje personaje_nombre_especie_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_nombre_especie_key UNIQUE (nombre_especie);


--
-- TOC entry 3203 (class 2606 OID 16599)
-- Name: personaje personaje_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3205 (class 2606 OID 16595)
-- Name: personaje personaje_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3199 (class 2606 OID 16495)
-- Name: planeta planeta_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.planeta
    ADD CONSTRAINT planeta_pkey PRIMARY KEY (nombre_planeta);


--
-- TOC entry 3206 (class 2606 OID 16600)
-- Name: personaje fk_nombre_especie; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_especie FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


--
-- TOC entry 3207 (class 2606 OID 16605)
-- Name: personaje fk_nombre_planeta; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_planeta FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


-- Completed on 2023-06-24 16:39:33

--
-- PostgreSQL database dump complete
--

