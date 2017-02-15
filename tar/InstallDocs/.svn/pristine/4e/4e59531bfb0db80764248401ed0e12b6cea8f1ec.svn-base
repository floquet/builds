-fastsse turns on a lot of stuff.  Probably only one of them is causing your troupble.  Let me find the list and you can go through it option at a time.

> -----Original Message-----
> From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> [mailto:Christopher.B.Borchert@usace.army.mil]
> Sent: Friday, February 13, 2009 8:34 AM
> To: Alan Minga
> Subject: RE: VASP with scaLAPACK
> 
> I just removed the fastsse for the gamma-point and scalapack builds.
It
> runs
> my sample code. I have the user testing it today with his inputs. His 
> complaint was how slow it ran compared to other systems. Without 
> fastsse it might not be all he hopes it to be. I tried to build with 
> PathScale
the
> other
> day -- that will take help from someone knowledgeable in Fortran, like 
> Hung.
> 
> Chris
> 
> -----Original Message-----
> From: Alan Minga [mailto:aminga@cray.com]
> Sent: Friday, February 13, 2009 8:28 AM
> To: Borchert, Christopher B ERDC-ITL-MS Contractor
> Subject: RE: VASP with scaLAPACK
> 
> OK,
> 
> Are there any compiler options that make it work?
> 
> > -----Original Message-----
> > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > [mailto:Christopher.B.Borchert@usace.army.mil]
> > Sent: Friday, February 13, 2009 8:25 AM
> > To: Alan Minga
> > Subject: RE: VASP with scaLAPACK
> >
> > I tried -Mfpmisalign and -fastsse and that still fails. That is the 
> > only Mfp*align item I find in the man page. Strange of all the codes 
> > I compile with -fastsse on jade, this was the first time I saw such 
> > an error.
> We
> > were
> > all entertained with figuring out how much memory it really
> requested.
> >
> > Chris
> >
> > -----Original Message-----
> > From: Alan Minga [mailto:aminga@cray.com]
> > Sent: Friday, February 13, 2009 8:10 AM
> > To: Borchert, Christopher B ERDC-ITL-MS Contractor
> > Subject: RE: VASP with scaLAPACK
> >
> > So what I meant to say is have you tried -Mfpmalign with fastsse?
> >
> > And the reason you may not see scalapack or sci in the output the 
> > compiler adds them automagically when you load a module.
> >
> > Try compiling with -v to see what it's really doing.
> >
> > > -----Original Message-----
> > > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > > [mailto:Christopher.B.Borchert@usace.army.mil]
> > > Sent: Thursday, February 12, 2009 4:44 PM
> > > To: Alan Minga
> > > Subject: RE: VASP with scaLAPACK
> > >
> > > I think its -Mfpmisalign, and no with -fastsse it still crashes.
> > >
> > > Thanks,
> > > Chris
> > >
> > > -----Original Message-----
> > > From: Alan Minga [mailto:aminga@cray.com]
> > > Sent: Thursday, February 12, 2009 4:29 PM
> > > To: Borchert, Christopher B ERDC-ITL-MS Contractor
> > > Subject: RE: VASP with scaLAPACK
> > >
> > > I think fastsse forces alignment on instruction set boundaries.
> Why
> > it
> > > doesn't set it I don't know but try (check my memory on this) -M 
> > > fpmemalign.
> > >
> > > > -----Original Message-----
> > > > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > > > [mailto:Christopher.B.Borchert@usace.army.mil]
> > > > Sent: Thursday, February 12, 2009 4:27 PM
> > > > To: Alan Minga
> > > > Subject: RE: VASP with scaLAPACK
> > > >
> > > > It appears to be the -fastsse (PGI) flag that is causing the
> memory
> > > > allocation error in VASP.
> > > >
> > > > Strangely, if I use "-g -O0" I get the same memory error unless
I
> > > > explicitly
> > > > add "-lsci".
> > > >
> > > > Chris
> > > >
> > > > -----Original Message-----
> > > > From: Alan Minga [mailto:aminga@cray.com]
> > > > Sent: Tuesday, February 10, 2009 2:02 PM
> > > > To: Borchert, Christopher B ERDC-ITL-MS Contractor
> > > > Subject: RE: VASP with scaLAPACK
> > > >
> > > > It was someone else.
> > > >
> > > > Have you run a simple profile on the guys code to see where it's 
> > > > spending it's time.
> > > >
> > > > > -----Original Message-----
> > > > > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > > > > [mailto:Christopher.B.Borchert@usace.army.mil]
> > > > > Sent: Tuesday, February 10, 2009 11:27 AM
> > > > > To: Alan Minga
> > > > > Subject: RE: VASP with scaLAPACK
> > > > >
> > > > > Alan,
> > > > > I don't find -DscaLAPACK in these Makefiles. So I don't think
> you
> > > > were
> > > > > using
> > > > > it either. :)
> > > > >
> > > > > Chris
> > > > >
> > > > > -----Original Message-----
> > > > > From: Alan Minga [mailto:aminga@cray.com]
> > > > > Sent: Tuesday, February 03, 2009 9:58 AM
> > > > > To: Borchert, Christopher B ERDC-ITL-MS Contractor
> > > > > Subject: RE: VASP with scaLAPACK
> > > > >
> > > > > Chris,
> > > > >
> > > > > We didn't see anything obviously wrong with your make files.
> So
> > > here
> > > > > are the ones that one of my collegues used to build VASP.
> Maybe
> > > you
> > > > > can
> > > > > see the difference.
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > > > > > [mailto:Christopher.B.Borchert@usace.army.mil]
> > > > > > Sent: Monday, February 02, 2009 10:56 AM
> > > > > > To: Alan Minga
> > > > > > Subject: RE: VASP with scaLAPACK
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alan Minga [mailto:aminga@cray.com]
> > > > > > Sent: Monday, February 02, 2009 10:50 AM
> > > > > > To: Borchert, Christopher B ERDC-ITL-MS Contractor
> > > > > > Subject: RE: VASP with scaLAPACK
> > > > > >
> > > > > > Send us your make file.
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Borchert, Christopher B ERDC-ITL-MS Contractor 
> > > > > > > [mailto:Christopher.B.Borchert@usace.army.mil]
> > > > > > > Sent: Monday, February 02, 2009 10:00 AM
> > > > > > > To: Alan Minga
> > > > > > > Subject: VASP with scaLAPACK
> > > > > > >
> > > > > > > Alan,
> > > > > > > I'm hoping you know someone with CNL who is wise on VASP.
> We
> > > have
> > > > a
> > > > > > > user that was complaining about VASP performance on jade
> > being
> > > > > > > terrible compared to other systems, like the Altix. So I
> > > noticed
> > > > > that
> > > > > > > our Makefile didn't include -DscaLAPACK. After a fresh
> build
> > > > > > (4.6.34),
> > > > > > > I find VASP dies
> > > > > > immediately
> > > > > > > (output below) after requesting ridiculous amounts of
> memory.
> > > > Maybe
> > > > > > you
> > > > > > > have
> > > > > > > some suggestions?
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Chris
> > > > > > >
> > > > > > >
> > > > > > > > aprun -n 64 /work/cots/src-vasp.4.6.34-mpi/vasp
> > > > > > >  running on   64 nodes
> > > > > > >  distr:  one band on   32 nodes,    2 groups
> > > > > > >  vasp.4.6.34 5Dec07 complex  POSCAR found :  1 types and  
> > > > > > > 729 ions  scaLAPACK will be
> > used
> > > > LDA
> > > > > > > part: xc-table for Ceperly-Alder, standard interpolation
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
-----------------------------------------------------------------------
> > > > > > > ------
> > > > > > > |
> > > > > > > |
> > > > > > > |           W    W    AA    RRRRR   N    N  II  N    N
> GGGG
> > > > !!!
> > > > > > > |
> > > > > > > |           W    W   A  A   R    R  NN   N  II  NN   N  G
> > G
> > > > !!!
> > > > > > > |
> > > > > > > |           W    W  A    A  R    R  N N  N  II  N N  N  G
> > > > !!!
> > > > > > > |
> > > > > > > |           W WW W  AAAAAA  RRRRR   N  N N  II  N  N N  G
> > GGG
> > > > !
> > > > > > > |
> > > > > > > |           WW  WW  A    A  R   R   N   NN  II  N   NN  G
> > G
> > > > > > > |
> > > > > > > |           W    W  A    A  R    R  N    N  II  N    N
> GGGG
> > > > !!!
> > > > > > > |
> > > > > > > |
> > > > > > > |
> > > > > > > |      VASP found   2184 degrees of freedom
> > > > > > > |
> > > > > > > |      the temperature will equal 2*E(kin)/ (degrees of
> > > freedom)
> > > > > > > |
> > > > > > > |      this differs from previous releases, where T was
> > > > 2*E(kin)/(3
> > > > > > > NIONS).
> > > > > > > |
> > > > > > > |      The new definition is more consistent
> > > > > > > |
> > > > > > > |
> > > > > > > |
> > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
-----------------------------------------------------------------------
> > > > > > > ------
> > > > > > >
> > > > > > >  POSCAR, INCAR and KPOINTS ok, starting setup
> > > > > > >  WARNING: wrap around errors must be expected
> > > > > > >  FFT: planning ...            3
> > > > > > >  reading WAVECAR
> > > > > > >  WARNING: random wavefunctions but no delay for mixing,
> > default
> > > > for
> > > > > > > NELMDL  prediction of wavefunctions initialized - no I/O
> > > > entering
> > > > > > > main loop
> > > > > > >        N       E                     dE             d eps
> > > > ncg
> > > > > > > rms
> > > > > > > rms(c)
> > > > > > > 0: ALLOCATE: 18446744071837617344 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837737152 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837884608 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837520576 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837580480 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837460672 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837539008 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837465280 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837603520 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837880000 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837732544 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837755584 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837709504 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837442240 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837488320 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837539008 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837520576 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837585088 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837589696 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837741760 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837520576 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837820096 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837654208 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837672640 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837668032 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837783232 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837893824 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837460672 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837880000 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837847744 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837815488 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837446848 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837539008 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837617344 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837875392 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837474496 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837866176 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837442240 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837801664 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837709504 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837359296 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837714112 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837497536 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837340864 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837382336 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837861568 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837700288 bytes requested; not
> enough
> > > > > memory
> > > > > > > 0: ALLOCATE: 18446744071837433024 bytes requested; not
> enough
> > > > > memory
> > > > > > > [NID 2369]Apid 533807: initiated application termination
> > > > > Application
> > > > > > > 533807 exit codes: 127 Application 533807 exit signals:
> > Killed
> > > > > > > Application 533807 resources: utime 76710, stime 4370

