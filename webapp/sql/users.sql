-- PostgreSQL database dump

-- Dropped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dropped by pg_dump version 14.2

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

-- Drop tables if they exist
DROP TABLE IF EXISTS public.user_images;
DROP TABLE IF EXISTS public.users;

-- Create tables
CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    password character varying(60),
    is_admin integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE TABLE public.user_images (
    id integer NOT NULL,
    user_id integer,
    file_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

-- Create sequences
ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.user_images ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

-- Insert data
INSERT INTO public.users (id, first_name, last_name, email, password, is_admin, created_at, updated_at)
OVERRIDING SYSTEM VALUE
VALUES
(1, 'Admin', 'User', 'admin@example.com', '$2a$14$ajq8Q7fbtFRQvXpdCq7Jcuy.Rx1h/L4J60Otx.gyNLbAYctGMJ9tK', 1, '2022-08-19 00:00:00', '2022-08-19 00:00:00');

-- Add constraints
ALTER TABLE ONLY public.user_images
    ADD CONSTRAINT user_images_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.user_images
    ADD CONSTRAINT user_images_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
