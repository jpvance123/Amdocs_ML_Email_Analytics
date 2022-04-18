From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <23354342.1075841472445.JavaMail.evans@thyme>
Date: Wed, 16 Jan 2002 04:22:29 -0800 (PST)
From: ernesto@ipimar.pt
Subject: Re: [R] R for large data sets
Cc: wei@enron.com, wei_xiaoyan@emc.com, r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: wei@enron.com, wei_xiaoyan@emc.com, r-help@stat.math.ethz.ch
X-From: Ernesto Jardim <ernesto@ipimar.pt>
X-To: 
X-cc: wei, xiaoyan <wei_xiaoyan@emc.com>, r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

Hi

I'm using some large datasets and I found the ROracle package to be of
great help.

If you have the chance to create a database in Oracle or MySQL with one
single table for your dataset, you can then use the ROracle package to
access the dataset. I found several advantages on that.

I don't import the data into my environment. I use a small function (see
below) to access the dataset and because the result is a data.frame you
can use it as usually.

Your environment will not be to large and you'll have the ram memory
less full.

It's easier to select subsets with SQL than S/R language.

Hope it helps

Regards

EJ

--//--

ora.fun <- function(){

        library(ROracle)
        m <- dbManager("Oracle")
        con <- dbConnect(m,user="user",password="password")
        dat <- quickSQL(con,"select ...")
        close(con)
        unload(m)
        dat

}

--//--

On Tue, 2002-01-15 at 19:43, Prof Brian Ripley wrote:
> On Tue, 15 Jan 2002, wei, xiaoyan wrote:
>
> > As a part of our regular data analysis, I have to read in large data sets
> > with six columns and about a million rows. In Splus, this usually take a
> > couple of minutes. I just tried R, it seems take forever to use read.table()
> > to read in the data frame! It did not help much even though I specified
> > colClasses and nrows in read.table().
> >
> > How is R's ability to analyze large data sets? I used R on solaris 2.6 and I
> > used all default compilation flags when building the R package. Will it help
> > if I use some compilation flags with higher optimization level?
>
> It will help to use R-patched, since I guess you are using 1.4.0.
> Also, look in the list archives, as I answered this more fully earlier
> today.
>
> In either S-PLUS or R, scan would be a better choice for such a dataset.
>
> --
> Brian D. Ripley,                  ripley@stats.ox.ac.uk
> Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
> University of Oxford,             Tel:  +44 1865 272861 (self)
> 1 South Parks Road,                     +44 1865 272860 (secr)
> Oxford OX1 3TG, UK                Fax:  +44 1865 272595
>
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
> Send "info", "help", or "[un]subscribe"
> (in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
> _._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._


-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <30239274.1075841472469.JavaMail.evans@thyme>
Date: Wed, 16 Jan 2002 00:37:27 -0800 (PST)
From: ligges@statistik.uni-dortmund.de
To: schratz@ifgb.uni-hannover.de
Subject: Re: [R] memory problems
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Uwe Ligges <ligges@statistik.uni-dortmund.de>
X-To: Cornelia Schratz <Schratz@ifgb.uni-hannover.de>
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST



Cornelia Schratz wrote:
>
> Dear all,
> I want to increase the memory of R (it is to small for my large data set).
> However I find only instructions for UNIX. Could somebody write me how to
> increase the memory for R running on WinNT, please?

See the "R for Windows FAQ", section 2.4, or ?Memory:

"(On Windows the --max-mem-size option sets the maximum memory
allocation: it has a minimum allowed value of 10M. This is intended to
catch attempts to allocate excessive amounts of memory which may cause
other processes to run out of resources. The default is the smaller of
the amount of physical RAM in the machine and 256Mb. See also
memory.limit.)"


Uwe
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <24240515.1075841472201.JavaMail.evans@thyme>
Date: Thu, 31 Jan 2002 02:04:45 -0800 (PST)
From: ripley@stats.ox.ac.uk
To: steinep@uni-muenster.de
Subject: Re: [R] Passing parameters with Rcmd BATCH
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Prof Brian D Ripley <ripley@stats.ox.ac.uk>
X-To: Petra Steiner <steinep@uni-muenster.de>
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Thu, 31 Jan 2002, Petra Steiner wrote:

