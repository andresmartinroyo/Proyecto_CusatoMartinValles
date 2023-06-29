--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-27 21:03:42

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
-- TOC entry 6 (class 2615 OID 17241)
-- Name: star_wars; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA star_wars;


ALTER SCHEMA star_wars OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 17243)
-- Name: dieta_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.dieta_dom AS character varying(20)
  CONSTRAINT dieta_dom_check CHECK (VALUE IN ('Herbivoro', 'Carnivoro', 'Omnivoro', 'Carronero', 'Geofago', 'Electrofago'));


ALTER DOMAIN star_wars.dieta_dom OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 17246)
-- Name: genero_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.genero_dom AS character varying(10)
	CONSTRAINT genero_check CHECK (((VALUE)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text, ('Desc.'::character varying)::text, ('Otro'::character varying)::text])));


ALTER DOMAIN star_wars.genero_dom OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 17249)
-- Name: rating_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.rating_dom AS integer
	CONSTRAINT rating_dom_check CHECK (((VALUE >= 1) AND (VALUE <= 5)));


ALTER DOMAIN star_wars.rating_dom OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 17252)
-- Name: tipo_actor_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Interpreta'::character varying)::text, ('Presta su voz'::character varying)::text])));


ALTER DOMAIN star_wars.tipo_actor_dom OWNER TO postgres;

--
-- TOC entry 937 (class 1247 OID 17635)
-- Name: tipo_especie_dom; Type: DOMAIN; Schema: star_wars; Owner: postgres
--

CREATE DOMAIN star_wars.tipo_especie_dom AS text
	CONSTRAINT tipo_especie_dom_check CHECK ((VALUE = ANY (ARRAY['humano'::text, 'robot'::text, 'criatura'::text])));


ALTER DOMAIN star_wars.tipo_especie_dom OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 17413)
-- Name: verificar_ganancia(); Type: FUNCTION; Schema: star_wars; Owner: postgres
--

CREATE FUNCTION star_wars.verificar_ganancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Ganancia < 0 THEN
        RAISE NOTICE 'La película con ID % tuvo pérdidas', NEW.ID;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION star_wars.verificar_ganancia() OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 17480)
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
-- TOC entry 223 (class 1259 OID 17384)
-- Name: actor; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.especie (
    nombre_especie character varying(30) NOT NULL,
    idioma character varying(20) NOT NULL
);


ALTER TABLE star_wars.especie OWNER TO postgres;

CREATE TABLE star_wars.actor (
    nombre_actor character varying(50) NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    nacionalidad character varying(50) NOT NULL,
    tipo_actor star_wars.tipo_actor_dom NOT NULL
);


ALTER TABLE star_wars.actor OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17254)
-- Name: afiliacion; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliacion (
    nombre_af character varying(50) NOT NULL,
    tipo_af character varying(50) NOT NULL,
    nombre_planeta character varying(50)
);


ALTER TABLE star_wars.afiliacion OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17257)
-- Name: afiliado; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.afiliado (
    nombre_personaje character varying(50) NOT NULL,
    nombre_afiliacion character varying(50),
    fecha_afiliacion date
);


ALTER TABLE star_wars.afiliado OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17585)
-- Name: aparece; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.aparece (
    nombre_personaje character varying(50) NOT NULL,
    id_medio integer NOT NULL,
    fecha_estreno date
);


ALTER TABLE star_wars.aparece OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17260)
-- Name: ciudad; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.ciudad (
    nombre_ciudad character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.ciudad OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17509)
-- Name: combate; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.combate (
    participante1 character varying(50) NOT NULL,
    participante2 character varying(50) NOT NULL,
    id_medio integer NOT NULL,
    fecha_combate character varying(20) NOT NULL,
    lugar character varying(50) NOT NULL
);


ALTER TABLE star_wars.combate OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17619)
-- Name: dueno; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.dueno (
    nombre_personaje character varying(50) NOT NULL,
    id_nave integer NOT NULL,
    fecha_compra date NOT NULL
);


ALTER TABLE star_wars.dueno OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17274)
-- Name: idioma; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.idioma (
    nombre_idioma character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);


