-- Άσκηση 5 - SQL μέρος (γ)
-- Το αρχείο κρατά την ίδια λογική/εντολές με την τρέχουσα λύση,
-- αλλά με πιο ακριβή σχόλια για το τι ελέγχει κάθε βήμα.


-- =====================
-- c(i) Δημιουργία σχήματος
-- =====================

create table rouxo
( kwdikos int not null,
  perigrafh varchar(50),
  timh float,
  primary key(kwdikos)
);

create table xarakthristika
( kwd int not null,
  xrwma varchar(10) not null,
  megethos varchar(10) not null,
  diathesimothta int,
  primary key(kwd,xrwma,megethos),
  foreign key(kwd) references rouxo(kwdikos) on update cascade on delete cascade
);

create table pelaths
( kwdikos int not null,
  onoma varchar(50),
  fysikh_d varchar(40),
  hlektronikh_d varchar(20),
  primary key(kwdikos)
);

create table kalathi
( kwdikos_p int not null,
  kwdikos_k int not null,
  hmeromhnia datetime,
  primary key(kwdikos_p,kwdikos_k),
  foreign key(kwdikos_p) references pelaths(kwdikos) on update cascade on delete cascade
);
-- Στη συγκεκριμένη υλοποίηση το primary key του καλαθιού είναι σύνθετο:
-- (kwdikos_p, kwdikos_k).
-- Άρα ένα καλάθι αναγνωρίζεται από τον συνδυασμό πελάτη + κωδικού καλαθιού.

create table afora
( kwdikos_pel int not null,
  kwdikos_kal int not null,
  kwd_r int not null,
  xrwma_r varchar(10) not null,
  megethos_r varchar(10) not null,
  primary key(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r),
  foreign key(kwdikos_pel,kwdikos_kal) references kalathi(kwdikos_p,kwdikos_k) on update cascade on delete cascade,
  foreign key(kwd_r,xrwma_r,megethos_r) references xarakthristika(kwd,xrwma,megethos) on update cascade on delete cascade
);
-- Η σχέση "afora" συνδέει:
--   1) ένα συγκεκριμένο καλάθι
--   2) με ένα συγκεκριμένο προϊόν σε συγκεκριμένο χρώμα και μέγεθος.


-- Έλεγχος ότι οι πίνακες δημιουργήθηκαν.
-- Στην αρχή θα είναι όλοι άδειοι.
select * from rouxo;
select * from xarakthristika;
select * from pelaths;
select * from kalathi;
select * from afora;


-- =====================
-- c(ii) Εισαγωγή 3 πλειάδων σε κάθε πίνακα
-- =====================

insert into rouxo(kwdikos,perigrafh,timh) values(1,'blouza',10);
insert into rouxo(kwdikos,perigrafh,timh) values(2,'panteloni',15);
insert into rouxo(kwdikos,perigrafh,timh) values(3,'poukamiso',25.5);

insert into xarakthristika(kwd,xrwma,megethos,diathesimothta) values(1,'blue','large',12);
insert into xarakthristika(kwd,xrwma,megethos,diathesimothta) values(1,'red','small',5);
insert into xarakthristika(kwd,xrwma,megethos,diathesimothta) values(2,'red','large',7);

insert into pelaths(kwdikos,onoma,fysikh_d,hlektronikh_d) values(100,'A','Averof 11','test1@gmail.com');
insert into pelaths(kwdikos,onoma,fysikh_d,hlektronikh_d) values(200,'B','Dodonis 22','test2@gmail.com');
insert into pelaths(kwdikos,onoma,fysikh_d,hlektronikh_d) values(300,'C','Anexarthsias 23','test3@gmail.com');

insert into kalathi(kwdikos_p,kwdikos_k,hmeromhnia) values(100,1,'2016-10-30 10:07:12');
insert into kalathi(kwdikos_p,kwdikos_k,hmeromhnia) values(200,1,'2016-10-30 10:17:22');
insert into kalathi(kwdikos_p,kwdikos_k,hmeromhnia) values(100,2,'2016-10-31 11:15:30');

insert into afora(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r) values(100,1,1,'blue','large');
insert into afora(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r) values(200,1,1,'blue','large');
insert into afora(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r) values(100,2,2,'red','large');

-- Προβολή του τρέχοντος στιγμιότυπου της βάσης μετά τις εισαγωγές.
select * from rouxo;
select * from xarakthristika;
select * from pelaths;
select * from kalathi;
select * from afora;


-- =====================
-- c(iii) Παραδείγματα παραβίασης περιορισμών ακεραιότητας
-- =====================

-- Τα παρακάτω INSERT πρέπει να εκτελούνται ξεχωριστά, ένα-ένα,
-- πάνω στο στιγμιότυπο του c(ii), ώστε να φαίνεται καθαρά ποιος
-- περιορισμός παραβιάζεται και ποιο μήνυμα λάθους επιστρέφει η MySQL.

-- ---------------------
-- Παραβίαση PRIMARY KEY
-- ---------------------

-- Ίδιο kwdikos με υπάρχον ρούχο -> παραβίαση PK του rouxo.
insert into rouxo(kwdikos,perigrafh,timh) values(1,'sorts',5);

-- Ίδιο (kwd, xrwma, megethos) με υπάρχον στιγμιότυπο -> παραβίαση PK του xarakthristika.
insert into xarakthristika(kwd,xrwma,megethos,diathesimothta) values(1,'blue','large',12);