> Hello!
>
> How can I pass arguments with Rcmd BATCH and commandArgs() ?
>
> "Rcmd BATCH myparameter input.R output"
>
> and similar permutations do not work.

They do not work, and they are documented not to work: try Rcmd BATCH
--help.

A convenient way is to use environental variables, and the easiest way to
do that is

Rterm --restore --save < input.R > output MYPAR=foo

and in input.R

mypar <- Sys.getenv("MYPAR")

My recollection is that you *can* add parameters to the command line with
Rterm and use commandArgs(), but this is not a documented feature.  Duncan
Temple Lang has been promising it (on all ports of R) from time to time.

(What does work on Windows but is undocumented (it supports file
associations) is to append to the command line of Rgui or Rterm the path to
a .RData file, which is used in place of the one in the working directory.)

--
Brian D. Ripley,                  ripley@stats.ox.ac.uk
Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
University of Oxford,             Tel:  +44 1865 272861 (self)
1 South Parks Road,                     +44 1865 272860 (secr)
Oxford OX1 3TG, UK                Fax:  +44 1865 272595

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <7708021.1075841472517.JavaMail.evans@thyme>
Date: Tue, 15 Jan 2002 23:27:20 -0800 (PST)
From: ripley@stats.ox.ac.uk
To: p.connolly@hortresearch.co.nz
Subject: Re: [R] Postsript/Lattice interaction
Cc: deepayansarkar@yahoo.com, r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: deepayansarkar@yahoo.com, r-help@stat.math.ethz.ch
X-From: Prof Brian Ripley <ripley@stats.ox.ac.uk>
X-To: Patrick Connolly <P.Connolly@hortresearch.co.nz>
X-cc: Deepayan Sarkar <deepayansarkar@yahoo.com>, R-help <r-help@stat.math.ethz.ch>
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Wed, 16 Jan 2002, Patrick Connolly wrote:

> According to Deepayan Sarkar:
> |>
> |>
> |>
> |> It's a known problem (with grid actually).
> |>
> |>
> |> --- Kieran Healy <kjhealy@arizona.edu> wrote:
> |> > Hello --
> |> >
> |> > I'm using R-1.4.0 on a PC running SuSE Linux 7.1. Following Christian
> |> > Ritter's announcement this morning, I downloaded the new versions of
> |> > lattice and grid. I find that loading the lattice library causes
> |> > postcript() to include a blank first page when creating a file. Like
>
> Now I'm confused again.  I had this problem with an earlier version of
> grid but not with Version: 0.2 dated: 2000/11/07.  I did have to
> specify bg = "white" when color = FALSE otherwise I'd get a pale grey
> background but that's not a great problem.
>
> Am I to understand that the fix that was made in 0.2 is now broken
> again?  (I'm still using 1.3.1.)

grid 0.5 is quite different from 0.2: it relies on changes made to the
graphics drivers shipped with R.

Yes, grid 0.5 gives an empty first page when opening a device. Paul
Murrell will fix it when he has time.


--
Brian D. Ripley,                  ripley@stats.ox.ac.uk
Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
University of Oxford,             Tel:  +44 1865 272861 (self)
1 South Parks Road,                     +44 1865 272860 (secr)
Oxford OX1 3TG, UK                Fax:  +44 1865 272595

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <24665576.1075841472565.JavaMail.evans@thyme>
Date: Tue, 15 Jan 2002 13:29:35 -0800 (PST)
From: majordomo@stat.math.ethz.ch
To: cooper.richey@enron.com
Subject: Welcome to r-help
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Majordomo@stat.math.ethz.ch@ENRON
X-To: Richey, Cooper </O=ENRON/OU=NA/CN=RECIPIENTS/CN=CRICHEY>
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

--

Welcome to the r-help mailing list!

Please save this message for future reference.  Thank you.

If you ever want to remove yourself from this mailing list,
send the following command in email to
<r-help-request@stat.math.ethz.ch>:

    unsubscribe

Or you can send mail to <Majordomo@stat.math.ethz.ch> with the following
command in the body of your email message:

    unsubscribe r-help

or from another account, besides "Richey, Cooper" <Cooper.Richey@enron.com>:

    unsubscribe r-help "Richey, Cooper" <Cooper.Richey@enron.com>

If you ever need to get in contact with the owner of the list,
(if you have trouble unsubscribing, or have questions about the
list itself) send email to <owner-r-help@stat.math.ethz.ch> .
This is the general rule for most mailing lists when you need
to contact a human.

 Here's the general information for the list you've subscribed to,
 in case you don't already have it:

[Last updated on: Sep 26 22:02 2000]

* public list for getting help on "R" (statistics environment ~ "GNU S") *

The purposes of the mailing list  "R-help"  include

- - Announcement about the development of R; availability of new code, etc.
- - Questions and Answers about problems and solutions using R.
- - Enhancements and patches to the source code and documentation of R.
- - Comparison with S / S-plus, compatibility.
- - Posting of nice examples, benchmarks, .....

The list has had
	516  (Jan  1, 2000)
	315  (Jan  1, 1999)
	205  (Jan 26, 1998)
	116  (Apr  1, 1997)
	 77  (Nov 14, 1996)
entries [persons or sub-lists] from all continents.

There are 3 mailing lists dedicated to "R" :

1) R-announce	: Only announcement of new versions / important patches
2) R-help	: Questions / Answers about ("released versions of") R
3) R-devel	: The list of pre-testers and "developers" of R.