ALTER TABLE star_wars.idioma OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17533)
-- Name: interpretado; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.interpretado (
    nombre_personaje character varying(50) NOT NULL,
    nombre_actor character varying(50) NOT NULL,
    id_medio integer NOT NULL
);


ALTER TABLE star_wars.interpretado OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17277)
-- Name: lugares_interes; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.lugares_interes (
    nombre_lugar_de_interes character varying(50) NOT NULL,
    nombre_ciudad character varying(50),
    nombre_planeta character varying(50)
);


ALTER TABLE star_wars.lugares_interes OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17392)
-- Name: medio; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.medio (
    id_medio integer NOT NULL,
    titulo character varying(50) NOT NULL,
    fecha_estreno date NOT NULL,
    rating star_wars.rating_dom,
    sinopsis character varying(50) NOT NULL
);


ALTER TABLE star_wars.medio OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17391)
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
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 224
-- Name: medio_id_seq; Type: SEQUENCE OWNED BY; Schema: star_wars; Owner: postgres
--

ALTER SEQUENCE star_wars.medio_id_seq OWNED BY star_wars.medio.id_medio;


--
-- TOC entry 231 (class 1259 OID 17474)
-- Name: nave; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.nave (
    id_nave serial NOT NULL,
    nombre_nave character varying(50) NOT NULL,
    fabricante character varying(50) NOT NULL,
    longitud numeric(10,2) NOT NULL,
    uso character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL
);


ALTER TABLE star_wars.nave OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17473)
-- Name: nave_id_nave_seq; Type: SEQUENCE; Schema: star_wars; Owner: postgres
--

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 230
-- Name: nave_id_nave_seq; Type: SEQUENCE OWNED BY; Schema: star_wars; Owner: postgres
--

ALTER SEQUENCE star_wars.nave_id_nave_seq OWNED BY star_wars.nave.id_nave;


--
-- TOC entry 226 (class 1259 OID 17425)
-- Name: pelicula; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.pelicula (
    id_pelicula integer NOT NULL,
    director character varying(50),
    duracion integer,
    distribuidor character varying(50),
    coste_produccion numeric(10,2),
    tipo_pelicula character varying(50),
    ingreso_taquilla numeric(10,2),
    ganancia numeric(10,2) GENERATED ALWAYS AS ((ingreso_taquilla - coste_produccion)) STORED
);


ALTER TABLE star_wars.pelicula OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17280)
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
    color_piel character varying(50)
);


ALTER TABLE star_wars.personaje OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17285)
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
-- TOC entry 229 (class 1259 OID 17456)
-- Name: plataformas; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.plataformas (
    nombre_plataforma character varying(50) NOT NULL,
    id_videojuego integer
);


ALTER TABLE star_wars.plataformas OWNER TO postgres;







CREATE TABLE star_wars.serie (
    id_serie integer NOT NULL,
    creador character varying(50) NOT NULL,
    total_episodios integer NOT NULL,
    canal character varying(50) NOT NULL,
    tipo_serie character varying(50) NOT NULL
);


ALTER TABLE star_wars.serie OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17604)
-- Name: tripula; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.tripula (
    nombre_personaje character varying(50) NOT NULL,
    id_nave integer NOT NULL,
    tipo_tripulacion character varying(50)
);


ALTER TABLE star_wars.tripula OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17446)
-- Name: videojuego; Type: TABLE; Schema: star_wars; Owner: postgres
--

CREATE TABLE star_wars.videojuego (
    id_videojuego integer NOT NULL,
    tipo_juego character varying(50) NOT NULL,
    compania character varying(50) NOT NULL
);


ALTER TABLE star_wars.videojuego OWNER TO postgres;

