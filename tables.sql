--Table: public.product

CREATE TABLE public.product (
  product_id    integer NOT NULL,
  "name"        varchar(45) NOT NULL,
  release_year  smallint,
  media_format  varchar(45) NOT NULL,
  image_thumb   varchar(140),
  image_md      varchar(140),
  image_hd      varchar(140),
  /* Keys */
  CONSTRAINT product_pkey
    PRIMARY KEY (product_id)
) WITH (
    OIDS = FALSE
  );
  
ALTER TABLE public.product
  OWNER TO postgres;

  
--Table: public.author

CREATE TABLE public.author (
  author_id         integer NOT NULL,
  name_first        varchar(45) NOT NULL,
  name_last         varchar(45) NOT NULL,
  profession_title  varchar(45),
  photo             varchar(140),
  /* Keys */
  CONSTRAINT author_pkey
    PRIMARY KEY (author_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.author
  OWNER TO postgres;
  
  
--Table: public.product_author

CREATE TABLE public.product_author (
  product  integer NOT NULL,
  author   integer NOT NULL,
  /* Foreign keys */
  CONSTRAINT author_fk
    FOREIGN KEY (author)
    REFERENCES public.author(author_id), 
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.product_author
  OWNER TO postgres;
  
  
--Table: public.book

CREATE TABLE public.book (
  publisher  varchar(45) NOT NULL,
  isbn       integer NOT NULL,
  subject    varchar(45) NOT NULL,
  pages      integer NOT NULL,
  product    integer NOT NULL,
  /* Keys */
  CONSTRAINT book_pkey
    PRIMARY KEY (isbn),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.book
  OWNER TO postgres;

  
--Table: public.movie

CREATE TABLE public.movie (
  studio    varchar(45),
  genre     varchar(45),
  runtime   integer NOT NULL,
  product   integer NOT NULL,
  movie_id  integer NOT NULL,
  /* Keys */
  CONSTRAINT movie_pkey
    PRIMARY KEY (movie_id),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id)
) WITH (
    OIDS = FALSE
  );
  
ALTER TABLE public.movie  
  OWNER TO postgres;  
  

--Table: public.actor

CREATE TABLE public.actor (
  name_first  varchar(45) NOT NULL,
  name_last   varchar(45) NOT NULL,
  actor_id    integer NOT NULL,
  photo       varchar(140),
  /* Keys */
  CONSTRAINT actor_pkey
    PRIMARY KEY (actor_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.actor
  OWNER TO postgres;
  
  
--Table: public.movie_cast

CREATE TABLE public.movie_cast (
  actor   integer NOT NULL,
  movie   integer NOT NULL,
  "role"  varchar(45),
  /* Foreign keys */
  CONSTRAINT actor_fk
    FOREIGN KEY (actor)
    REFERENCES public.actor(actor_id), 
  CONSTRAINT movie_fk
    FOREIGN KEY (movie)
    REFERENCES public.movie(movie_id)
    DEFERRABLE
    INITIALLY IMMEDIATE
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.movie_cast
  OWNER TO postgres;

  
--Table: public.music

CREATE TABLE public.music (
  studio    varchar(45),
  genre     varchar(45),
  "length"  integer,
  product   integer NOT NULL,
  music_id  integer NOT NULL,
  /* Keys */
  CONSTRAINT music_pkey
    PRIMARY KEY (music_id),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.music
  OWNER TO postgres;
  

--Table: public.tracklist

CREATE TABLE public.tracklist (
  album         integer NOT NULL,
  track_number  integer,
  "name"        varchar(45) NOT NULL,
  lenght        integer,
  /* Keys */
  CONSTRAINT tracklist_pkey
    PRIMARY KEY (album),
  /* Foreign keys */
  CONSTRAINT album_fk
    FOREIGN KEY (album)
    REFERENCES public.music(music_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.tracklist
  OWNER TO postgres;  
  
  
--Table: public.store

CREATE TABLE public.store (
  store_id      integer NOT NULL,
  "name"        varchar(45) NOT NULL,
  logo          varchar(140),
  url           varchar(140) NOT NULL,
  ebit_ranking  integer,
  /* Keys */
  CONSTRAINT store_pkey
    PRIMARY KEY (store_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.store
  OWNER TO postgres;

  
--Table: public.product_store

CREATE TABLE public.product_store (
  product  integer NOT NULL,
  store    integer NOT NULL,
  price    money NOT NULL,
    -- df: float=uniform alpha=10.0 beta=999.99
  url      varchar(140) NOT NULL,
  /* Keys */
  CONSTRAINT product_store_pkey
    PRIMARY KEY (product, store),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id), 
  CONSTRAINT store_fk
    FOREIGN KEY (store)
    REFERENCES public.store(store_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.product_store
  OWNER TO postgres;
  
 
--Table: public.ads

CREATE TABLE public.ads (
  ads_id          integer NOT NULL,
  url             varchar(140) NOT NULL,
  banner          varchar(140) NOT NULL,
  date_start      date NOT NULL,
  date_end        date NOT NULL,
  date_registred  date NOT NULL,
  store           integer,
  /* Keys */
  CONSTRAINT ads_pkey
    PRIMARY KEY (ads_id),
  /* Foreign keys */
  CONSTRAINT store_fk
    FOREIGN KEY (store)
    REFERENCES public.store(store_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.ads
  OWNER TO postgres;
  
  
--Table: public.user

CREATE TABLE public."user" (
  user_id     integer NOT NULL,
  username    varchar(45) NOT NULL,
  email       varchar(45) NOT NULL,
  "password"  varchar(45) NOT NULL,
  name_first  varchar(45) NOT NULL,
  name_last   varchar(45) NOT NULL,
  photo       varchar(140),
  /* Keys */
  CONSTRAINT user_pkey
    PRIMARY KEY (user_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public."user"
  OWNER TO postgres;
  

--Table: public.follows

CREATE TABLE public.follows (
  "user"  integer NOT NULL,
  follow  integer NOT NULL,
  since   date NOT NULL,
  /* Foreign keys */
  CONSTRAINT follow_fk
    FOREIGN KEY (follow)
    REFERENCES public."user"(user_id), 
  CONSTRAINT user_fk
    FOREIGN KEY ("user")
    REFERENCES public."user"(user_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.follows
  OWNER TO postgres;
  
  
--Table: public.review

CREATE TABLE public.review (
  review_id       integer NOT NULL,
  stars           smallint,
  "comment"       text NOT NULL,
  published_date  date NOT NULL,
  "user"          integer NOT NULL,
  product         integer NOT NULL,
  /* Keys */
  CONSTRAINT review_pkey
    PRIMARY KEY (review_id),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id), 
  CONSTRAINT user_fk
    FOREIGN KEY ("user")
    REFERENCES public."user"(user_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.review
  OWNER TO postgres;
  
  
--Table: public.wishlist

CREATE TABLE public.wishlist (
  wishlist_id  integer NOT NULL,
  "name"       varchar(45) NOT NULL,
  is_public    boolean NOT NULL DEFAULT true,
  "owner"      integer NOT NULL,
  /* Keys */
  CONSTRAINT wishlist_pkey
    PRIMARY KEY (wishlist_id),
  /* Foreign keys */
  CONSTRAINT owner_fk
    FOREIGN KEY ("owner")
    REFERENCES public."user"(user_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.wishlist
  OWNER TO postgres;
 
 
--Table: public.wishlist_product

CREATE TABLE public.wishlist_product (
  wishlist        integer NOT NULL,
  product         integer NOT NULL,
  date_registred  date NOT NULL,
  priority_order  integer,
  already_won     boolean NOT NULL DEFAULT false,
  /* Keys */
  CONSTRAINT whishlist_product_pkey
    PRIMARY KEY (wishlist, product),
  /* Foreign keys */
  CONSTRAINT product_fk
    FOREIGN KEY (product)
    REFERENCES public.product(product_id), 
  CONSTRAINT wishlist_fk
    FOREIGN KEY (wishlist)
    REFERENCES public.wishlist(wishlist_id)
) WITH (
    OIDS = FALSE
  );

ALTER TABLE public.whishlist_product
  OWNER TO postgres;