where "R-announce" is gatewayed to "R-help",
i.e., if you are only interested in announcements on R,
you could rather subscribe to  R-announce  instead of  R-help.
- ---------------------------------------------------------------------------

The list is archived ==> see R's Web site

	 http://www.R-project.org/
- ----------------------------------------------------------------------------

CRAN (= Comprehensive R Archive Network)  and its mirror sites
==== should carry ALL available files relevant to R,
     including  source, binaries, contributed software and documentation.
     The `mother of the CRAN' is
	http://cran.R-project.org/
- -----------------------------------------------------------------------------

A `FAQ' (list of Frequently Asked Questions) is available
from CRAN or
      Kurt Hornik <Kurt.Hornik@ci.tuwien.ac.at> at
      http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <20512299.1075841472299.JavaMail.evans@thyme>
Date: Thu, 24 Jan 2002 01:44:17 -0800 (PST)
From: vito.muggeo@giustizia.it
To: petr.pikal@precheza.cz, r-help@stat.math.ethz.ch
Subject: Re: [R] aggregate, by tapply
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: "vito muggeo" <vito.muggeo@giustizia.it>
X-To: Petr Pikal <petr.pikal@precheza.cz>, r-help@stat.math.ethz.ch
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

Hi Petr,
probably I don't understand correctly your question. However
you can write any function with several arguments (input variables) and
after use tapply. That is:

fn<-function(arg1, arg2, arg3, ....){....}
tapply(arg1, factor, fn, arg2, arg3,....)

Furthermore you can you the three dots "..." to pass any argument in the
functions in your fn()

Hope this helps you!
vito


----- Original Message -----
From: "Petr Pikal" <petr.pikal@precheza.cz>
To: <r-help@stat.math.ethz.ch>
Sent: Thursday, January 24, 2002 7:56 AM
Subject: [R] aggregate, by tapply