--
-- TOC entry 3273 (class 2604 OID 17395)
-- Name: medio id_medio; Type: DEFAULT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.medio ALTER COLUMN id_medio SET DEFAULT nextval('star_wars.medio_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 17477)
-- Name: nave id_nave; Type: DEFAULT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.nave ALTER COLUMN id_nave SET DEFAULT nextval('star_wars.nave_id_nave_seq'::regclass);


--
-- TOC entry 3518 (class 0 OID 17384)
-- Dependencies: 223
-- Data for Name: actor; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3510 (class 0 OID 17254)
-- Dependencies: 215
-- Data for Name: afiliacion; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3511 (class 0 OID 17257)
-- Dependencies: 216
-- Data for Name: afiliado; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3529 (class 0 OID 17585)
-- Dependencies: 234
-- Data for Name: aparece; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3512 (class 0 OID 17260)
-- Dependencies: 217
-- Data for Name: ciudad; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--





--
-- TOC entry 3527 (class 0 OID 17509)
-- Dependencies: 232
-- Data for Name: combate; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3531 (class 0 OID 17619)
-- Dependencies: 236
-- Data for Name: dueno; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3513 (class 0 OID 17274)
-- Dependencies: 218
-- Data for Name: idioma; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3528 (class 0 OID 17533)
-- Dependencies: 233
-- Data for Name: interpretado; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3514 (class 0 OID 17277)
-- Dependencies: 219
-- Data for Name: lugares_interes; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3520 (class 0 OID 17392)
-- Dependencies: 225
-- Data for Name: medio; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3526 (class 0 OID 17474)
-- Dependencies: 231
-- Data for Name: nave; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3521 (class 0 OID 17425)
-- Dependencies: 226
-- Data for Name: pelicula; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3515 (class 0 OID 17280)
-- Dependencies: 220
-- Data for Name: personaje; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--



--
-- TOC entry 3516 (class 0 OID 17285)
-- Dependencies: 221
-- Data for Name: planeta; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--



--
-- TOC entry 3524 (class 0 OID 17456)
-- Dependencies: 229
-- Data for Name: plataformas; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--








--
-- TOC entry 3522 (class 0 OID 17436)
-- Dependencies: 227
-- Data for Name: serie; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3530 (class 0 OID 17604)
-- Dependencies: 235
-- Data for Name: tripula; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3523 (class 0 OID 17446)
-- Dependencies: 228
-- Data for Name: videojuego; Type: TABLE DATA; Schema: star_wars; Owner: postgres
--




--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 224
-- Name: medio_id_seq; Type: SEQUENCE SET; Schema: star_wars; Owner: postgres
--

SELECT pg_catalog.setval('star_wars.medio_id_seq', 1, false);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 230
-- Name: nave_id_nave_seq; Type: SEQUENCE SET; Schema: star_wars; Owner: postgres
--

SELECT pg_catalog.setval('star_wars.nave_id_nave_seq', 1, false);


--
-- TOC entry 3309 (class 2606 OID 17390)
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (nombre_actor);


ALTER TABLE ONLY star_wars.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (nombre_especie);


--
-- TOC entry 3277 (class 2606 OID 17292)
-- Name: afiliacion afiliación_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_pkey" PRIMARY KEY (nombre_af);


--
-- TOC entry 3279 (class 2606 OID 17294)
-- Name: afiliado afiliado_fecha_afiliacion_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_fecha_afiliacion_key UNIQUE (fecha_afiliacion);


--
-- TOC entry 3281 (class 2606 OID 17296)
-- Name: afiliado afiliado_nombre_afiliacion_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_key UNIQUE (nombre_afiliacion);


--
-- TOC entry 3283 (class 2606 OID 17298)
-- Name: afiliado afiliado_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3335 (class 2606 OID 17593)
-- Name: aparece aparece_fecha_estreno_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_fecha_estreno_key UNIQUE (fecha_estreno);


--
-- TOC entry 3337 (class 2606 OID 17591)
-- Name: aparece aparece_id_medio_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_id_medio_key UNIQUE (id_medio);


--
-- TOC entry 3339 (class 2606 OID 17589)
-- Name: aparece aparece_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3285 (class 2606 OID 17300)
-- Name: ciudad ciudad_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3287 (class 2606 OID 17302)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (nombre_ciudad);


--
-- TOC entry 3289 (class 2606 OID 17304)
-- Name: ciudad ciudad_unico_nombre_planeta; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_unico_nombre_planeta UNIQUE (nombre_ciudad, nombre_planeta);


--
-- TOC entry 3323 (class 2606 OID 17517)
-- Name: combate combate_id_medio_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_id_medio_key UNIQUE (id_medio);


--
-- TOC entry 3325 (class 2606 OID 17515)
-- Name: combate combate_participante2_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante2_key UNIQUE (participante2);


--
-- TOC entry 3327 (class 2606 OID 17513)
-- Name: combate combate_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_pkey PRIMARY KEY (participante1);


--
-- TOC entry 3343 (class 2606 OID 17623)
-- Name: dueno dueno_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_pkey PRIMARY KEY (nombre_personaje, id_nave, fecha_compra);


--
-- TOC entry 3293 (class 2606 OID 17312)
-- Name: idioma idioma_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3295 (class 2606 OID 17314)
-- Name: idioma idioma_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (nombre_idioma);


--
-- TOC entry 3329 (class 2606 OID 17541)
-- Name: interpretado interpretado_id_medio_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_id_medio_key UNIQUE (id_medio);


--
-- TOC entry 3331 (class 2606 OID 17539)
-- Name: interpretado interpretado_nombre_actor_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_actor_key UNIQUE (nombre_actor);


--
-- TOC entry 3333 (class 2606 OID 17537)
-- Name: interpretado interpretado_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_pkey PRIMARY KEY (nombre_personaje);


--
-- TOC entry 3297 (class 2606 OID 17316)
-- Name: lugares_interes lugares_interes_nombre_ciudad_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_key UNIQUE (nombre_ciudad);


--
-- TOC entry 3299 (class 2606 OID 17318)
-- Name: lugares_interes lugares_interes_nombre_planeta_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_planeta_key UNIQUE (nombre_planeta);


--
-- TOC entry 3301 (class 2606 OID 17320)
-- Name: lugares_interes lugares_interes_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_pkey PRIMARY KEY (nombre_lugar_de_interes);


--
-- TOC entry 3311 (class 2606 OID 17397)
-- Name: medio medio_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.medio
    ADD CONSTRAINT medio_pkey PRIMARY KEY (id_medio);


--
-- TOC entry 3321 (class 2606 OID 17479)
-- Name: nave nave_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.nave
    ADD CONSTRAINT nave_pkey PRIMARY KEY (id_nave);


--
-- TOC entry 3291 (class 2606 OID 17322)
-- Name: ciudad nombre_planeta_unique; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT nombre_planeta_unique UNIQUE (nombre_planeta);


--
-- TOC entry 3313 (class 2606 OID 17430)
-- Name: pelicula pelicula_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);