-- Ίδιο kwdikos με υπάρχον πελάτη -> παραβίαση PK του pelaths.
insert into pelaths(kwdikos,onoma,fysikh_d,hlektronikh_d) values(100,'D','Zerva','test4@gmail.com');

-- Ίδιο (kwdikos_p, kwdikos_k) με υπάρχον καλάθι -> παραβίαση σύνθετου PK του kalathi.
insert into kalathi(kwdikos_p,kwdikos_k,hmeromhnia) values(100,1,'2016-10-30 10:08:12');

-- Ίδιο πλήρες 5-άρι κλειδί με υπάρχουσα εγγραφή -> παραβίαση PK του afora.
insert into afora(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r) values(100,1,1,'blue','large');


-- ---------------------
-- Παραβίαση FOREIGN KEY
-- ---------------------

-- Δεν υπάρχει ρούχο με kwdikos = 4 -> παραβίαση FK του xarakthristika προς rouxo.
insert into xarakthristika(kwd,xrwma,megethos,diathesimothta) values(4,'blue','large',12);

-- Δεν υπάρχει πελάτης με kwdikos = 400 -> παραβίαση FK του kalathi προς pelaths.
insert into kalathi(kwdikos_p,kwdikos_k,hmeromhnia) values(400,1,'2016-10-30 10:08:12');

-- Υπάρχει το καλάθι (100,1), αλλά ΔΕΝ υπάρχει το χαρακτηριστικό
-- (kwd_r=1, xrwma_r='blue', megethos_r='small') στον πίνακα xarakthristika.
-- Άρα το παρακάτω παραβιάζει τον FK της afora προς xarakthristika.
insert into afora(kwdikos_pel,kwdikos_kal,kwd_r,xrwma_r,megethos_r) values(100,1,1,'blue','small');

-- Εναλλακτικά, θα μπορούσε να δοθεί και παράδειγμα που να παραβιάζει
-- τον ΑΛΛΟ FK της afora, δηλαδή αυτόν προς kalathi,
-- π.χ. με ανύπαρκτο ζεύγος (kwdikos_pel, kwdikos_kal).


-- =====================
-- c(iv) Συμπεριφορά των FOREIGN KEY σε UPDATE / DELETE
-- =====================

-- Επειδή στα foreign keys έχει οριστεί ON UPDATE CASCADE και ON DELETE CASCADE,
-- τα παρακάτω UPDATE/DELETE ΔΕΝ αποτυγχάνουν.
-- Αντίθετα, οι αντίστοιχες αλλαγές μεταφέρονται αυτόματα στους πίνακες που αναφέρονται
-- στα γονικά κλειδιά, ώστε να μη μείνουν "ορφανές" αναφορές.


-- ======
-- UPDATE
-- ======

-- Αλλάζουμε το πρωτεύον κλειδί του ρούχου από 1 σε 20.
-- Λόγω ON UPDATE CASCADE, ενημερώνονται αυτόματα και όλες οι γραμμές
-- των πινάκων xarakthristika και afora που αναφέρονται στο συγκεκριμένο ρούχο.
update rouxo set kwdikos=20 where kwdikos=1;

select * from rouxo;
select * from xarakthristika;
select * from afora;


-- Αλλάζουμε το πρωτεύον κλειδί του πελάτη από 100 σε 500.
-- Λόγω ON UPDATE CASCADE, ενημερώνονται αυτόματα και οι σχετικές γραμμές
-- στους πίνακες kalathi και afora που αναφέρονται στον πελάτη αυτόν.
update pelaths set kwdikos=500 where kwdikos=100;

select * from pelaths;
select * from kalathi;
select * from afora;

-- Με την ίδια λογική, αν αλλάζαμε τιμές που συμμετέχουν σε γονικά κλειδιά,
-- θα γινόταν αντίστοιχη ενημέρωση και στους εξαρτώμενους πίνακες.
-- Παραδείγματα:
--   * αλλαγή του (kwdikos_p, kwdikos_k) του kalathi -> ενημέρωση των (kwdikos_pel, kwdikos_kal) της afora
--   * αλλαγή του (kwd, xrwma, megethos) του xarakthristika -> ενημέρωση των (kwd_r, xrwma_r, megethos_r) της afora


-- ======
-- DELETE
-- ======

-- Διαγράφουμε το ρούχο με kwdikos = 2.
-- Λόγω ON DELETE CASCADE, θα διαγραφούν αυτόματα και όλες οι γραμμές
-- των πινάκων xarakthristika και afora που εξαρτώνται από αυτό το ρούχο.
delete from rouxo where kwdikos=2;

select * from rouxo;
select * from xarakthristika;
select * from afora;

-- Διαγράφουμε τον πελάτη με kwdikos = 200.
-- Λόγω ON DELETE CASCADE, θα διαγραφούν αυτόματα και όλες οι γραμμές
-- των πινάκων kalathi και afora που συνδέονται με τον συγκεκριμένο πελάτη.
delete from pelaths where kwdikos=200;

select * from pelaths;
select * from kalathi;
select * from afora;

-- Αντίστοιχα, αν διαγραφεί μια γονική γραμμή από kalathi ή xarakthristika,
-- θα διαγραφούν αυτόματα και οι σχετικές εγγραφές της afora.
-- Δηλαδή:
--   * διαγραφή καλαθιού -> διαγραφή όλων των γραμμών της afora που ανήκουν σε αυτό
--   * διαγραφή συγκεκριμένου συνδυασμού (ρούχο, χρώμα, μέγεθος) από xarakthristika
--     -> διαγραφή όλων των γραμμών της afora που αναφέρονται σε αυτόν τον συνδυασμό
