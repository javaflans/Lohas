--
-- PostgreSQL database dump
--

\restrict C8rw7wyj9cTtsOYOwXfoMVWPbm20K5HBnr2YEKhufH8Ubkkhq82qxhgXBf55XJK

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: beacon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.beacon (
    canbeevent boolean NOT NULL,
    endx double precision NOT NULL,
    endy double precision NOT NULL,
    posx double precision NOT NULL,
    posy double precision NOT NULL,
    startx double precision NOT NULL,
    starty double precision NOT NULL,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    beaconid character varying(255) NOT NULL,
    locatlv0 character varying(255),
    locatlv1 character varying(255),
    locatlv2 character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: contact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact (
    contactzipcode integer NOT NULL,
    id integer NOT NULL,
    residentid integer NOT NULL,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    contactaddress character varying(255),
    contactarea character varying(255),
    contactcity character varying(255),
    contactlocalname character varying(255),
    contactmail character varying(255),
    contactmobile character varying(255),
    contactphone character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    address character varying(255),
    city character varying(255),
    companyname character varying(255),
    contactname character varying(255),
    contacttitle character varying(255),
    country character varying(255),
    customerid character varying(255),
    customertypeid character varying(255),
    fax character varying(255),
    phone character varying(255),
    postalcode character varying(255),
    region character varying(255)
);


--
-- Name: event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event (
    id integer NOT NULL,
    eventenddate timestamp(6) without time zone,
    eventstartdate timestamp(6) without time zone,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    beaconid character varying(255),
    eventdesc character varying(255),
    eventtype character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: event_view; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_view (
    canbeevent boolean NOT NULL,
    endx double precision NOT NULL,
    endy double precision NOT NULL,
    id integer NOT NULL,
    posx double precision NOT NULL,
    posy double precision NOT NULL,
    startx double precision NOT NULL,
    starty double precision NOT NULL,
    eventenddate timestamp(6) without time zone,
    eventstartdate timestamp(6) without time zone,
    beaconid character varying(255),
    eventdesc character varying(255),
    eventtype character varying(255),
    locatlv0 character varying(255),
    locatlv1 character varying(255),
    locatlv2 character varying(255),
    usercreated character varying(255),
    userdatecreated character varying(255),
    userlastdatemodify character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: history_view; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.history_view (
    contactzipcode integer NOT NULL,
    endx double precision NOT NULL,
    endy double precision NOT NULL,
    gpslat double precision NOT NULL,
    gpslng double precision NOT NULL,
    id integer NOT NULL,
    isbeacon boolean NOT NULL,
    isfreezed1 boolean NOT NULL,
    isfreezed2 boolean NOT NULL,
    isgps boolean NOT NULL,
    islinked boolean NOT NULL,
    islost boolean NOT NULL,
    islowbattery boolean NOT NULL,
    issos boolean NOT NULL,
    istriggersos boolean NOT NULL,
    posx double precision NOT NULL,
    posy double precision NOT NULL,
    rssi integer NOT NULL,
    startx double precision NOT NULL,
    starty double precision NOT NULL,
    beaconid character varying(255),
    contactaddress character varying(255),
    contactarea character varying(255),
    contactcity character varying(255),
    contactlocalname character varying(255),
    contactmail character varying(255),
    contactmobile character varying(255),
    contactphone character varying(255),
    iothubtime character varying(255),
    linkedname character varying(255),
    locatlv0 character varying(255),
    locatlv1 character varying(255),
    locatlv2 character varying(255),
    readerid character varying(255),
    repeaterid character varying(255),
    residentbirthday character varying(255),
    residentlocalname character varying(255),
    residentphotopath character varying(255),
    residentsex character varying(255),
    soscleartime character varying(255),
    tagcode character varying(255),
    tagdesc character varying(255),
    tagid character varying(255),
    tagtime character varying(255),
    usercreated character varying(255),
    userdatecreated character varying(255),
    userlastdatemodify character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: member; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member (
    id integer NOT NULL,
    mailstatus integer,
    userbirthday date,
    userstatus integer,
    zipcode integer NOT NULL,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    useraddress character varying(255),
    userarea character varying(255),
    usercity character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255),
    userlocalname character varying(255),
    usermail character varying(255),
    username character varying(255),
    userpassword character varying(255),
    userphone character varying(255),
    userphotopath character varying(255),
    useruuid character varying(255)
);


--
-- Name: menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menus (
    id integer NOT NULL,
    parentid integer,
    status integer,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    description character varying(255),
    icon character varying(255),
    label character varying(255),
    name character varying(255),
    path character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: resident; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resident (
    id integer NOT NULL,
    residentbirthday date,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    residentlocalname character varying(255),
    residentphotopath character varying(255),
    residentsex character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: resident_view; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resident_view (
    contactzipcode integer NOT NULL,
    id integer NOT NULL,
    residentbirthday date,
    contactaddress character varying(255),
    contactarea character varying(255),
    contactcity character varying(255),
    contactlocalname character varying(255),
    contactmail character varying(255),
    contactmobile character varying(255),
    contactphone character varying(255),
    residentlocalname character varying(255),
    residentphotopath character varying(255),
    residentsex character varying(255)
);


--
-- Name: security; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.security (
    id integer NOT NULL,
    linked boolean NOT NULL,
    memberid integer,
    menuid integer,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    permissionrole character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.status (
    id integer NOT NULL,
    stucode integer NOT NULL,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    studesc character varying(255),
    stutype character varying(255),
    usagetable character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    linkdate timestamp(6) without time zone,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    linkresident character varying(255),
    tagcode character varying(255),
    tagcompany character varying(255),
    tagdesc character varying(255),
    tagid character varying(255) NOT NULL,
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: tags_copy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags_copy (
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    tagcode character varying(255),
    tagcompany character varying(255),
    tagdesc character varying(255),
    tagid character varying(255) NOT NULL,
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: tracker_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracker_history (
    gpslat double precision NOT NULL,
    gpslng double precision NOT NULL,
    id integer NOT NULL,
    isbeacon boolean NOT NULL,
    isfreezed1 boolean NOT NULL,
    isfreezed2 boolean NOT NULL,
    isgps boolean NOT NULL,
    islinked boolean NOT NULL,
    islost boolean NOT NULL,
    islowbattery boolean NOT NULL,
    issos boolean NOT NULL,
    istriggersos boolean NOT NULL,
    rssi integer NOT NULL,
    iothubtime timestamp(6) without time zone,
    soscleartime timestamp(6) without time zone,
    tagtime timestamp(6) without time zone,
    userdatecreated timestamp(6) without time zone,
    userlastdatemodify timestamp(6) without time zone,
    beaconid character varying(255),
    datauuid character varying(255),
    linkedname character varying(255),
    readerid character varying(255),
    repeaterid character varying(255),
    tagid character varying(255),
    usercreated character varying(255),
    userlastmodify character varying(255)
);


--
-- Name: verify_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.verify_account (
    id integer NOT NULL,
    memberid integer,
    verifyed boolean NOT NULL,
    logindate timestamp(6) without time zone,
    logoutdate timestamp(6) without time zone,
    memberlocalname character varying(255),
    memberusername character varying(255),
    remotehost character varying(255),
    remoteipaddress character varying(255),
    remoteuser character varying(255)
);


--
-- Name: beacon beacon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beacon
    ADD CONSTRAINT beacon_pkey PRIMARY KEY (beaconid);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: event_view event_view_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_view
    ADD CONSTRAINT event_view_pkey PRIMARY KEY (id);


--
-- Name: history_view history_view_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.history_view
    ADD CONSTRAINT history_view_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: menus menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (id);


--
-- Name: resident resident_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT resident_pkey PRIMARY KEY (id);


--
-- Name: resident_view resident_view_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident_view
    ADD CONSTRAINT resident_view_pkey PRIMARY KEY (id);


--
-- Name: security security_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.security
    ADD CONSTRAINT security_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: tags_copy tags_copy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags_copy
    ADD CONSTRAINT tags_copy_pkey PRIMARY KEY (tagid);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tagid);


--
-- Name: tracker_history tracker_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracker_history
    ADD CONSTRAINT tracker_history_pkey PRIMARY KEY (id);


--
-- Name: verify_account verify_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verify_account
    ADD CONSTRAINT verify_account_pkey PRIMARY KEY (id);


--
-- Name: security fk867fgitle6lypx9oy1dhcss6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.security
    ADD CONSTRAINT fk867fgitle6lypx9oy1dhcss6a FOREIGN KEY (memberid) REFERENCES public.member(id);


--
-- Name: verify_account fka0660glrptldwbe7glp8kldo6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verify_account
    ADD CONSTRAINT fka0660glrptldwbe7glp8kldo6 FOREIGN KEY (memberid) REFERENCES public.member(id);


--
-- Name: member fkc56i5l0lv92q5ioq2ojdnp1ul; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT fkc56i5l0lv92q5ioq2ojdnp1ul FOREIGN KEY (userstatus) REFERENCES public.status(id);


--
-- Name: member fkekcr4nfnyrgxqmqdkx08pi5v1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT fkekcr4nfnyrgxqmqdkx08pi5v1 FOREIGN KEY (mailstatus) REFERENCES public.status(id);


--
-- Name: menus fkipaed3f08ics1ust8ollkljso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT fkipaed3f08ics1ust8ollkljso FOREIGN KEY (parentid) REFERENCES public.menus(id);


--
-- Name: menus fkpvim4cxkrqnb2e64hgtii4bwk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT fkpvim4cxkrqnb2e64hgtii4bwk FOREIGN KEY (status) REFERENCES public.status(id);


--
-- Name: security fks3qirilncwsx52eg8effhamf6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.security
    ADD CONSTRAINT fks3qirilncwsx52eg8effhamf6 FOREIGN KEY (menuid) REFERENCES public.menus(id);


--
-- PostgreSQL database dump complete
--

\unrestrict C8rw7wyj9cTtsOYOwXfoMVWPbm20K5HBnr2YEKhufH8Ubkkhq82qxhgXBf55XJK