--
-- TOC entry 3303 (class 2606 OID 17324)
-- Name: personaje personaje_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_pkey PRIMARY KEY (nombre_personaje);

    


--
-- TOC entry 3305 (class 2606 OID 17326)
-- Name: planeta planeta_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.planeta
    ADD CONSTRAINT planeta_pkey PRIMARY KEY (nombre_planeta);


--
-- TOC entry 3319 (class 2606 OID 17460)
-- Name: plataformas plataformas_nombre_plataforma_key; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_nombre_plataforma_key UNIQUE (nombre_plataforma);






--
-- TOC entry 3315 (class 2606 OID 17440)
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (id_serie);


--
-- TOC entry 3341 (class 2606 OID 17608)
-- Name: tripula tripula_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_pkey PRIMARY KEY (nombre_personaje, id_nave);


--
-- TOC entry 3317 (class 2606 OID 17450)
-- Name: videojuego videojuego_pkey; Type: CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_pkey PRIMARY KEY (id_videojuego);


--
-- TOC entry 3367 (class 2620 OID 17481)
-- Name: nave nave_check_longitud_uso; Type: TRIGGER; Schema: star_wars; Owner: postgres
--

CREATE TRIGGER nave_check_longitud_uso BEFORE INSERT OR UPDATE ON star_wars.nave FOR EACH ROW EXECUTE FUNCTION star_wars.verificar_nave();


--
-- TOC entry 3344 (class 2606 OID 17329)
-- Name: afiliacion afiliación_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_nombre_planeta_fkey" FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3345 (class 2606 OID 17334)
-- Name: afiliado afiliado_nombre_afiliacion_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_fkey FOREIGN KEY (nombre_afiliacion) REFERENCES star_wars.afiliacion(nombre_af);


