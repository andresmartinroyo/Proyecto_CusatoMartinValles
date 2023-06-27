PGDMP                         {         %   Proyecto_fase_2_CusatoMartinValles(2)    15.3    15.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16750 %   Proyecto_fase_2_CusatoMartinValles(2)    DATABASE     �   CREATE DATABASE "Proyecto_fase_2_CusatoMartinValles(2)" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 7   DROP DATABASE "Proyecto_fase_2_CusatoMartinValles(2)";
                postgres    false                        2615    17241 	   star_wars    SCHEMA        CREATE SCHEMA star_wars;
    DROP SCHEMA star_wars;
                postgres    false            `           1247    17243 	   dieta_dom    DOMAIN     v  CREATE DOMAIN star_wars.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Herbívoro'::character varying)::text, ('Carnívoro'::character varying)::text, ('Omnívoros'::character varying)::text, ('Carroñeros'::character varying)::text, ('Geófagos'::character varying)::text, ('Electrófago'::character varying)::text])));
 !   DROP DOMAIN star_wars.dieta_dom;
    	   star_wars          postgres    false    6            d           1247    17246 
   genero_dom    DOMAIN       CREATE DOMAIN star_wars.genero_dom AS character varying(10)
	CONSTRAINT genero_check CHECK (((VALUE)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text, ('Desc.'::character varying)::text, ('Otro'::character varying)::text])));
 "   DROP DOMAIN star_wars.genero_dom;
    	   star_wars          postgres    false    6            h           1247    17249 
   rating_dom    DOMAIN     t   CREATE DOMAIN star_wars.rating_dom AS integer
	CONSTRAINT rating_dom_check CHECK (((VALUE >= 1) AND (VALUE <= 5)));
 "   DROP DOMAIN star_wars.rating_dom;
    	   star_wars          postgres    false    6            l           1247    17252    tipo_actor_dom    DOMAIN     �   CREATE DOMAIN star_wars.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Interpreta'::character varying)::text, ('Presta su voz'::character varying)::text])));
 &   DROP DOMAIN star_wars.tipo_actor_dom;
    	   star_wars          postgres    false    6            �            1255    17413    verificar_ganancia()    FUNCTION     �   CREATE FUNCTION star_wars.verificar_ganancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Ganancia < 0 THEN
        RAISE NOTICE 'La película con ID % tuvo pérdidas', NEW.ID;
    END IF;
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION star_wars.verificar_ganancia();
    	   star_wars          postgres    false    6            �            1255    17480    verificar_nave()    FUNCTION     u  CREATE FUNCTION star_wars.verificar_nave() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Modelo = 'Destructoras Estelares' AND (NEW.Longitud < 900 OR NEW.Uso != 'Combate') THEN
        RAISE EXCEPTION 'Las naves de tipo "Destructoras Estelares" deben tener una longitud de al menos 900 metros y ser de uso "Combate"';
    END IF;
    RETURN NEW;
END;
$$;
 *   DROP FUNCTION star_wars.verificar_nave();
    	   star_wars          postgres    false    6            �            1259    17384    actor    TABLE       CREATE TABLE star_wars.actor (
    nombre_actor character varying(50) NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    nacionalidad character varying(50) NOT NULL,
    tipo_actor star_wars.tipo_actor_dom NOT NULL
);
    DROP TABLE star_wars.actor;
    	   star_wars         heap    postgres    false    868    6    876            �            1259    17254 
   afiliacion    TABLE     �   CREATE TABLE star_wars.afiliacion (
    nombre_af character varying(50) NOT NULL,
    tipo_af character varying(50) NOT NULL,
    nombre_planeta character varying(50)
);
 !   DROP TABLE star_wars.afiliacion;
    	   star_wars         heap    postgres    false    6            �            1259    17257    afiliado    TABLE     �   CREATE TABLE star_wars.afiliado (
    nombre_personaje character varying(50) NOT NULL,
    nombre_afiliacion character varying(50),
    fecha_afiliacion date
);
    DROP TABLE star_wars.afiliado;
    	   star_wars         heap    postgres    false    6            �            1259    17585    aparece    TABLE     �   CREATE TABLE star_wars.aparece (
    nombre_personaje character varying(50) NOT NULL,
    id_medio integer NOT NULL,
    fecha_estreno date
);
    DROP TABLE star_wars.aparece;
    	   star_wars         heap    postgres    false    6            �            1259    17260    ciudad    TABLE     �   CREATE TABLE star_wars.ciudad (
    nombre_ciudad character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);
    DROP TABLE star_wars.ciudad;
    	   star_wars         heap    postgres    false    6            �            1259    17509    combate    TABLE       CREATE TABLE star_wars.combate (
    participante1 character varying(50) NOT NULL,
    participante2 character varying(50) NOT NULL,
    id_medio integer NOT NULL,
    fecha_combate character varying(20) NOT NULL,
    lugar character varying(50) NOT NULL
);
    DROP TABLE star_wars.combate;
    	   star_wars         heap    postgres    false    6            �            1259    17263    criatura    TABLE     �   CREATE TABLE star_wars.criatura (
    nombre_especie character varying(50) NOT NULL,
    color_piel character varying(50) NOT NULL,
    dieta star_wars.dieta_dom NOT NULL
);
    DROP TABLE star_wars.criatura;
    	   star_wars         heap    postgres    false    864    6            �            1259    17619    dueno    TABLE     �   CREATE TABLE star_wars.dueno (
    nombre_personaje character varying(50) NOT NULL,
    id_nave integer NOT NULL,
    fecha_compra date NOT NULL
);
    DROP TABLE star_wars.dueno;
    	   star_wars         heap    postgres    false    6            �            1259    17268    especie    TABLE     �   CREATE TABLE star_wars.especie (
    nombre_especie character varying(30) NOT NULL,
    idioma character varying(20) NOT NULL
);
    DROP TABLE star_wars.especie;
    	   star_wars         heap    postgres    false    6            �            1259    17271    humano    TABLE     �   CREATE TABLE star_wars.humano (
    nombre_especie character varying(50) NOT NULL,
    fecha_nacimiento character varying(15) NOT NULL,
    fecha_muerte character varying(15)
);
    DROP TABLE star_wars.humano;
    	   star_wars         heap    postgres    false    6            �            1259    17274    idioma    TABLE     �   CREATE TABLE star_wars.idioma (
    nombre_idioma character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);
    DROP TABLE star_wars.idioma;
    	   star_wars         heap    postgres    false    6            �            1259    17533    interpretado    TABLE     �   CREATE TABLE star_wars.interpretado (
    nombre_personaje character varying(50) NOT NULL,
    nombre_actor character varying(50) NOT NULL,
    id_medio integer NOT NULL
);
 #   DROP TABLE star_wars.interpretado;
    	   star_wars         heap    postgres    false    6            �            1259    17277    lugares_interes    TABLE     �   CREATE TABLE star_wars.lugares_interes (
    nombre_lugar_de_interes character varying(50) NOT NULL,
    nombre_ciudad character varying(50),
    nombre_planeta character varying(50)
);
 &   DROP TABLE star_wars.lugares_interes;
    	   star_wars         heap    postgres    false    6            �            1259    17392    medio    TABLE     �   CREATE TABLE star_wars.medio (
    id_medio integer NOT NULL,
    titulo character varying(50) NOT NULL,
    fecha_estreno date NOT NULL,
    rating star_wars.rating_dom,
    sinopsis character varying(50) NOT NULL
);
    DROP TABLE star_wars.medio;
    	   star_wars         heap    postgres    false    872    6            �            1259    17391    medio_id_seq    SEQUENCE     �   CREATE SEQUENCE star_wars.medio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE star_wars.medio_id_seq;
    	   star_wars          postgres    false    6    228            �           0    0    medio_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE star_wars.medio_id_seq OWNED BY star_wars.medio.id_medio;
       	   star_wars          postgres    false    227            �            1259    17474    nave    TABLE       CREATE TABLE star_wars.nave (
    id_nave integer NOT NULL,
    nombre_nave character varying(50) NOT NULL,
    fabricante character varying(50) NOT NULL,
    longitud numeric(10,2) NOT NULL,
    uso character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL
);
    DROP TABLE star_wars.nave;
    	   star_wars         heap    postgres    false    6            �            1259    17473    nave_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE star_wars.nave_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE star_wars.nave_id_nave_seq;
    	   star_wars          postgres    false    234    6            �           0    0    nave_id_nave_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE star_wars.nave_id_nave_seq OWNED BY star_wars.nave.id_nave;
       	   star_wars          postgres    false    233            �            1259    17425    pelicula    TABLE     x  CREATE TABLE star_wars.pelicula (
    id_pelicula integer NOT NULL,
    director character varying(50),
    duracion integer,
    distribuidor character varying(50),
    coste_produccion numeric(10,2),
    tipo_pelicula character varying(50),
    ingreso_taquilla numeric(10,2),
    ganancia numeric(10,2) GENERATED ALWAYS AS ((ingreso_taquilla - coste_produccion)) STORED
);
    DROP TABLE star_wars.pelicula;
    	   star_wars         heap    postgres    false    6            �            1259    17280 	   personaje    TABLE     "  CREATE TABLE star_wars.personaje (
    nombre_personaje character varying(50) NOT NULL,
    genero star_wars.genero_dom NOT NULL,
    altura double precision,
    peso double precision,
    nombre_especie character varying(50) NOT NULL,
    nombre_planeta character varying(50) NOT NULL
);
     DROP TABLE star_wars.personaje;
    	   star_wars         heap    postgres    false    6    868            �            1259    17285    planeta    TABLE     �   CREATE TABLE star_wars.planeta (
    nombre_planeta character varying(50) NOT NULL,
    sistema_solar character varying(50) NOT NULL,
    sector character varying(50) NOT NULL,
    clima character varying(50) NOT NULL
);
    DROP TABLE star_wars.planeta;
    	   star_wars         heap    postgres    false    6            �            1259    17456    plataformas    TABLE     x   CREATE TABLE star_wars.plataformas (
    nombre_plataforma character varying(50) NOT NULL,
    id_videojuego integer
);
 "   DROP TABLE star_wars.plataformas;
    	   star_wars         heap    postgres    false    6            �            1259    17288    robot    TABLE     �   CREATE TABLE star_wars.robot (
    nombre_especie character varying(50) NOT NULL,
    creador character varying(50) NOT NULL,
    clase character varying(50) NOT NULL
);
    DROP TABLE star_wars.robot;
    	   star_wars         heap    postgres    false    6            �            1259    17436    serie    TABLE     �   CREATE TABLE star_wars.serie (
    id_serie integer NOT NULL,
    creador character varying(50) NOT NULL,
    total_episodios integer NOT NULL,
    canal character varying(50) NOT NULL,
    tipo_serie character varying(50) NOT NULL
);
    DROP TABLE star_wars.serie;
    	   star_wars         heap    postgres    false    6            �            1259    17604    tripula    TABLE     �   CREATE TABLE star_wars.tripula (
    nombre_personaje character varying(50) NOT NULL,
    id_nave integer NOT NULL,
    tipo_tripulacion character varying(50)
);
    DROP TABLE star_wars.tripula;
    	   star_wars         heap    postgres    false    6            �            1259    17446 
   videojuego    TABLE     �   CREATE TABLE star_wars.videojuego (
    id_videojuego integer NOT NULL,
    tipo_juego character varying(50) NOT NULL,
    compania character varying(50) NOT NULL
);
 !   DROP TABLE star_wars.videojuego;
    	   star_wars         heap    postgres    false    6            �           2604    17395    medio id_medio    DEFAULT     p   ALTER TABLE ONLY star_wars.medio ALTER COLUMN id_medio SET DEFAULT nextval('star_wars.medio_id_seq'::regclass);
 @   ALTER TABLE star_wars.medio ALTER COLUMN id_medio DROP DEFAULT;
    	   star_wars          postgres    false    227    228    228            �           2604    17477    nave id_nave    DEFAULT     r   ALTER TABLE ONLY star_wars.nave ALTER COLUMN id_nave SET DEFAULT nextval('star_wars.nave_id_nave_seq'::regclass);
 >   ALTER TABLE star_wars.nave ALTER COLUMN id_nave DROP DEFAULT;
    	   star_wars          postgres    false    234    233    234            �          0    17384    actor 
   TABLE DATA           d   COPY star_wars.actor (nombre_actor, fecha_nacimiento, genero, nacionalidad, tipo_actor) FROM stdin;
 	   star_wars          postgres    false    226   c�       �          0    17254 
   afiliacion 
   TABLE DATA           K   COPY star_wars.afiliacion (nombre_af, tipo_af, nombre_planeta) FROM stdin;
 	   star_wars          postgres    false    215   ��       �          0    17257    afiliado 
   TABLE DATA           \   COPY star_wars.afiliado (nombre_personaje, nombre_afiliacion, fecha_afiliacion) FROM stdin;
 	   star_wars          postgres    false    216   ��       �          0    17585    aparece 
   TABLE DATA           O   COPY star_wars.aparece (nombre_personaje, id_medio, fecha_estreno) FROM stdin;
 	   star_wars          postgres    false    237   ��       �          0    17260    ciudad 
   TABLE DATA           B   COPY star_wars.ciudad (nombre_ciudad, nombre_planeta) FROM stdin;
 	   star_wars          postgres    false    217   ׭       �          0    17509    combate 
   TABLE DATA           b   COPY star_wars.combate (participante1, participante2, id_medio, fecha_combate, lugar) FROM stdin;
 	   star_wars          postgres    false    235   P�       �          0    17263    criatura 
   TABLE DATA           H   COPY star_wars.criatura (nombre_especie, color_piel, dieta) FROM stdin;
 	   star_wars          postgres    false    218   m�       �          0    17619    dueno 
   TABLE DATA           K   COPY star_wars.dueno (nombre_personaje, id_nave, fecha_compra) FROM stdin;
 	   star_wars          postgres    false    239   ��       �          0    17268    especie 
   TABLE DATA           <   COPY star_wars.especie (nombre_especie, idioma) FROM stdin;
 	   star_wars          postgres    false    219   ��       �          0    17271    humano 
   TABLE DATA           S   COPY star_wars.humano (nombre_especie, fecha_nacimiento, fecha_muerte) FROM stdin;
 	   star_wars          postgres    false    220   }�       �          0    17274    idioma 
   TABLE DATA           B   COPY star_wars.idioma (nombre_idioma, nombre_planeta) FROM stdin;
 	   star_wars          postgres    false    221   ��       �          0    17533    interpretado 
   TABLE DATA           S   COPY star_wars.interpretado (nombre_personaje, nombre_actor, id_medio) FROM stdin;
 	   star_wars          postgres    false    236   ��       �          0    17277    lugares_interes 
   TABLE DATA           d   COPY star_wars.lugares_interes (nombre_lugar_de_interes, nombre_ciudad, nombre_planeta) FROM stdin;
 	   star_wars          postgres    false    222   Ա       �          0    17392    medio 
   TABLE DATA           U   COPY star_wars.medio (id_medio, titulo, fecha_estreno, rating, sinopsis) FROM stdin;
 	   star_wars          postgres    false    228   �       �          0    17474    nave 
   TABLE DATA           Z   COPY star_wars.nave (id_nave, nombre_nave, fabricante, longitud, uso, modelo) FROM stdin;
 	   star_wars          postgres    false    234   �       �          0    17425    pelicula 
   TABLE DATA           �   COPY star_wars.pelicula (id_pelicula, director, duracion, distribuidor, coste_produccion, tipo_pelicula, ingreso_taquilla) FROM stdin;
 	   star_wars          postgres    false    229   +�       �          0    17280 	   personaje 
   TABLE DATA           n   COPY star_wars.personaje (nombre_personaje, genero, altura, peso, nombre_especie, nombre_planeta) FROM stdin;
 	   star_wars          postgres    false    223   H�       �          0    17285    planeta 
   TABLE DATA           R   COPY star_wars.planeta (nombre_planeta, sistema_solar, sector, clima) FROM stdin;
 	   star_wars          postgres    false    224   ��       �          0    17456    plataformas 
   TABLE DATA           J   COPY star_wars.plataformas (nombre_plataforma, id_videojuego) FROM stdin;
 	   star_wars          postgres    false    232   ��       �          0    17288    robot 
   TABLE DATA           B   COPY star_wars.robot (nombre_especie, creador, clase) FROM stdin;
 	   star_wars          postgres    false    225   ��       �          0    17436    serie 
   TABLE DATA           Y   COPY star_wars.serie (id_serie, creador, total_episodios, canal, tipo_serie) FROM stdin;
 	   star_wars          postgres    false    230   շ       �          0    17604    tripula 
   TABLE DATA           Q   COPY star_wars.tripula (nombre_personaje, id_nave, tipo_tripulacion) FROM stdin;
 	   star_wars          postgres    false    238   �       �          0    17446 
   videojuego 
   TABLE DATA           L   COPY star_wars.videojuego (id_videojuego, tipo_juego, compania) FROM stdin;
 	   star_wars          postgres    false    231   �       �           0    0    medio_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('star_wars.medio_id_seq', 1, false);
       	   star_wars          postgres    false    227            �           0    0    nave_id_nave_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('star_wars.nave_id_nave_seq', 1, false);
       	   star_wars          postgres    false    233            �           2606    17390    actor actor_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY star_wars.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (nombre_actor);
 =   ALTER TABLE ONLY star_wars.actor DROP CONSTRAINT actor_pkey;
    	   star_wars            postgres    false    226            �           2606    17292    afiliacion afiliación_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_pkey" PRIMARY KEY (nombre_af);
 J   ALTER TABLE ONLY star_wars.afiliacion DROP CONSTRAINT "afiliación_pkey";
    	   star_wars            postgres    false    215            �           2606    17294 &   afiliado afiliado_fecha_afiliacion_key 
   CONSTRAINT     p   ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_fecha_afiliacion_key UNIQUE (fecha_afiliacion);
 S   ALTER TABLE ONLY star_wars.afiliado DROP CONSTRAINT afiliado_fecha_afiliacion_key;
    	   star_wars            postgres    false    216            �           2606    17296 '   afiliado afiliado_nombre_afiliacion_key 
   CONSTRAINT     r   ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_key UNIQUE (nombre_afiliacion);
 T   ALTER TABLE ONLY star_wars.afiliado DROP CONSTRAINT afiliado_nombre_afiliacion_key;
    	   star_wars            postgres    false    216            �           2606    17298    afiliado afiliado_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_pkey PRIMARY KEY (nombre_personaje);
 C   ALTER TABLE ONLY star_wars.afiliado DROP CONSTRAINT afiliado_pkey;
    	   star_wars            postgres    false    216                       2606    17593 !   aparece aparece_fecha_estreno_key 
   CONSTRAINT     h   ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_fecha_estreno_key UNIQUE (fecha_estreno);
 N   ALTER TABLE ONLY star_wars.aparece DROP CONSTRAINT aparece_fecha_estreno_key;
    	   star_wars            postgres    false    237                       2606    17591    aparece aparece_id_medio_key 
   CONSTRAINT     ^   ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_id_medio_key UNIQUE (id_medio);
 I   ALTER TABLE ONLY star_wars.aparece DROP CONSTRAINT aparece_id_medio_key;
    	   star_wars            postgres    false    237                       2606    17589    aparece aparece_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_pkey PRIMARY KEY (nombre_personaje);
 A   ALTER TABLE ONLY star_wars.aparece DROP CONSTRAINT aparece_pkey;
    	   star_wars            postgres    false    237            �           2606    17300     ciudad ciudad_nombre_planeta_key 
   CONSTRAINT     h   ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_key UNIQUE (nombre_planeta);
 M   ALTER TABLE ONLY star_wars.ciudad DROP CONSTRAINT ciudad_nombre_planeta_key;
    	   star_wars            postgres    false    217            �           2606    17302    ciudad ciudad_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (nombre_ciudad);
 ?   ALTER TABLE ONLY star_wars.ciudad DROP CONSTRAINT ciudad_pkey;
    	   star_wars            postgres    false    217            �           2606    17304 "   ciudad ciudad_unico_nombre_planeta 
   CONSTRAINT     y   ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_unico_nombre_planeta UNIQUE (nombre_ciudad, nombre_planeta);
 O   ALTER TABLE ONLY star_wars.ciudad DROP CONSTRAINT ciudad_unico_nombre_planeta;
    	   star_wars            postgres    false    217    217            	           2606    17517    combate combate_id_medio_key 
   CONSTRAINT     ^   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_id_medio_key UNIQUE (id_medio);
 I   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_id_medio_key;
    	   star_wars            postgres    false    235                       2606    17515 !   combate combate_participante2_key 
   CONSTRAINT     h   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante2_key UNIQUE (participante2);
 N   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_participante2_key;
    	   star_wars            postgres    false    235                       2606    17513    combate combate_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_pkey PRIMARY KEY (participante1);
 A   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_pkey;
    	   star_wars            postgres    false    235            �           2606    17306    criatura criatura_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY star_wars.criatura
    ADD CONSTRAINT criatura_pkey PRIMARY KEY (nombre_especie);
 C   ALTER TABLE ONLY star_wars.criatura DROP CONSTRAINT criatura_pkey;
    	   star_wars            postgres    false    218                       2606    17623    dueno dueno_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_pkey PRIMARY KEY (nombre_personaje, id_nave, fecha_compra);
 =   ALTER TABLE ONLY star_wars.dueno DROP CONSTRAINT dueno_pkey;
    	   star_wars            postgres    false    239    239    239            �           2606    17308    especie especie_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY star_wars.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (nombre_especie);
 A   ALTER TABLE ONLY star_wars.especie DROP CONSTRAINT especie_pkey;
    	   star_wars            postgres    false    219            �           2606    17310    humano humano_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY star_wars.humano
    ADD CONSTRAINT humano_pkey PRIMARY KEY (nombre_especie);
 ?   ALTER TABLE ONLY star_wars.humano DROP CONSTRAINT humano_pkey;
    	   star_wars            postgres    false    220            �           2606    17312     idioma idioma_nombre_planeta_key 
   CONSTRAINT     h   ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_key UNIQUE (nombre_planeta);
 M   ALTER TABLE ONLY star_wars.idioma DROP CONSTRAINT idioma_nombre_planeta_key;
    	   star_wars            postgres    false    221            �           2606    17314    idioma idioma_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (nombre_idioma);
 ?   ALTER TABLE ONLY star_wars.idioma DROP CONSTRAINT idioma_pkey;
    	   star_wars            postgres    false    221                       2606    17541 &   interpretado interpretado_id_medio_key 
   CONSTRAINT     h   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_id_medio_key UNIQUE (id_medio);
 S   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_id_medio_key;
    	   star_wars            postgres    false    236                       2606    17539 *   interpretado interpretado_nombre_actor_key 
   CONSTRAINT     p   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_actor_key UNIQUE (nombre_actor);
 W   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_nombre_actor_key;
    	   star_wars            postgres    false    236                       2606    17537    interpretado interpretado_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_pkey PRIMARY KEY (nombre_personaje);
 K   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_pkey;
    	   star_wars            postgres    false    236            �           2606    17316 1   lugares_interes lugares_interes_nombre_ciudad_key 
   CONSTRAINT     x   ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_key UNIQUE (nombre_ciudad);
 ^   ALTER TABLE ONLY star_wars.lugares_interes DROP CONSTRAINT lugares_interes_nombre_ciudad_key;
    	   star_wars            postgres    false    222            �           2606    17318 2   lugares_interes lugares_interes_nombre_planeta_key 
   CONSTRAINT     z   ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_planeta_key UNIQUE (nombre_planeta);
 _   ALTER TABLE ONLY star_wars.lugares_interes DROP CONSTRAINT lugares_interes_nombre_planeta_key;
    	   star_wars            postgres    false    222            �           2606    17320 $   lugares_interes lugares_interes_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_pkey PRIMARY KEY (nombre_lugar_de_interes);
 Q   ALTER TABLE ONLY star_wars.lugares_interes DROP CONSTRAINT lugares_interes_pkey;
    	   star_wars            postgres    false    222            �           2606    17397    medio medio_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY star_wars.medio
    ADD CONSTRAINT medio_pkey PRIMARY KEY (id_medio);
 =   ALTER TABLE ONLY star_wars.medio DROP CONSTRAINT medio_pkey;
    	   star_wars            postgres    false    228                       2606    17479    nave nave_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY star_wars.nave
    ADD CONSTRAINT nave_pkey PRIMARY KEY (id_nave);
 ;   ALTER TABLE ONLY star_wars.nave DROP CONSTRAINT nave_pkey;
    	   star_wars            postgres    false    234            �           2606    17322    ciudad nombre_planeta_unique 
   CONSTRAINT     d   ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT nombre_planeta_unique UNIQUE (nombre_planeta);
 I   ALTER TABLE ONLY star_wars.ciudad DROP CONSTRAINT nombre_planeta_unique;
    	   star_wars            postgres    false    217            �           2606    17430    pelicula pelicula_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);
 C   ALTER TABLE ONLY star_wars.pelicula DROP CONSTRAINT pelicula_pkey;
    	   star_wars            postgres    false    229            �           2606    17324    personaje personaje_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT personaje_pkey PRIMARY KEY (nombre_personaje);
 E   ALTER TABLE ONLY star_wars.personaje DROP CONSTRAINT personaje_pkey;
    	   star_wars            postgres    false    223            �           2606    17326    planeta planeta_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY star_wars.planeta
    ADD CONSTRAINT planeta_pkey PRIMARY KEY (nombre_planeta);
 A   ALTER TABLE ONLY star_wars.planeta DROP CONSTRAINT planeta_pkey;
    	   star_wars            postgres    false    224                       2606    17460 -   plataformas plataformas_nombre_plataforma_key 
   CONSTRAINT     x   ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_nombre_plataforma_key UNIQUE (nombre_plataforma);
 Z   ALTER TABLE ONLY star_wars.plataformas DROP CONSTRAINT plataformas_nombre_plataforma_key;
    	   star_wars            postgres    false    232            �           2606    17328    robot robot_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY star_wars.robot
    ADD CONSTRAINT robot_pkey PRIMARY KEY (nombre_especie);
 =   ALTER TABLE ONLY star_wars.robot DROP CONSTRAINT robot_pkey;
    	   star_wars            postgres    false    225                       2606    17440    serie serie_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (id_serie);
 =   ALTER TABLE ONLY star_wars.serie DROP CONSTRAINT serie_pkey;
    	   star_wars            postgres    false    230                       2606    17608    tripula tripula_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_pkey PRIMARY KEY (nombre_personaje, id_nave);
 A   ALTER TABLE ONLY star_wars.tripula DROP CONSTRAINT tripula_pkey;
    	   star_wars            postgres    false    238    238                       2606    17450    videojuego videojuego_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_pkey PRIMARY KEY (id_videojuego);
 G   ALTER TABLE ONLY star_wars.videojuego DROP CONSTRAINT videojuego_pkey;
    	   star_wars            postgres    false    231            9           2620    17481    nave nave_check_longitud_uso    TRIGGER     �   CREATE TRIGGER nave_check_longitud_uso BEFORE INSERT OR UPDATE ON star_wars.nave FOR EACH ROW EXECUTE FUNCTION star_wars.verificar_nave();
 8   DROP TRIGGER nave_check_longitud_uso ON star_wars.nave;
    	   star_wars          postgres    false    234    241                       2606    17329 *   afiliacion afiliación_nombre_planeta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.afiliacion
    ADD CONSTRAINT "afiliación_nombre_planeta_fkey" FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);
 Y   ALTER TABLE ONLY star_wars.afiliacion DROP CONSTRAINT "afiliación_nombre_planeta_fkey";
    	   star_wars          postgres    false    3319    215    224                       2606    17334 (   afiliado afiliado_nombre_afiliacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_afiliacion_fkey FOREIGN KEY (nombre_afiliacion) REFERENCES star_wars.afiliacion(nombre_af);
 U   ALTER TABLE ONLY star_wars.afiliado DROP CONSTRAINT afiliado_nombre_afiliacion_fkey;
    	   star_wars          postgres    false    3285    215    216                        2606    17339 '   afiliado afiliado_nombre_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.afiliado
    ADD CONSTRAINT afiliado_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);
 T   ALTER TABLE ONLY star_wars.afiliado DROP CONSTRAINT afiliado_nombre_personaje_fkey;
    	   star_wars          postgres    false    216    3317    223            3           2606    17599    aparece aparece_id_medio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);
 J   ALTER TABLE ONLY star_wars.aparece DROP CONSTRAINT aparece_id_medio_fkey;
    	   star_wars          postgres    false    228    3325    237            4           2606    17594 %   aparece aparece_nombre_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.aparece
    ADD CONSTRAINT aparece_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);
 R   ALTER TABLE ONLY star_wars.aparece DROP CONSTRAINT aparece_nombre_personaje_fkey;
    	   star_wars          postgres    false    3317    223    237            !           2606    17344 !   ciudad ciudad_nombre_planeta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.ciudad
    ADD CONSTRAINT ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);
 N   ALTER TABLE ONLY star_wars.ciudad DROP CONSTRAINT ciudad_nombre_planeta_fkey;
    	   star_wars          postgres    false    224    3319    217            -           2606    17528    combate combate_id_medio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);
 J   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_id_medio_fkey;
    	   star_wars          postgres    false    228    235    3325            .           2606    17518 "   combate combate_participante1_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante1_fkey FOREIGN KEY (participante1) REFERENCES star_wars.personaje(nombre_personaje);
 O   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_participante1_fkey;
    	   star_wars          postgres    false    235    3317    223            /           2606    17523 "   combate combate_participante2_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.combate
    ADD CONSTRAINT combate_participante2_fkey FOREIGN KEY (participante2) REFERENCES star_wars.personaje(nombre_personaje);
 O   ALTER TABLE ONLY star_wars.combate DROP CONSTRAINT combate_participante2_fkey;
    	   star_wars          postgres    false    235    223    3317            "           2606    17349 %   criatura criatura_nombre_especie_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.criatura
    ADD CONSTRAINT criatura_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);
 R   ALTER TABLE ONLY star_wars.criatura DROP CONSTRAINT criatura_nombre_especie_fkey;
    	   star_wars          postgres    false    3303    218    219            7           2606    17629    dueno dueno_id_nave_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_id_nave_fkey FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);
 E   ALTER TABLE ONLY star_wars.dueno DROP CONSTRAINT dueno_id_nave_fkey;
    	   star_wars          postgres    false    239    3335    234            8           2606    17624 !   dueno dueno_nombre_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.dueno
    ADD CONSTRAINT dueno_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);
 N   ALTER TABLE ONLY star_wars.dueno DROP CONSTRAINT dueno_nombre_personaje_fkey;
    	   star_wars          postgres    false    223    3317    239            &           2606    17354    personaje fk_nombre_especie    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_especie FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);
 H   ALTER TABLE ONLY star_wars.personaje DROP CONSTRAINT fk_nombre_especie;
    	   star_wars          postgres    false    3303    219    223            '           2606    17359    personaje fk_nombre_planeta    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.personaje
    ADD CONSTRAINT fk_nombre_planeta FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);
 H   ALTER TABLE ONLY star_wars.personaje DROP CONSTRAINT fk_nombre_planeta;
    	   star_wars          postgres    false    223    224    3319            #           2606    17364 !   humano humano_nombre_especie_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.humano
    ADD CONSTRAINT humano_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);
 N   ALTER TABLE ONLY star_wars.humano DROP CONSTRAINT humano_nombre_especie_fkey;
    	   star_wars          postgres    false    3303    220    219            $           2606    17369 !   idioma idioma_nombre_planeta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.idioma
    ADD CONSTRAINT idioma_nombre_planeta_fkey FOREIGN KEY (nombre_planeta) REFERENCES star_wars.planeta(nombre_planeta);
 N   ALTER TABLE ONLY star_wars.idioma DROP CONSTRAINT idioma_nombre_planeta_fkey;
    	   star_wars          postgres    false    3319    221    224            0           2606    17552 '   interpretado interpretado_id_medio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_id_medio_fkey FOREIGN KEY (id_medio) REFERENCES star_wars.medio(id_medio);
 T   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_id_medio_fkey;
    	   star_wars          postgres    false    236    228    3325            1           2606    17547 +   interpretado interpretado_nombre_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_actor_fkey FOREIGN KEY (nombre_actor) REFERENCES star_wars.actor(nombre_actor);
 X   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_nombre_actor_fkey;
    	   star_wars          postgres    false    236    3323    226            2           2606    17542 /   interpretado interpretado_nombre_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.interpretado
    ADD CONSTRAINT interpretado_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);
 \   ALTER TABLE ONLY star_wars.interpretado DROP CONSTRAINT interpretado_nombre_personaje_fkey;
    	   star_wars          postgres    false    223    236    3317            %           2606    17374 A   lugares_interes lugares_interes_nombre_ciudad_nombre_planeta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.lugares_interes
    ADD CONSTRAINT lugares_interes_nombre_ciudad_nombre_planeta_fkey FOREIGN KEY (nombre_ciudad, nombre_planeta) REFERENCES star_wars.ciudad(nombre_ciudad, nombre_planeta) ON DELETE CASCADE;
 n   ALTER TABLE ONLY star_wars.lugares_interes DROP CONSTRAINT lugares_interes_nombre_ciudad_nombre_planeta_fkey;
    	   star_wars          postgres    false    222    217    217    3297    222            )           2606    17431 "   pelicula pelicula_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.pelicula
    ADD CONSTRAINT pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES star_wars.medio(id_medio);
 O   ALTER TABLE ONLY star_wars.pelicula DROP CONSTRAINT pelicula_id_pelicula_fkey;
    	   star_wars          postgres    false    228    229    3325            ,           2606    17461 *   plataformas plataformas_id_videojuego_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.plataformas
    ADD CONSTRAINT plataformas_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.videojuego(id_videojuego);
 W   ALTER TABLE ONLY star_wars.plataformas DROP CONSTRAINT plataformas_id_videojuego_fkey;
    	   star_wars          postgres    false    3331    231    232            (           2606    17379    robot robot_nombre_especie_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.robot
    ADD CONSTRAINT robot_nombre_especie_fkey FOREIGN KEY (nombre_especie) REFERENCES star_wars.especie(nombre_especie);
 L   ALTER TABLE ONLY star_wars.robot DROP CONSTRAINT robot_nombre_especie_fkey;
    	   star_wars          postgres    false    219    225    3303            *           2606    17441    serie serie_id_serie_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.serie
    ADD CONSTRAINT serie_id_serie_fkey FOREIGN KEY (id_serie) REFERENCES star_wars.medio(id_medio);
 F   ALTER TABLE ONLY star_wars.serie DROP CONSTRAINT serie_id_serie_fkey;
    	   star_wars          postgres    false    3325    228    230            5           2606    17614    tripula tripula_id_nave_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_id_nave_fkey FOREIGN KEY (id_nave) REFERENCES star_wars.nave(id_nave);
 I   ALTER TABLE ONLY star_wars.tripula DROP CONSTRAINT tripula_id_nave_fkey;
    	   star_wars          postgres    false    3335    238    234            6           2606    17609 %   tripula tripula_nombre_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.tripula
    ADD CONSTRAINT tripula_nombre_personaje_fkey FOREIGN KEY (nombre_personaje) REFERENCES star_wars.personaje(nombre_personaje);
 R   ALTER TABLE ONLY star_wars.tripula DROP CONSTRAINT tripula_nombre_personaje_fkey;
    	   star_wars          postgres    false    223    3317    238            +           2606    17451 (   videojuego videojuego_id_videojuego_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY star_wars.videojuego
    ADD CONSTRAINT videojuego_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES star_wars.medio(id_medio);
 U   ALTER TABLE ONLY star_wars.videojuego DROP CONSTRAINT videojuego_id_videojuego_fkey;
    	   star_wars          postgres    false    228    3325    231            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   i  x�MQ�n�0<s���=�,ըũQ
�2����Wࣩ��U,��ifvI`fv��n%y�L��*���XR��͝Ѷsj+$6;͎�(�m���x��m�5R�{�*5�D��Ar�4]�+k�$ɼ����g��g����֒'Sq%P+�vXF	J��2Έ����h�l��'8�"=���K5e���?$[#e�s����� �ex�����d����\<$Le8�c�~�A�={��+Gs��Lܻ���R!���h�:���{���ʣ���(��?*�Rh��/��t@��H��� kc7N?xn;#t��q�2gk��DGd��泭$�����,�@���lϷ��M�~}"���w      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x�u�Mn�@���)�ˮwh,�Nh�6h�-M"B��3?0��d�s�b�H��.���HH�ͬSON�����bE��VGE|��ط�g>i��n���:\�!>J�4��ŧH0)c��5ZrP��V\� K=y��D���$�p�p��M!�sf�G�A��Ur/�x�b�7��x�7d�	-̊���<����M.�#~K��`Vܲ'�:��Rݩ��)~JCP�P����E�!��5ɵ��5�e���Uc�Γ�D���������&�{���I���I�p%�Q�bs-gʓ3��+��p?_�<2��5��U
����c�`��5�>��0+��N�f�_Ȫ�fŒ�񞧝o�����!�\T|����@>�q���a|3����;߼�D>x�~~&}'*	��Z�0�ރ�'� nSr�n,E����$���#;�
����� %`B�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   e  x�eSYn�0���p�Œ��x�j;n�Hџ�ED)Ҡ���z�^�#ER� s���{��j%�N�O��p�?	 I�.�Xx��Zi[	��ɽ�A�?�`<�A�:Ѱ�*篘�L���Twh��j��x@�1�Nh-�]T�|�5��d|��Ŭ���_2C�*�#G=n����[-G���iLC5a2�T�.h*�,�A�A<<�R5�Z�Xgͅ�7�IR�_�s0Z���
|o
!=����T�G�����	$Q���sqJ�p��{�|?���J
�X���Y����9j'�Rb����v��uY�LS�U.�]]U]�*��6����%���X�.�d�s=b!����Z�����S�
X嶐�-�#5��-�#Vd��5>�L�k'3i�ń�5yDm]g�$Q�OA;<�ix��F�,~��~����Ϝ�޻�W��Q�����G�����yry7-'5���I�Z���nkC�ѩ�vL��X�Gq��g���:���<(Q��ߣs� Bx�<YK���'�ʃ0�62,�̖�j�x0Ëk���I��m�0|S���ŭ�nK>/̫,�$��uwE��u�-)L�#d��wty�?�c� �:K�      �   �  x��U�n�0>�O���!h�4i�x��Xj�FI.��e�w�5/6*�`]�O�(����z"e$���(�_V	�fdW���?T�����-�Wp1C�����C�����5	!��)��e��y��UT�ary�[K\��N��z�>y�hx���Q���I�'�̥;�[�J�~�2��#\ ,�KE��+�H�I��T�#OF�@'C�+��!���t���q������[>��#���ۄ��L{���;����C�(���C��)�e���y�!Q���+��*O����:���ś����׼$g����ZB����1��!��,9&��~Ѯњ�������"v%Z��k�����oRT��K���ՙEŭ8�L(�M���Rp#G?R������)���֎��X��g�O��%��{����t��|��+��jэ�uOn��d�49��,+��O��Ώ�ݗ2�:�BZ.>��M֨���t �*��TZ�����Gn*l%��E!� 50���qd��3�����jR"�q8�ϚX�-���I]�n$.���@���%�A�/��(�^���yW�z�S���2�ki���������w�Gl �t޶�ָ��<z ��b�V���=���;�ssNj�.��9z�Y���A"��!��z�J��<�i�n)�zk���<_+� �n��"
���v��"[o���P�c�?�fY�	rL�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     