> Dear R users
>
> I searched some sources but i did not find an answer.Please give
> me some hint to following problem.
>
> I would like to compute a summary statistic for some vector for
> different factor levels. I know I can use tapply or aggregate but I
> do not know if there is a way how to use function with several
> (two) variable input (like weighted.mean).
>
> I wrote a simple a function for factor weighted mean
> fff<-function(x,fact,w)
> {
> ws<-tapply(w,fact,sum)
> newx<-x*w
> tapply(newx,fact,sum)/ws
> }
>
> which can handle particular case but does exist some more general
> solution how to use FUN(X1,X2) in aggregation procedures
> (tapply, aggregate, by) directly?
>
> Thank you
> Petr Pikal
> petr.pikal@precheza.cz
> p.pik@volny.cz
>
>
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
-.-.-
> r-help mailing list -- Read
http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
> Send "info", "help", or "[un]subscribe"
> (in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
>
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._.
_._
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <20988851.1075841472129.JavaMail.evans@thyme>
Date: Mon, 4 Feb 2002 10:10:47 -0800 (PST)
From: tlumley@u.washington.edu
To: pjohnson@biostat.ufl.edu
Subject: Re: [R] regression trees
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Thomas Lumley <tlumley@u.washington.edu>
X-To: Patches Johnson <pjohnson@biostat.ufl.edu>
X-cc: R-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Mon, 4 Feb 2002, Patches Johnson wrote:

> I am trying to find documentation in R to help in  formulating
> classification and regression trees (CART).  Where in the documentation
> of R can I find info on the 'tree' command?

You don't want the tree() command. You want the rpart() command in the
rpart package (which should be part of your R distribution).

For more background information there is a Mayo Clinic technical report
(#61) by the authors of rpart, available from
  http://www.mayo.edu/hsr/techrpt.html

It's also described in Venables & Ripley MASS, like most things.


	-thomas

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <26458421.1075841472420.JavaMail.evans@thyme>
Date: Fri, 18 Jan 2002 15:01:00 -0800 (PST)
From: tlumley@u.washington.edu
To: nawlnz@yahoo.com
Subject: Re: [R] Replacing data.frame values
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Thomas Lumley <tlumley@u.washington.edu>
X-To: Dennis L. Malandro <nawlnz@yahoo.com>
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Fri, 18 Jan 2002, Dennis L. Malandro wrote:

> Hello,
>
> I have two data frames, NameAndConc.df and
> WhichOnes.df.  NameAndConc.df has two columns, the
> first column is the names of some material, and the
> second column is the concentration of active
> ingredient.
>
> > NameAndConc.df
>        name conc
> 1 material1  0.8
> 2 material2  0.5
> 3 material3  0.4
>
> WhichOnes.df has two columns, each of which specifies
> which material.
>
> > WhichOnes.df
>   component1 component2
> 1  material2  material3
> 2         NA  material1
> 3  material3  material2
> 4  material2         NA
>
> From these two data.frames, I'd like to generate a
> third data frame that is WhichOnes.df with the names
> replaced by the corresponding concentrations from
> NameAndConc.df.  So it would be
>
> > New.df
>   component1 component2
> 1        0.5        0.4
> 2         NA        0.8
> 3        0.4        0.5
> 4        0.5         NA
>
>
> Would someone please lend me a help'n hand with this?

You need match().
  match(New.df$component1,Nameandconc.df$name)
gives the row numbers in Nameandconc.df corresponding to the names of
component 1.

So
 Nameandconc.df$conc[match(New.df$component1,Nameandconc.df$name)]
gives the concentrations

and to do them all at once

apply(New.df, 2, function(this.component)
       Nameandconc.df$conc[match(this.component, Nameandconc.df$name)])


	-thomas

Thomas Lumley			Asst. Professor, Biostatistics
tlumley@u.washington.edu	University of Washington, Seattle

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <5274081.1075841472177.JavaMail.evans@thyme>
Date: Mon, 4 Feb 2002 02:40:56 -0800 (PST)
From: jniesch@gwdg.de
To: stuart.leask@nottingham.ac.uk
Subject: Re: [R] How do you delete variables from a data frame?
Cc: r-help@r-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@r-project.org
X-From: Jens Nieschulze <jniesch@gwdg.de>
X-To: Stuart Leask <stuart.leask@nottingham.ac.uk>
X-cc: r-help-request Mailing List <r-help@r-project.org>
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Mon, 4 Feb 2002, Stuart Leask wrote:

%Is there a simple way of removing variables from a dataframe?
%
%- rm(dataframe$VAR) doesn't seem to work
%- Copying all but the unwanted variables into a new data frame is awkward
%when there are a lot of variables.
%- I haven't found any references to this in the help files.

dataframe$VAR<-NULL

%
%
%Stuart
%Dr Stuart Leask MA MRCPsych, Clinical Lecturer in Psychiatry
%University of Nottingham Dept of Psychiatry, Duncan Macmillan House
%Porchester Road, Nottingham. NG3 6AA. UK
%http://www.nottingham.ac.uk/psychiatry/staff/sjl.html
%
%-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
%r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
%Send "info", "help", or "[un]subscribe"
%(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
%_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._
%

***********************************************************************
Jens Nieschulze

Institute for Forest Biometrics &	Phone: ++49-551-39-12107
Applied Computer Science		Fax  : ++49-551-39-3465
Buesgenweg 4
37077 Goettingen		E-mail: jniesch@uni-forst.gwdg.de
GERMANY				http://www.uni-forst.gwdg.de/~jniesch

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <1888960.1075841472153.JavaMail.evans@thyme>
Date: Mon, 4 Feb 2002 03:35:08 -0800 (PST)
From: steinep@uni-muenster.de
To: ripley@stats.ox.ac.uk
Subject: Re: [R] Passing parameters with Rcmd BATCH
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: "Petra Steiner" <steinep@uni-muenster.de>
X-To: Prof Brian D Ripley <ripley@stats.ox.ac.uk>
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

Dear Prof. Ripley,

thanks for your answer. This might be useful for other novices:

Something like Rterm --restore --save < input.R > out COL=6
 does the job.

In input.R:
co <- as.numeric(Sys.getenv("COL"))

But commandArgs() works as well for Rterm.

Regards,
Petra Steiner


-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <16059948.1075841472492.JavaMail.evans@thyme>
Date: Wed, 16 Jan 2002 00:44:28 -0800 (PST)
From: ligges@statistik.uni-dortmund.de
To: synergy.synergy@synergy.com.au
Subject: Re: [R] Subsetting data frames without a loop
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Uwe Ligges <ligges@statistik.uni-dortmund.de>
X-To: Michael_Nielsen/Syd/Synergy.SYNERGY@synergy.com.au
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST



Michael_Nielsen/Syd/Synergy.SYNERGY@synergy.com.au wrote:
>
> I KNOW this should be easy, but I'm stuck.
>
> My data frame consists of multiple observations from each of a number of
> stations, and what I would like to do is create another data frame that
> contains all the variables of the first, but only rows where a certain
> variable is at its maximum for the station.
>
> So, for example:
>
> > my.df
>    stn obs           v
> 1    1   1  0.26400396
> 2    2   1 -0.79194397
> 3    3   1  0.11924528
> 4    4   1  0.42596859
> 5    5   1 -0.50528235
> 6    1   2 -1.57524853
> 7    2   2  0.17762482
> 8    3   2 -0.83013770
> 9    4   2 -0.53203400
> 10   5   2 -2.71397275
> 11   1   3  0.26902053
> 12   2   3  2.01147908
> 13   3   3  0.73301643
> 14   4   3 -0.67333384
> 15   5   3 -1.36219773
> 16   1   4 -2.20342109
> 17   2   4  0.18941702
> 18   3   4  0.51492032
> 19   4   4  0.03597370
> 20   5   4 -1.43502366
> 21   1   5 -1.34589392
> 22   2   5  1.00389195
> 23   3   5 -0.21233041
> 24   4   5 -1.35141044
> 25   5   5 -0.02052348
>
> > tapply(v,factor(stn),max)
>           1           2           3           4           5
>  0.26902053  2.01147908  0.73301643  0.42596859 -0.02052348
>
> so my new data frame should contain (possibly multiple rows per station)
>
>    stn obs           v
> 1    1   3  0.26902053
> 2    2   3  2.01147908
> 3    3   3  0.73301643
> 4    4   1  0.42596859
> 5    5   5 -0.02052348


As a first idea:

  my.df[tapply(v,factor(stn), function(x) which(v==max(x))),]


Uwe
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <25984235.1075841472225.JavaMail.evans@thyme>
Date: Thu, 31 Jan 2002 01:05:50 -0800 (PST)
From: maechler@stat.math.ethz.ch
To: r-help@stat.math.ethz.ch
Subject: [R] R-help & -devel mailing lists : indigestion problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Martin Maechler <maechler@stat.math.ethz.ch>
X-To: R-help@stat.math.ethz.ch
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

Because of a lapsus on my side and then a problematic server
re-boot at just the wrong time,  the daily digest versions of the R mailing
lists (see the lower part of http://www.r-project.org/mail.html)
haven't been delivered in time, unfortunately.
I'm sending this message just *before* starting the digest
manually for today. I hope this won't happen anymore.

Apropos, I'd like to `advertize' the digest lists to all
R-help readers who feel they can't cope with the daily amount
of traffic anymore (should you rather use more than one mail
		    inbox, e.g. using procmail and/or emacs+Gnus?) :

To keep the volume low, I'd recommend subscribing to both
R-announce and R-help-digest.

Your list maintainer,
Martin Maechler <maechler@stat.math.ethz.ch>	http://stat.ethz.ch/~maechler/
Seminar fuer Statistik, ETH-Zentrum  LEO C16	Leonhardstr. 27
ETH (Federal Inst. Technology)	8092 Zurich	SWITZERLAND
phone: x-41-1-632-3408		fax: ...-1228			<><
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <28610678.1075841472541.JavaMail.evans@thyme>
Date: Tue, 15 Jan 2002 13:34:55 -0800 (PST)
From: majordomo@stat.math.ethz.ch
To: cooper.richey@enron.com
Subject: Welcome to r-announce
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Majordomo@stat.math.ethz.ch@ENRON
X-To: Richey, Cooper </O=ENRON/OU=NA/CN=RECIPIENTS/CN=CRICHEY>
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

--

Welcome to the r-announce mailing list!

Please save this message for future reference.  Thank you.

If you ever want to remove yourself from this mailing list,
send the following command in email to
<r-announce-request@stat.math.ethz.ch>:

    unsubscribe

Or you can send mail to <Majordomo@stat.math.ethz.ch> with the following
command in the body of your email message:

    unsubscribe r-announce

or from another account, besides "Richey, Cooper" <Cooper.Richey@enron.com>:

    unsubscribe r-announce "Richey, Cooper" <Cooper.Richey@enron.com>

If you ever need to get in contact with the owner of the list,
(if you have trouble unsubscribing, or have questions about the
list itself) send email to <owner-r-announce@stat.math.ethz.ch> .
This is the general rule for most mailing lists when you need
to contact a human.

 Here's the general information for the list you've subscribed to,
 in case you don't already have it:

[Last updated on: Sep 26 22:02 2000]

* public list for ANNOUNCEments on "R" (statistics environment ~ "GNU S") *

The purpose of this mailing list "R-announce" is

		       Distribution of announcements
			about the development of R,
		      availability of new code, etc.

Therefore, "R-announce" should have less than one message per day,
typically rather only a few messages per month.

There are 3 mailing lists dedicated to "R" :

1) R-announce	: Only announcement of new versions / important patches
2) R-help	: Questions / Answers about ("released versions of") R
3) R-devel	: The list of pre-testers and "developers" of R.

where "R-announce" is gatewayed to "R-help",
i.e., if you are only interested in announcements on R,
you could rather subscribe to  R-announce  instead of  R-help.
- ---------------------------------------------------------------------------

The list is archived ==> see R's Web site

	 http://www.R-project.org/
- ----------------------------------------------------------------------------

CRAN (= Comprehensive R Archive Network)  and its mirror sites
==== should carry ALL available files relevant to R,
     including  source, binaries, contributed software and documentation.
     The `mother of the CRAN' is
	http://cran.R-project.org/
- -----------------------------------------------------------------------------

A `FAQ' (list of Frequently Asked Questions) is available
from CRAN or
      Kurt Hornik <Kurt.Hornik@ci.tuwien.ac.at> at
      http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <18416528.1075841472276.JavaMail.evans@thyme>
Date: Sun, 27 Jan 2002 09:54:14 -0800 (PST)
From: deleeuw@stat.ucla.edu
To: r-announce@stat.math.ethz.ch
Subject: Journal of Statistical Software
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Jan de Leeuw <deleeuw@stat.ucla.edu>
X-To: r-announce@stat.math.ethz.ch
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST


JSS, which is at http://www.jstatsoft.org, publishes statistical software
with manuals, as well as papers describing, comparing, and evaluating
statistical
software. Abstracts of all contributions accepted in JSS are published in
printed form in JCGS.

Although we publish software written in any language, we especially
welcome software written in R. The general idea is that packages written
in R can be documented in both "R News" and in JSS, but that generally
the
description in JSS will be more extensive and more seriously
peer-reviewed.
Everybody in the R community is encouraged to submit their R products
to JSS, we even welcome "code snippet" type of contributions (which will
go into a separate section of the journal).

Volume 7, 2002, consists so far of the following three issues

issue 1:
S. Weisberg
Dimension reduction regression in R.

issue 2:
A. Zeileis, F. Leisch, and K. Hornik
strucchange: an R package for testing for structural change
in linear regression models

issue 3:
G. Marsaglia and W.W. Tsang
Some difficult-to-pass tests of randomness.

===
Jan de Leeuw; Professor and Chair, UCLA Department of Statistics;
US mail: 9432 Boelter Hall, Box 951554, Los Angeles, CA 90095-1554
phone (310)-825-9550;  fax (310)-206-5658;  email: deleeuw@stat.ucla.edu
homepage: http://www.stat.ucla.edu/~deleeuw
========================================================
           No matter where you go, there you are. --- Buckaroo Banzai
                    http://www.stat.ucla.edu/~deleeuw/sounds/nomatter.au
========================================================

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-announce mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-announce-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <11991367.1075841472324.JavaMail.evans@thyme>
Date: Thu, 24 Jan 2002 00:10:09 -0800 (PST)
From: siim@obs.ee
To: hodgess@uhddx01.dt.uh.edu
Subject: [R] Re: your mail
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Ott Toomet <siim@obs.ee>
X-To: Erin Hodgess <hodgess@uhddx01.dt.uh.edu>
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

Hi,

you have to use tapply().  A small example:

> region <- c("Atl", "Mount", "Atl")
> state <- c("NY", "AR", "WAS")
> pop <- c(1000, 100, 1000)
> d <- data.frame(region,state,pop)
	# note that region and state are coerced to factors by data.frame()
> tapply(d$pop, d$region, sum)
  Atl Mount
 2000   100

A very similar example was in ,,An introduction to R'' for version 1.1, I
think it is in the current version too.


best wishes,

Ott Toomet




On Wed, 23 Jan 2002, Erin Hodgess wrote:

> Dear R People:
>
> Here is a very simple question, please:
>
> I have a data frame with the state name, state division, and population.
>
> Note: state division is something like Atlantic, Mountain, etc.
>
> I want to produce a table with the state division and the total of the
> populations for the states within that division.
>
> I've been messing with "table" but so far, no luck.
>
> This is R1.3.1, on Windows 98.
>
> thanks in advance!
>
> Sincerely,
> Erin Hodgess
> Associate Professor
> Department of Computer and Mathematical Sciences
> University of Houston - Downtown
> 1 Main Street
> Houston, TX 77002
> mailto: hodgess@uhddx01.dt.uh.edu
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
> Send "info", "help", or "[un]subscribe"
> (in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
> _._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._
>

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <10991923.1075841472348.JavaMail.evans@thyme>
Date: Wed, 23 Jan 2002 23:35:03 -0800 (PST)
From: ripley@stats.ox.ac.uk
To: farrar.david@epamail.epa.gov
Subject: Re: [R] driving R from Python (calldll?)
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Prof Brian Ripley <ripley@stats.ox.ac.uk>
X-To: Farrar.David@epamail.epa.gov
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

On Wed, 23 Jan 2002 Farrar.David@epamail.epa.gov wrote:

> Sam Rushing's Python extension 'calldll' will supposedly give me access
> to any DLL,
> and presumably R.DLL in particular, from Python.  I have no experience
> manipulating DLLs as
> yet.  I am learning Python.  I can't find any simple step-by-step
> instructions on how
> to get done what I want to do.  Does anyone have experience with this?
> Is there a
> better way?  Of course, one can use Rterm with DOS piping commands.

Presumably this is for Windows.  You can't use R.dll in isolation.
What you can do is the use the DCOM interface written by Thomas Baier that
you will find on CRAN, which provides a completely standard Windows
interface that I am sure Python can talk to.  My suspicion is that
this would be much easier than porting RSPython to Windows, because no
work would be involved on the R side.  Conversely, it will give you less,
but you don't say anything about `to get done what I want to do'.

BTW

`Of course, one can use Rterm with DOS piping commands'

isn't really true.  Rterm is a Windows program, not a DOS program.  You
can certainly do it on Windows NT/2000/XP, but pipes are limited on
95/98/ME, and DOS can't pipe to Windows programs.  Guido and I failed to
get this sort of thing to work from R for pipe connections under 95/98/ME,
and found lots of things which did not work as documented nor as on NT in
the process.  Also, Perl's system() has problems with redirection and
pipes on 95/98/ME.  So beware!

--
Brian D. Ripley,                  ripley@stats.ox.ac.uk
Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
University of Oxford,             Tel:  +44 1865 272861 (self)
1 South Parks Road,                     +44 1865 272860 (secr)
Oxford OX1 3TG, UK                Fax:  +44 1865 272595

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <6118236.1075841472249.JavaMail.evans@thyme>
Date: Wed, 30 Jan 2002 08:34:50 -0800 (PST)
From: ripley@stats.ox.ac.uk
To: r-announce@r-project.org
Subject: Windows binaries of R 1.4.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Prof Brian Ripley <ripley@stats.ox.ac.uk>
X-To: R-announce@r-project.org
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST


Windows binaries for 1.4.1 are available at

http://www.stats.ox.ac.uk/pub/RWin

and will mirror across CRAN over the next couple of days.

SetupR.exe in this release contains the grid and lattice packages.

These have been built on the same system as the second release of rw1040
and R-patched so I do not anticipate any problems but have only been able
to test them on Windows 2000.

This is a patch release, and the only Windows-specific change is to use
try() when updating HTML indices, e.g. from help.start() which also has a
new `update' argument to turn off updating if required.

--
Brian D. Ripley,                  ripley@stats.ox.ac.uk
Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
University of Oxford,             Tel:  +44 1865 272861 (self)
1 South Parks Road,                     +44 1865 272860 (secr)
Oxford OX1 3TG, UK                Fax:  +44 1865 272595

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-announce mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-announce-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <18458807.1075841472395.JavaMail.evans@thyme>
Date: Tue, 22 Jan 2002 22:57:28 -0800 (PST)
From: pfaffman@relaxpc.com
To: aarons@aberrant.org
Subject: Re: [R] exporting plots
Cc: r-help@stat.math.ethz.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Bcc: r-help@stat.math.ethz.ch
X-From: Jay Pfaffman <pfaffman@relaxpc.com>
X-To: aarons@aberrant.org
X-cc: r-help@stat.math.ethz.ch
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

> I'm running R (latest) on linux, using gnome.  I was wondering how
> export the plots to an image file of sort sort.  I can't find anything
> obvious in the documentation.

Finally one I can answer!  (Thanks to those pointing out to me the
various docs in the "user contributed" section.  I'm on my way to
knowing how to use R & maybe even learning the statistics that didn't
quite soak in during my two stats classes).

Anyway, the short answer: "?Devices"

Choose a device, turn it on with a call like "png()", issue your
graphics commands & be sure to issue the dev.off() command when you're
done.  If you don't, your graphics file won't be complete (or might be
empty).

I hope this helps.

--
Jay Pfaffman                           pfaffman@relaxpc.com
+1-415-821-7507 (H)                    +1-415-810-2238 (M)
http://relax.ltc.vanderbilt.edu/~pfaffman/
-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

From MAILER-DAEMON Mon Apr 18 14:23:19 2022
Message-ID: <24102312.1075841472371.JavaMail.evans@thyme>
Date: Wed, 23 Jan 2002 09:07:37 -0800 (PST)
From: ripley@stats.ox.ac.uk
To: r-help@stat.math.ethz.ch
Subject: [R] Versions of R 1.4.0 for Windows
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Prof Brian Ripley <ripley@stats.ox.ac.uk>
X-To: R-help@stat.math.ethz.ch
X-cc: 
X-bcc: 
X-Folder: \ExMerge - Richey, Cooper\R
X-Origin: RICHEY-C
X-FileName: cooper richey 6-26-02.PST

We have removed from CRAN the seemingly faulty version of R 1.4.0 for
Windows and replaced it by the one I built on Dec 20 that is known to work
with grid and lattice.

I've built a SetupR-patched.exe today from the current R-patched sources
and with the latest versions of the recommended packages.  You might
prefer to change to that if you want to re-install: otherwise wait for
R 1.4.1 in a week or so.  As this is a snapshot, it is only minimally
tested.

These will propogate around CRAN in due course, but are available at
http://www.stats.ox.ac.uk/pub/RWin.

--
Brian D. Ripley,                  ripley@stats.ox.ac.uk
Professor of Applied Statistics,  http://www.stats.ox.ac.uk/~ripley/
University of Oxford,             Tel:  +44 1865 272861 (self)
1 South Parks Road,                     +44 1865 272860 (secr)
Oxford OX1 3TG, UK                Fax:  +44 1865 272595

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
r-help mailing list -- Read http://www.ci.tuwien.ac.at/~hornik/R/R-FAQ.html
Send "info", "help", or "[un]subscribe"
(in the "body", not the subject !)  To: r-help-request@stat.math.ethz.ch
_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._