--
-- TOC entry 3346 (class 2606 OID 17339)
-- Name: afiliado afiliado_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3361 (class 2606 OID 17599)
-- Name: aparece aparece_id_medio_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3362 (class 2606 OID 17594)
-- Name: aparece aparece_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3347 (class 2606 OID 17344)
-- Name: ciudad ciudad_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3355 (class 2606 OID 17528)
-- Name: combate combate_id_medio_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3356 (class 2606 OID 17518)
-- Name: combate combate_participante1_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante1_fkey FOREIGN KEY (participante1) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3357 (class 2606 OID 17523)
-- Name: combate combate_participante2_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante2_fkey FOREIGN KEY (participante2) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3365 (class 2606 OID 17629)
-- Name: dueno dueno_id_nave_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_id_nave_fkey FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);


--
-- TOC entry 3366 (class 2606 OID 17624)
-- Name: dueno dueno_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3350 (class 2606 OID 17359)
-- Name: personaje fk_nombre_planeta; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_planeta FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta),
    ADD CONSTRAINT fk_nombre_especie FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);


--
-- TOC entry 3348 (class 2606 OID 17369)
-- Name: idioma idioma_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);


--
-- TOC entry 3358 (class 2606 OID 17552)
-- Name: interpretado interpretado_id_medio_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3359 (class 2606 OID 17547)
-- Name: interpretado interpretado_nombre_actor_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_actor_fkey FOREIGN KEY (nombre_actor) REFERENCES star_wars.actor(nombre_actor);


--
-- TOC entry 3360 (class 2606 OID 17542)
-- Name: interpretado interpretado_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3349 (class 2606 OID 17374)
-- Name: lugares_interes lugares_interes_nombre_ciudad_nombre_planeta_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_ciudad, nombre_planeta) REFERENCES star_wars.ciudad(nombre_ciudad, nombre_planeta) ON DELETE CASCADE;


--
-- TOC entry 3351 (class 2606 OID 17431)
-- Name: pelicula pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3354 (class 2606 OID 17461)
-- Name: plataformas plataformas_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.videojuego(id_videojuego);


--
-- TOC entry 3352 (class 2606 OID 17441)
-- Name: serie serie_id_serie_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_id_serie_fkey FOREIGN KEY (id_serie) REFERENCES star_wars.medio(id_medio);


--
-- TOC entry 3363 (class 2606 OID 17614)
-- Name: tripula tripula_id_nave_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_id_nave_fkey FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);


--
-- TOC entry 3364 (class 2606 OID 17609)
-- Name: tripula tripula_nombre_personaje_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);


--
-- TOC entry 3353 (class 2606 OID 17451)
-- Name: videojuego videojuego_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: star_wars; Owner: postgres
--

ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.medio(id_medio);


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



INSERT INTO star_wars.afiliacion (nombre_af, tipo_af, nombre_planeta) VALUES
 ('Imperio Galáctico', 'Imperio', 'Coruscant'),
('Alianza Rebelde', 'Rebelión','Yavin IV'),
('República Galáctica', 'República', 'Coruscant'),
('Confederación de Sistemas Independientes', 'Separatistas','Geonosis'),
('Primera Orden', 'Imperio','Exegol'),
('Resistencia', 'Rebelion','Ajan Kloss');


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


