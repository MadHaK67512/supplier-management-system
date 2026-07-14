--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.supplierstock DROP CONSTRAINT supplierstock_sid_fkey;
ALTER TABLE ONLY public.supplierstock DROP CONSTRAINT supplierstock_bname_bcity_item_fkey;
ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_user_id_fkey;
ALTER TABLE ONLY public.purchasing DROP CONSTRAINT purchasing_cid_fkey;
ALTER TABLE ONLY public.purchasing DROP CONSTRAINT purchasing_bname_bcity_item_fkey;
ALTER TABLE ONLY public.manager DROP CONSTRAINT manager_sid_fkey;
ALTER TABLE ONLY public.linkedbrand DROP CONSTRAINT linkedbrand_sid_fkey;
ALTER TABLE ONLY public.linkedbrand DROP CONSTRAINT linkedbrand_bname_bcity_fkey;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_sid_fkey;
ALTER TABLE ONLY public.brandstock DROP CONSTRAINT brandstock_bname_bcity_fkey;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX public.django_session_session_key_c0390e0f_like;
DROP INDEX public.django_session_expire_date_a5c62663;
DROP INDEX public.django_admin_log_user_id_c564eba6;
DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX public.auth_user_username_6821ab7c_like;
DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX public.auth_user_groups_group_id_97559544;
DROP INDEX public.auth_permission_content_type_id_2f476e4b;
DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX public.auth_group_name_a6ea08ec_like;
ALTER TABLE ONLY public.supplierstock DROP CONSTRAINT supplierstock_pkey;
ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_user_id_key;
ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_pkey;
ALTER TABLE ONLY public.purchasing DROP CONSTRAINT purchasing_pkey;
ALTER TABLE ONLY public.manager DROP CONSTRAINT manager_pkey;
ALTER TABLE ONLY public.linkedbrand DROP CONSTRAINT linkedbrand_pkey;
ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
ALTER TABLE ONLY public.brandstock DROP CONSTRAINT brandstock_pkey;
ALTER TABLE ONLY public.brand DROP CONSTRAINT brand_pkey;
ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
ALTER TABLE ONLY public.app_users DROP CONSTRAINT app_users_username_key;
ALTER TABLE ONLY public.app_users DROP CONSTRAINT app_users_pkey;
ALTER TABLE ONLY public.app_users DROP CONSTRAINT app_users_email_key;
ALTER TABLE public.supplier ALTER COLUMN sid DROP DEFAULT;
ALTER TABLE public.manager ALTER COLUMN mid DROP DEFAULT;
ALTER TABLE public.customer ALTER COLUMN cid DROP DEFAULT;
ALTER TABLE public.app_users ALTER COLUMN id DROP DEFAULT;
DROP VIEW public.supplier_stock_info;
DROP TABLE public.supplierstock;
DROP SEQUENCE public.supplier_sid_seq;
DROP TABLE public.supplier;
DROP VIEW public.purchasingview;
DROP TABLE public.purchasing;
DROP SEQUENCE public.manager_mid_seq;
DROP TABLE public.manager;
DROP VIEW public.linkedbrandview;
DROP TABLE public.linkedbrand;
DROP TABLE public.django_session;
DROP TABLE public.django_migrations;
DROP TABLE public.django_content_type;
DROP TABLE public.django_admin_log;
DROP VIEW public.customerview;
DROP SEQUENCE public.customer_cid_seq;
DROP TABLE public.customer;
DROP VIEW public.brandstockview;
DROP TABLE public.brandstock;
DROP VIEW public.branddetail;
DROP TABLE public.brand;
DROP TABLE public.auth_user_user_permissions;
DROP TABLE public.auth_user_groups;
DROP TABLE public.auth_user;
DROP TABLE public.auth_permission;
DROP TABLE public.auth_group_permissions;
DROP TABLE public.auth_group;
DROP SEQUENCE public.app_users_id_seq;
DROP TABLE public.app_users;
DROP FUNCTION public.updatepurchasingstatustocompleted(p_cid integer);
DROP FUNCTION public.getsupplierstockinfo(p_sid integer);
DROP FUNCTION public.getsupplierstockbybrandname(p_brandname character varying);
DROP FUNCTION public.getdistinctcitiesbybrandname(p_brandname character varying);
DROP FUNCTION public.getcustomernamesbysupplierid(p_sid integer);
DROP FUNCTION public.getbrandstockbyitemname(p_itemname character varying);
DROP FUNCTION public.deletesupplierstock(p_sid integer, p_bname character varying, p_bcity character varying, p_item character varying);
DROP FUNCTION public.deletepurchasingbycid(p_cid integer);
--
-- Name: deletepurchasingbycid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.deletepurchasingbycid(p_cid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM Purchasing 
    WHERE cID = p_cID;
END;
$$;


--
-- Name: deletesupplierstock(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.deletesupplierstock(p_sid integer, p_bname character varying, p_bcity character varying, p_item character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM SupplierStock 
    WHERE sID = p_sID 
    AND bName = p_bName 
    AND bCity = p_bCity 
    AND iTem = p_iTem;
END;
$$;


--
-- Name: getbrandstockbyitemname(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.getbrandstockbyitemname(p_itemname character varying) RETURNS TABLE(bname character varying, bcity character varying, item character varying, category character varying, price numeric, quantity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM BrandStock
    WHERE iTem LIKE '%' || p_itemName || '%';
END;
$$;


--
-- Name: getcustomernamesbysupplierid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.getcustomernamesbysupplierid(p_sid integer) RETURNS TABLE(cname character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT cName
    FROM customerView
    WHERE sID = p_sID;
END;
$$;


--
-- Name: getdistinctcitiesbybrandname(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.getdistinctcitiesbybrandname(p_brandname character varying) RETURNS TABLE(bcity character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT bCity
    FROM SupplierStock
    WHERE bName LIKE '%' || p_brandName || '%';
END;
$$;


--
-- Name: getsupplierstockbybrandname(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.getsupplierstockbybrandname(p_brandname character varying) RETURNS TABLE(sid integer, bname character varying, bcity character varying, item character varying, quantity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM SupplierStock
    WHERE bName LIKE '%' || p_brandName || '%';
END;
$$;


--
-- Name: getsupplierstockinfo(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.getsupplierstockinfo(p_sid integer) RETURNS TABLE(sid integer, sname character varying, semail character varying, stel character varying, bname character varying, bcity character varying, item character varying, quantity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT s.sID, s.sName, s.sEmail, s.sTel, ss.bName, ss.bCity, ss.iTem, ss.Quantity
    FROM Supplier s
    INNER JOIN SupplierStock ss ON s.sID = ss.sID
    WHERE s.sID = p_sID;
END;
$$;


--
-- Name: updatepurchasingstatustocompleted(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.updatepurchasingstatustocompleted(p_cid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Purchasing 
    SET pStatus = 'completed'
    WHERE cID = p_cID;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: app_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.app_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: app_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.app_users_id_seq OWNED BY public.app_users.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: brand; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brand (
    bname character varying(100) NOT NULL,
    bcity character varying(100) NOT NULL,
    country character varying(100)
);


--
-- Name: branddetail; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.branddetail AS
 SELECT bname,
    bcity,
    country
   FROM public.brand;


--
-- Name: brandstock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brandstock (
    bname character varying(100) NOT NULL,
    bcity character varying(100) NOT NULL,
    item character varying(100) NOT NULL,
    category character varying(100),
    price numeric(10,2),
    quantity integer
);


--
-- Name: brandstockview; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.brandstockview AS
 SELECT bname,
    bcity,
    item,
    category,
    price,
    quantity
   FROM public.brandstock;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    cid integer NOT NULL,
    cname character varying(100),
    cemail character varying(100),
    caddress character varying(255),
    sid integer
);


--
-- Name: customer_cid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_cid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_cid_seq OWNED BY public.customer.cid;


--
-- Name: customerview; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.customerview AS
 SELECT cid,
    cname,
    cemail,
    caddress,
    sid
   FROM public.customer;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: linkedbrand; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.linkedbrand (
    sid integer NOT NULL,
    bname character varying(100) NOT NULL,
    bcity character varying(100) NOT NULL
);


--
-- Name: linkedbrandview; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.linkedbrandview AS
 SELECT sid,
    bname,
    bcity
   FROM public.linkedbrand;


--
-- Name: manager; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manager (
    mid integer NOT NULL,
    mname character varying(100),
    memail character varying(100),
    mtel character varying(20),
    sid integer
);


--
-- Name: manager_mid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manager_mid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manager_mid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manager_mid_seq OWNED BY public.manager.mid;


--
-- Name: purchasing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchasing (
    cid integer NOT NULL,
    bname character varying(100) NOT NULL,
    bcity character varying(100) NOT NULL,
    item character varying(100) NOT NULL,
    quantity integer,
    pstatus character varying(20) DEFAULT 'pending'::character varying
);


--
-- Name: purchasingview; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.purchasingview AS
 SELECT c.cname,
    p.bname,
    p.bcity,
    p.item,
    b.category,
    b.price,
    p.quantity,
    p.pstatus,
    p.cid
   FROM ((public.purchasing p
     JOIN public.customer c ON ((p.cid = c.cid)))
     LEFT JOIN public.brandstock b ON ((((p.bname)::text = (b.bname)::text) AND ((p.bcity)::text = (b.bcity)::text) AND ((p.item)::text = (b.item)::text))));


--
-- Name: supplier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.supplier (
    sid integer NOT NULL,
    sname character varying(100),
    semail character varying(100),
    stel character varying(20),
    ssalary numeric(10,2),
    user_id integer
);


--
-- Name: supplier_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.supplier_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: supplier_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.supplier_sid_seq OWNED BY public.supplier.sid;


--
-- Name: supplierstock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.supplierstock (
    sid integer NOT NULL,
    bname character varying(100) NOT NULL,
    bcity character varying(100) NOT NULL,
    item character varying(100) NOT NULL,
    quantity integer
);


--
-- Name: supplier_stock_info; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.supplier_stock_info AS
 SELECT s.sid,
    s.bname,
    s.bcity,
    s.item,
    b.category,
    b.price,
    s.quantity
   FROM (public.supplierstock s
     LEFT JOIN public.brandstock b ON ((((s.bname)::text = (b.bname)::text) AND ((s.bcity)::text = (b.bcity)::text) AND ((s.item)::text = (b.item)::text))));


--
-- Name: app_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users ALTER COLUMN id SET DEFAULT nextval('public.app_users_id_seq'::regclass);


--
-- Name: customer cid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer ALTER COLUMN cid SET DEFAULT nextval('public.customer_cid_seq'::regclass);


--
-- Name: manager mid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager ALTER COLUMN mid SET DEFAULT nextval('public.manager_mid_seq'::regclass);


--
-- Name: supplier sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier ALTER COLUMN sid SET DEFAULT nextval('public.supplier_sid_seq'::regclass);


--
-- Data for Name: app_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.app_users (id, username, email, password, created_at) FROM stdin;
1	Muhammad Hassan Khan	hassankhan67512@gmail.com	71a5d36edce5da1ae9a89e310c87de20781f76946340cd59fa60d065231c4193	2026-07-14 11:19:55.287188
2	user2	uesr2@gmail.com	6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3	2026-07-14 12:21:23.122324
3	user1	user1@gmail.com	71a5d36edce5da1ae9a89e310c87de20781f76946340cd59fa60d065231c4193	2026-07-14 12:22:42.769859
4	user3	user@gmail.com	71a5d36edce5da1ae9a89e310c87de20781f76946340cd59fa60d065231c4193	2026-07-14 12:44:28.380724
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	3	add_permission
6	Can change permission	3	change_permission
7	Can delete permission	3	delete_permission
8	Can view permission	3	view_permission
9	Can add group	2	add_group
10	Can change group	2	change_group
11	Can delete group	2	delete_group
12	Can view group	2	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.brand (bname, bcity, country) FROM stdin;
Nestle	Lahore	Pakistan
Unilever	Karachi	Pakistan
Engro	Islamabad	Pakistan
Shan Foods	Karachi	Pakistan
National Foods	Karachi	Pakistan
Sufi	Lahore	Pakistan
Mitchell's	Sahiwal	Pakistan
Gourmet	Lahore	Pakistan
Shezan	Lahore	Pakistan
K&N's	Karachi	Pakistan
Olper's	Karachi	Pakistan
Dawn Bread	Karachi	Pakistan
Nurpur	Sargodha	Pakistan
Dalda	Karachi	Pakistan
Bulls Eye	Faisalabad	Pakistan
\.


--
-- Data for Name: brandstock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.brandstock (bname, bcity, item, category, price, quantity) FROM stdin;
Nestle	Lahore	Milk	Dairy	250.00	1000
Nestle	Lahore	Yogurt	Dairy	180.00	500
Unilever	Karachi	Soap	Hygiene	150.00	2000
Unilever	Karachi	Shampoo	Hygiene	450.00	800
Shan Foods	Karachi	Biryani Masala	Spices	120.00	1500
National Foods	Karachi	Salt	Spices	60.00	3000
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer (cid, cname, cemail, caddress, sid) FROM stdin;
4	Raza Grocers	raza_grocers@example.com	789 High St, Islamabad	3
5	Ahmed Fresh Foods	ahmed_fresh@example.com	321 Garden Rd, Faisalabad	4
6	Hussain Super Mart	hussain_super@example.com	987 Park Ave, Rawalpindi	5
7	Mega Bazaar	mega_bazaar@example.com	654 Center St, Multan	6
8	Family Mart	familymart@example.com	159 Oak St, Peshawar	7
9	Super Savers	supersavers@example.com	852 Elm St, Quetta	8
10	City Supermarket	city_super@example.com	741 Broadway St, Lahore	9
11	Food Express	foodexpress@example.com	369 Maple St, Karachi	10
12	Freshland	freshland@example.com	258 Pine St, Islamabad	11
13	Prime Pantry	primepantry@example.com	963 Cherry St, Lahore	12
14	Gourmet Grocery	gourmetgrocery@example.com	147 Walnut St, Karachi	13
15	Corner Convenience	cornerconvenience@example.com	753 Cedar St, Lahore	14
3	Ali Hamza	alimart@example.com	456 Market St, Lahore	2
17	Hassan	hassan@gmail.com	---address---	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-06-24 18:58:39.762448+05
2	auth	0001_initial	2026-06-24 18:58:39.891599+05
3	admin	0001_initial	2026-06-24 18:58:39.924709+05
4	admin	0002_logentry_remove_auto_add	2026-06-24 18:58:39.937484+05
5	admin	0003_logentry_add_action_flag_choices	2026-06-24 18:58:39.952318+05
6	contenttypes	0002_remove_content_type_name	2026-06-24 18:58:39.983051+05
7	auth	0002_alter_permission_name_max_length	2026-06-24 18:58:39.993196+05
8	auth	0003_alter_user_email_max_length	2026-06-24 18:58:40.011899+05
9	auth	0004_alter_user_username_opts	2026-06-24 18:58:40.023546+05
10	auth	0005_alter_user_last_login_null	2026-06-24 18:58:40.033646+05
11	auth	0006_require_contenttypes_0002	2026-06-24 18:58:40.033646+05
12	auth	0007_alter_validators_add_error_messages	2026-06-24 18:58:40.048797+05
13	auth	0008_alter_user_username_max_length	2026-06-24 18:58:40.065986+05
14	auth	0009_alter_user_last_name_max_length	2026-06-24 18:58:40.082057+05
15	auth	0010_alter_group_name_max_length	2026-06-24 18:58:40.094549+05
16	auth	0011_update_proxy_permissions	2026-06-24 18:58:40.104889+05
17	auth	0012_alter_user_first_name_max_length	2026-06-24 18:58:40.114721+05
18	sessions	0001_initial	2026-06-24 18:58:40.125122+05
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: linkedbrand; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.linkedbrand (sid, bname, bcity) FROM stdin;
1	Nestle	Lahore
1	Unilever	Karachi
1	Engro	Islamabad
1	Shan Foods	Karachi
\.


--
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manager (mid, mname, memail, mtel, sid) FROM stdin;
\.


--
-- Data for Name: purchasing; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.purchasing (cid, bname, bcity, item, quantity, pstatus) FROM stdin;
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.supplier (sid, sname, semail, stel, ssalary, user_id) FROM stdin;
4	Fresh Foods	info@freshfoods.com	+1 404-676-2121	115000.00	\N
5	HealthCare Supplies	info@healthcare.com	+1 914-253-3055	105000.00	\N
6	Agro Supplies	info@agro.com	+1 732-524-0400	125000.00	\N
7	Quality Goods	info@qualitygoods.com	+1 800-627-7852	130000.00	\N
8	Household Supplies	info@household.com	+1 412-456-5700	115000.00	\N
9	Food Distributors	info@fooddist.com	+1 847-943-4000	110000.00	\N
10	Daily Needs	info@dailyneeds.com	+1 269-961-2800	100000.00	\N
11	Grocery World	info@groceryworld.com	+33 (0)1 44 35 20 20	120000.00	\N
12	Organic Foods	info@organicfoods.com	+1 800-245-0577	105000.00	\N
13	Water Supplies	info@watersupplies.com	+41 21 924 1111	115000.00	\N
14	Sweet Treats	info@sweettreats.com	+1 732-764-9300	110000.00	\N
15	Packaging World	info@packaging.com	+27 11 994 5414	105000.00	\N
1	Prime Supplies	info@prime.com	+41 21 924 1111	100000.00	1
2	Universal Distributors	info@universal.com	+44 (0) 20 7822 5252	120000.00	2
3	Global Traders	info@globaltraders.com	+1 513-983-1100	110000.00	3
16	user3's Supplies	user@gmail.com		100000.00	4
\.


--
-- Data for Name: supplierstock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.supplierstock (sid, bname, bcity, item, quantity) FROM stdin;
\.


--
-- Name: app_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.app_users_id_seq', 4, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 24, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, false);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: customer_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_cid_seq', 17, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 6, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 18, true);


--
-- Name: manager_mid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.manager_mid_seq', 1, false);


--
-- Name: supplier_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.supplier_sid_seq', 16, true);


--
-- Name: app_users app_users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_email_key UNIQUE (email);


--
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (id);


--
-- Name: app_users app_users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (bname, bcity);


--
-- Name: brandstock brandstock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brandstock
    ADD CONSTRAINT brandstock_pkey PRIMARY KEY (bname, bcity, item);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (cid);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: linkedbrand linkedbrand_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkedbrand
    ADD CONSTRAINT linkedbrand_pkey PRIMARY KEY (sid, bname, bcity);


--
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (mid);


--
-- Name: purchasing purchasing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchasing
    ADD CONSTRAINT purchasing_pkey PRIMARY KEY (cid, bname, bcity, item);


--
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (sid);


--
-- Name: supplier supplier_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_user_id_key UNIQUE (user_id);


--
-- Name: supplierstock supplierstock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplierstock
    ADD CONSTRAINT supplierstock_pkey PRIMARY KEY (sid, bname, bcity, item);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: brandstock brandstock_bname_bcity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brandstock
    ADD CONSTRAINT brandstock_bname_bcity_fkey FOREIGN KEY (bname, bcity) REFERENCES public.brand(bname, bcity);


--
-- Name: customer customer_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_sid_fkey FOREIGN KEY (sid) REFERENCES public.supplier(sid);


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: linkedbrand linkedbrand_bname_bcity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkedbrand
    ADD CONSTRAINT linkedbrand_bname_bcity_fkey FOREIGN KEY (bname, bcity) REFERENCES public.brand(bname, bcity);


--
-- Name: linkedbrand linkedbrand_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkedbrand
    ADD CONSTRAINT linkedbrand_sid_fkey FOREIGN KEY (sid) REFERENCES public.supplier(sid);


--
-- Name: manager manager_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_sid_fkey FOREIGN KEY (sid) REFERENCES public.supplier(sid);


--
-- Name: purchasing purchasing_bname_bcity_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchasing
    ADD CONSTRAINT purchasing_bname_bcity_item_fkey FOREIGN KEY (bname, bcity, item) REFERENCES public.brandstock(bname, bcity, item);


--
-- Name: purchasing purchasing_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchasing
    ADD CONSTRAINT purchasing_cid_fkey FOREIGN KEY (cid) REFERENCES public.customer(cid);


--
-- Name: supplier supplier_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_users(id);


--
-- Name: supplierstock supplierstock_bname_bcity_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplierstock
    ADD CONSTRAINT supplierstock_bname_bcity_item_fkey FOREIGN KEY (bname, bcity, item) REFERENCES public.brandstock(bname, bcity, item);


--
-- Name: supplierstock supplierstock_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplierstock
    ADD CONSTRAINT supplierstock_sid_fkey FOREIGN KEY (sid) REFERENCES public.supplier(sid);


--
-- PostgreSQL database dump complete
--

