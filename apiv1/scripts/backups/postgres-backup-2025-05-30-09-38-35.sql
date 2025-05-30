--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Debian 16.9-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    apellido character varying(255),
    cedula character varying(255),
    direccion character varying(255),
    edad integer,
    email character varying(255),
    nombre character varying(255),
    telefono character varying(255)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_seq OWNER TO postgres;

--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, apellido, cedula, direccion, edad, email, nombre, telefono) FROM stdin;
2	marulanda	5678901234	Carrera 7 # 72-41, Barranquilla	40	carlos.ruiz@example.com	javier	+573154321678
52	Gómez	9876543210	Avenida Siempre Viva 456, Medellín	25	maria.gomez@example.com	María	+573112345678
53	Pérez	1234567890	Calle Falsa 123, Bogotá	30	juan.perez@example.com	Juan	+573001234567
\.


--
-- Name: usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_seq', 1701, true);


--
-- Name: usuario uk5171l57faosmj8myawaucatdw; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uk5171l57faosmj8myawaucatdw UNIQUE (email);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