INSERT INTO star_wars.personaje (nombre_personaje, genero, altura, peso, nombre_especie, nombre_planeta, tipo_especie, fecha_nacimiento, fecha_muerte, creador, clase, dieta, color_piel)
VALUES
  ('Luke Skywalker', 'M', 1.72, 77, 'Humano', 'Tatooine', 'humano', '19BBY', NULL, 'George Lucas', 'Jedi', 'Omnivoro', 'Blanco'),
  ('Leia Organa', 'F', 1.50, 49, 'Humano', 'Alderaan', 'humano', '19BBY', '35ABY', 'George Lucas', 'Princesa', 'Omnivoro', 'Blanco'),
  ('Darth Vader', 'M', 2.03, 136, 'Humano', 'Tatooine', 'humano', '41.9BBY', '4ABY', 'George Lucas', 'Sith', 'Carronero', 'Blanco'),
  ('Han Solo', 'M', 1.80, 80, 'Humano', 'Corellia', 'humano', '29BBY', NULL, 'George Lucas', 'Contrabandista', 'Omnivoro', 'Blanco'),
  ('Yoda', 'M', 0.66, 13, 'Humano', 'Dagobah', 'humano', '896BBY', '4ABY', 'George Lucas', 'Jedi', 'Herbivoro', 'Verde'),
  ('C-3PO', 'Desc.', 1.67, 75, 'Droide', 'Tatooine', 'robot', NULL, NULL, 'George Lucas', 'Protocolo', 'Omnivoro', 'Oro'),
  ('Chewbacca', 'M', 2.28, 112, 'Wookiee', 'Kashyyyk', 'criatura', '200BBY', NULL, 'George Lucas', 'Contrabandista', 'Herbivoro', 'Marrón'),
  ('Boba Fett', 'M', 1.83, 78, 'Humano', 'Kamino', 'humano', '31.5BBY', '4ABY', 'George Lucas', 'Cazarrecompensas', 'Carnivoro', 'Verde'),
  ('Padmé Amidala', 'F', 1.65, 45, 'Humano', 'Naboo', 'humano', '46BBY', '19BBY', 'George Lucas', 'Reina', 'Omnivoro', 'Blanco'),
  ('Obi-Wan Kenobi', 'M', 1.82, 77, 'Humano', 'Tatooine', 'humano', '57BBY', '0ABY', 'George Lucas', 'Jedi', 'Omnivoro', 'Blanco'),
  ('Darth Maul', 'M', 1.75, 80, 'Zabrak', 'Dathomir', 'criatura', '54BBY', '2ABY', 'George Lucas', 'Sith', 'Carnivoro', 'Rojo'),
  ('Lando Calrissian', 'M', 1.77, 79, 'Humano', 'Alderaan', 'humano', '31BBY', NULL, 'George Lucas', 'Contrabandista', 'Omnivoro', 'Negro'),
  ('Rey', 'F', 1.70, 55, 'Humano', 'Jakku', 'humano', '15ABY', NULL, 'George Lucas', 'Jedi', 'Omnivoro', 'Marrón'),
  ('Kylo Ren', 'M', 1.89, 84, 'Humano', 'Yavin IV', 'humano', '5ABY', '35ABY', 'George Lucas', 'Sith', 'Carronero', 'Negro'),
  ('Poe Dameron', 'M', 1.79, 77, 'Humano', 'Yavin IV', 'humano', '9ABY', NULL, 'George Lucas', 'Piloto', 'Omnivoro', 'Blanco'),
  ('BB-8', 'Desc.', 0.67, 18, 'Droide', 'Jakku', 'robot', NULL, NULL, 'George Lucas', 'Astromecánico', 'Electrofago', 'Naranja'),
  ('Finn', 'M', 1.78, 84, 'Humano', 'Tatooine', 'humano', '11ABY', NULL, 'George Lucas', 'Soldado', 'Omnivoro', 'Negro'),
  ('Mace Windu', 'M', 1.92, 89, 'Humano', 'Alderaan', 'humano', '72BBY', '19BBY', 'George Lucas', 'Jedi', 'Omnivoro', 'Negro'),
  ('Jabba the Hutt', 'Desc.', 3.90, 1500, 'Hutt', 'Tatooine', 'criatura', NULL, '4ABY', 'George Lucas', 'Gánster', 'Carnivoro', 'Verde'),
  ('Anakin Skywalker', 'M', 1.88, 84, 'Humano', 'Tatooine', 'humano', '41.9BBY', '4ABY', 'George Lucas', 'Jedi', 'Omnivoro', 'Blanco');


INSERT INTO star_wars.actor (nombre_actor, fecha_nacimiento, genero, nacionalidad, tipo_actor)
VALUES
  ('Mark Hamill', '1951-09-25', 'M', 'Estados Unidos', 'Interpreta'),
  ('Harrison Ford', '1942-07-13', 'M', 'Estados Unidos', 'Interpreta'),
  ('Daisy Ridley', '1992-04-10', 'F', 'Reino Unido', 'Interpreta'),
  ('Adam Driver', '1983-11-19', 'M', 'Estados Unidos', 'Interpreta'),
  ('John Boyega', '1992-03-17', 'M', 'Reino Unido', 'Interpreta'),
  ('Oscar Isaac', '1979-03-09', 'M', 'Guatemala', 'Interpreta'),
  ('Anthony Daniels', '1946-02-21', 'M', 'Reino Unido', 'Interpreta'),
  ('Peter Mayhew', '1944-05-19', 'M', 'Reino Unido', 'Interpreta'),
  ('Kenny Baker', '1934-08-24', 'M', 'Reino Unido', 'Interpreta'),
  ('Billy Dee Williams', '1937-04-06', 'M', 'Estados Unidos', 'Interpreta'),
  ('Liam Neeson', '1952-06-07', 'M', 'Irlanda', 'Interpreta'),
  ('Ewan McGregor', '1971-03-31', 'M', 'Escocia', 'Interpreta'),
  ('Natalie Portman', '1981-06-09', 'F', 'Estados Unidos', 'Interpreta'),
  ('Hayden Christensen', '1981-04-19', 'M', 'Canadá', 'Interpreta'),
  ('Samuel L. Jackson', '1948-12-21', 'M', 'Estados Unidos', 'Interpreta'),
  ('Christopher Lee', '1922-05-27', 'M', 'Inglaterra', 'Interpreta'),
  ('Lupita Nyong''o', '1983-03-01', 'F', 'Kenia', 'Interpreta'),
  ('Benicio del Toro', '1967-02-19', 'M', 'Puerto Rico', 'Interpreta'),
  ('Alec Guinness', '1914-04-02', 'M', 'Inglaterra', 'Interpreta'),
  ('Frank Oz', '1944-05-25', 'M', 'Estados Unidos', 'Interpreta'),
  ('Lando Calrissian', '1948-12-21', 'M', 'Estados Unidos', 'Interpreta'),
  ('Donald Glover', '1983-09-25', 'M', 'Estados Unidos', 'Interpreta'),
  ('James Earl Jones', '1931-01-17', 'M', 'Estados Unidos', 'Interpreta'),
  ('Temuera Morrison', '1960-12-26', 'M', 'Nueva Zelanda', 'Interpreta'),
  ('Ray Park', '1974-08-23', 'M', 'Escocia', 'Interpreta'),
  ('Peter Cushing', '1913-05-26', 'M', 'Inglaterra', 'Interpreta'),
  ('Gwendoline Christie', '1978-10-28', 'F', 'Inglaterra', 'Interpreta'),
  ('Domhnall Gleeson', '1983-05-12', 'M', 'Irlanda', 'Interpreta'),
  ('Laura Dern', '1967-02-10', 'F', 'Estados Unidos', 'Interpreta'),
  ('Richard E. Grant', '1957-05-05', 'M', 'Inglaterra', 'Interpreta'),
  ('Billie Lourd', '1992-07-17', 'F', 'Estados Unidos', 'Interpreta'),
  ('Andy Serkis', '1964-04-20', 'M', 'Inglaterra', 'Interpreta'),
  ('Kelly Marie Tran', '1989-01-17', 'F', 'Estados Unidos', 'Interpreta'),
  ('Naomi Ackie', '1992-11-02', 'F', 'Inglaterra', 'Interpreta'),
  ('Ian McDiarmid', '1944-08-11', 'M', 'Escocia', 'Interpreta'),
  ('Carrie Fisher', '1956-10-21', 'F', 'Estados Unidos', 'Interpreta');
  

  INSERT INTO star_wars.nave (Nombre_nave, Fabricante, Longitud, Uso, Modelo) VALUES 
('Halcón Milenario', 'Corellian Engineering Corporation', 34.75, 'Transporte de carga, pasajeros y combate', 'YT-1300'),
('X-wing', 'Incom Corporation', 12.5, 'Combate espacial', 'T-65B'),
('TIE Fighter', 'Sistemas de Flota Sienar', 6.3, 'Combate espacial', 'TIE/LN'),
('Estrella de la Muerte', 'Imperio Galáctico', 160000, 'Base militar espacial', 'DS-1 Orbital Battle Station'),
('Destructor Estelar', 'Kuat Drive Yards', 1600, 'Nave de guerra', 'Imperial-class Star Destroyer'),
('Naboo Royal Starship', 'Theed Palace Space Vessel Engineering Corps', 76, 'Transporte diplomático', 'J-type 327 Nubian');
