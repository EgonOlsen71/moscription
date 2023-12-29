0 rem Moscription by EgonOlsen71/2023
10 poke 53280,11:poke 53281,0:poke 646,1:poke 650,128:dn%=peek(186)
20 if lf%=0 then lf%=1:load "chars",dn%,1
25 if lf%=1 then lf%=21:load "copy",dn%,1
30 gosub 19900:gosub 59000:gosub 32000:gosub 33000
40 gosub 33500:gosub 33800:gosub 33850:gosub 58500:gosub 34000

900 rem
1000 fi%=rnd(1)*4:if pf%(fi%)<>-1 then 1000
1010 gosub 10000
1040 md%=0:gosub 33300:gosub 29000:gosub 47900
1045 mg$(9)="ai level:"+str$(al%+1):mg%=9:gosub 40000
1050 mg%=6:gosub 40000
1060 gosub 22000
1070 on md%+1 gosub 44400,45500,44500,47500,53000
1075 if md%=5 then 900
1080 goto 1060
9999 end

10000 rem init board pieces
10005 af%=1:gosub 51900
10010 pf%(fi%)=rs%:hp%(fi%)=cv%(rs%,2)
10020 return

19900 rem init sound routine
19910 dim vt%(2),vl(2),vw%(2):vc%=0:ac%=0
19920 si=54272: for i=si to si+24:poke i,0:next
19930 poke si+24,15:return

19999 rem play sound
20000 ic%=0:gosub 22000
20010 if vw%(vc%)=0 then 20100
20020 vc%=vc%+1:ic%=ic%+1
20030 if vc%=3 then vc%=0
20040 if ic%=3 then return
20050 goto 20010
20100 tt=ti:sb=si+vc%*7
20110 poke sb+5,at%*16+dd%
20120 poke sb+6,el%*16+rl%
20130 poke sb,lq%:poke sb+1,hq%
20140 vw%(vc%)=wf%:vl(vc%)=tt:poke si+24,15:poke sb+4,wf%+1
20150 pt%=pt%+pt%:vt%(vc%)=pt%:ac%=ac%+1
20160 if im%=0 then return
20170 tt=ti:if tt-vl(vc%)<pt% then 20170
20180 poke sb+4,wf%:vw%(vc%)=0:ac%=ac%-1
20190 vc%=vc%+1:if vc%=3 then vc%=0
20200 return

21999 rem check sound playback
22000 if ac%=0 then return
22005 ts=tt:tt=ti:if ts>tt then vw%(0)=0:vw%(1)=0:vw%(2)=0
22010 for hh=0 to 2:if vw%(hh)=0 or tt-vl(hh)<vt%(hh) then 22040
22020 poke si+hh*7+4,vw%(hh):vw%(hh)=0:ac%=ac%-1
22040 next:return

29000 rem render cards on play field
29010 gosub 29800:xc%=0:yc%=0:for ii=0 to 11
29020 cn%=pf%(ii):if cn%=-1 then 29050
29030 if yc%=0 then gosub 30800:goto 29050
29040 hp%=hp%(ii):gosub 30000
29050 xc%=xc%+7:if xc%>21 then xc%=0:yc%=yc%+4-4*(yc%=4)
29100 next:return
 
29800 rem clear play field
29810 print chr$(19);:poke 646,1:cx%=0:cy%=0
29820 for i=0 to 19:gosub 34500:cy%=cy%+1:print "{28*space}";:next
29830 return

30000 rem render full card frame,xc% and yc% populated
30001 rem card to render in cn%, hp% contains dynamic hitpoints..or -1. It will be reset after the call
30005 dc%=1
30010 if peek(53266)<100 then 30010
30020 gosub 31600:ss%=xc%+1+40*(yc%+6)
30150 pp=ss%+sa:poke pp,cv%(cn%,0)+48
30160 rem draw sign
30162 gosub 30700:if hp%=-1 then hp%=cv%(cn%,2)
30170 pp=pp+4:poke pp,hp%+48:hp%=-1
30180 pv%=28:pc%=cv%(cn%,3)
30190 if cv%(cn%,4)>0 then pv%=37:pc%=cv%(cn%,4):c%=dc%
30200 if pc%=0 then pc%=1:pv%=32
30210 pp=pp-199-pc%
30220 for pp=pp to pp+pc%-1
30230 poke pp,pv%:poke pp+ca,c%
30240 next
30250 pp=pp+77:pv%=cv%(cn%,5)
30260 poke pp,pv%:poke pp+1,pv%+1
30270 poke pp+40,pv%+2:poke pp+41,pv%+3
30280 pp=pp+120
30290 pv%=cv%(cn%,1)
30295 if pv%=0 then 30360
30300 poke pp,pv%+93-(pv%>13)
30320 poke pp+ca,dc%
30360 return

30700 rem select red/brown color
30710 c%=2-(7*(dc%<>1)):return

30800 rem render half card frame,xc% and yc% populated
30801 rem card to render in cn%
30810 gosub 31900
30820 ss%=xc%+1+40*(yc%+2)
30960 dc%=1:hp%=-1:gosub 30150
30970 return

31000 rem render outline
31010 poke ss%+sa,cc%
31020 ss%=ss%+xd%+yd%:if ss%=se% then return
31030 goto 31010

31600 rem render card's outline, color in dc%
31610 cx%=xc%:cy%=yc%:gosub 34500:poke 646,dc%
31620 gosub 31780:yi%=0
31630 cy%=cy%+1:gosub 34500:print "{98}     {98}";:yi%=yi%+1:if yi%<6 then 31630
31640 cy%=cy%-1:gosub 34500:gosub 31700
31650 cy%=cy%+2:if cy%<25 then gosub 34500:gosub 31750
31670 return

31700 rem card part 1
31710 print "{235}{99}{99}{99}{99}{99}{179}";:return

31750 rem card part 2
31760 print "{106}{99}{99}{99}{99}{99}{107}";:return

31780 rem card part 3
31790 print "{117}{99}{99}{99}{99}{99}{105}";:return

31900 rem render half card's outline
31910 cx%=xc%:cy%=yc%:gosub 34500:poke 646,1
31920 print "{98}     {98}";
31940 gosub 31990:gosub 31700
31950 gosub 31990:gosub 34500:print "{98}     {98}";
31960 gosub 31990:gosub 34500:gosub 31750
31970 return

31990 rem next segment
31992 cy%=cy%+1:gosub 34500:return

32000 rem init charset $e000/$cc00
32010 poke 56576,peek(56576) and 252
32020 poke 53272,56:poke 648,204
32030 sa=52224:ca=3072:print chr$(147);
32040 return

32100 rem clear half card
32110 cx%=xc%:cy%=yc%:poke 646,1:gosub 34500
32120 gosub 32200
32140 gosub 31990:gosub 32200
32150 gosub 31990:gosub 32200
32160 gosub 31990:gosub 32200
32170 return

32200 rem clear line
32210 print "       ";:return

33000 rem init structures
33005 i=rnd(0):print "shuffling...";
33010 dim cv%(21,5),rp%(21),ro%(21),cd%(9),ct%(9),ck%(1)
33015 dim cp%(100),pf%(11),hp%(11),rc%(90),ai%(3)
33020 cm%=0:s1%=0:s2%=0:al%=0:wn%=0:ww%=8
33030 read av%,sg%,hp%,ch%,cb%,im%
33040 if av%=-1 then 33100
33050 cv%(cm%,0)=av%:cv%(cm%,1)=sg%
33060 cv%(cm%,2)=hp%:cv%(cm%,3)=ch%
33070 cv%(cm%,4)=cb%:cv%(cm%,5)=im%
33080 cm%=cm%+1:goto 33030
33090 rem init vars
33100 hc%=0:bc%=0:ds%=0
33110 for i=0 to 100:cp%(i)=-1:next
33130 rem init random deck
33135 gosub 33600
33175 rem init play field
33180 gosub 33250
33200 gosub 57000:gosub 33400:return

33250 rem clear play field
33260 for i=0 to 11:pf%(i)=-1:hp%(i)=0:next
33270 return

33300 rem mix player pile
33310 pi%=pn%
33320 for i=0 to pi%*4: rem just some number of iterations...
33330 i2%=rnd(1)*pi%:i3%=rnd(1)*pi%
33340 i4%=cp%(i2%):cp%(i2%)=cp%(i3%):cp%(i3%)=i4%
33350 next:return

33400 rem init random pile
33410 rem 
33420 for i=0 to 5:gosub 57200:cp%(i)=rs%:next
33430 pn%=i:pi%=pn%:return

33500 rem init messages and stuff...
33510 ii%=0:dim mg$(10)
33520 read a$:if a$="/" then return
33530 mg$(ii%)=a$:ii%=ii%+1:goto 33520

33600 rem create start deck
33605 for i=0 to 9:cd%(i)=-1:next
33610 cd%(0)=0
33620 cd%(1)=1:rem 2
33630 return

33800 rem init fade colors
33810 dim fc%(5):for i=0 to 5
33820 read a%:fc%(i)=a%:next
33830 return

33850 rem init score bars
33860 dim sb%(5):for i=0 to 5
33870 read a%:sb%(i)=a%:next
33880 return

34000 rem render field
34010 yd%=0:xd%=1:ss%=20*40:se%=ss%+28:cc%=67
34020 gosub 31000:poke ss%+sa,75:ss%=ss%-40
34030 yd%=-40:xd%=0:se%=-12:cc%=93:gosub 31000
34040 yd%=40:ss%=21*40+27:se%=ss%+4*40:gosub 31000
34050 poke 20*40+27+sa,114
34070 yd%=0:xd%=1:ss%=17*40+29:se%=ss%+11:cc%=67
34080 gosub 31000:poke (17*40+28)+sa,107
34090 gosub 46500:gosub 47600:return

34500 rem set cursor at cx%,cy%
34510 poke 781,cy%:poke 782,cx%:poke 783,0:sys 65520
34520 return

34600 rem clear right parts ss%=start row, se%=end row
34610 cx%=29:poke 646,1
34620 cy%=ss%:gosub 34500
34630 print "           ";:ss%=ss%+1
34640 if ss%>se% then return
34650 goto 34620

34700 rem clear upper right part
34710 ss%=0:se%=16:gosub 34600:return

34750 rem clear lower right part
34760 ss%=18:se%=23:gosub 34600
34770 poke sa+999,32:cx%=29:cy%=24:gosub 34500:print"          ";
34780 return

35000 rem render deck
35005 ii%=ci%
35010 yc%=ds%:xc%=33:c%=0:xd%=1:yd%=0
35015 if ii%<2 then return
35016 sf%=0:if cs%=ii%-1 then ii%=ii%-1:sf%=1
35020 cx%=xc%:cy%=yc%:yi%=0:poke 646,15
35030 gosub 34500:gosub 31780
35050 cy%=cy%+1:yi%=yi%+1:if yi%<ii% then 35030
35060 if ii%>9 then 35110
35070 gosub 34500:print "       ";:cy%=cy%+1
35080 yi%=yi%+1:if yi%<10 then 35070
35110 yi%=ii%-1:yc%=ds%+yi%:cn%=cd%(yi%):dc%=15:gosub 30010
35120 if sf%=1 then cx%=36:cy%=ds%+cs%+7:gosub 34500:print "    ";
35130 return

35500 rem render stacks
35510 gosub 34750: if ci%=10 then md%=1
35515 if md%>0 then return
35520 cn%=0:xc%=29:yc%=18:gosub 30000
35530 gosub 35900
35540 gosub 35800:gosub 35700
35570 return

35600 rem render numbers on playfield
35610 if md%<1 or md%>2 then return
35620 gosub 35850:cy%=12:i2%=0
35630 ii%=pf%(8+i2%):if ii%=-1 then 35650
35640 cx%=7*i2%:cx%=cx%+1:gosub 34500:print right$(str$(i2%+1),1)
35650 i2%=i2%+1:if i2%=4 then return
35660 goto 35630

35670 rem clear numbers on playfield
35675 poke 646,1
35680 cy%=12:for i=0 to 3:if pf%(8+i)<>-1 then cx%=7*i:cx%=cx%+1:gosub 34500:print"{99}"
35685 next:return

35700 rem render numbers on stack
35702 if md%>0 then return
35705 gosub 35850
35710 cx%=30:cy%=18:gosub 34500:print "1"
35720 if pi%=0 then 35740
35730 cx%=37:gosub 34500:print "2"
35740 return

35800 rem reset event timer
35810 lt%=0:lt=ti:return

35850 rem process event timer
35860 poke 646,fc%(lt%):if ti-lt>20 then lt%=lt%+1:lt=ti:if lt%>5 then lt%=0
35870 return

35900 rem render right stack part
35905 if pi%=0 then return
35910 cx%=36:cy%=18:gosub 34500
35920 print "{117}{99}{99}{99}";
35930 for i=19 to 23:cy%=i:gosub 34500:print "{98}{rvson}{230}{230}{230}{rvsoff}";:next
35940 cy%=24:gosub 34500:print "{98}{rvson}{230}{230}{rvsoff}";:poke sa+999,peek(sa+998)
35950 ii%=pi%:if ii%>99 then ii%=99
35960 cx%=37:cy%=24:gosub 34500:poke 646,3
35965 nn%=ii%:gosub 53100:print nn$;:poke 646,1
35970 return

36000 rem wait for a key press
36020 get a$:gosub 22000:if a$="" then 36040
36022 ky%=asc(a$)
36025 if ky%=72 then gosub 54000: rem help
36026 if ky%=73 then gosub 51100: rem info
36030 if ky%=13 then a$=" "
36031 if ky%=157 then a$="a"
36032 if ky%=29 then a$="d"
36033 if ky%=145 then a$="w"
36034 if ky%=17 then a$="s"
36040 return

36080 rem clear key buffer
36090 poke 198,0:return

36100 rem select card from deck
36110 gosub 38000:cs%=-1
36130 cs%=0:goto 36200
36140 gosub 36080:so%=cs%:if md%>=2 then return
36145 gosub 36000:gosub 35600:gosub 35700:if a$="" then 36145
36150 gosub 45000:gosub 38500
36170 if cs%=ci% then cs%=0
36180 if cs%=-1 then cs%=ci%-1
36185 if so%=cs% and ci%>0 then 36230
36190 tc%=so%:gosub 37000
36200 if ci%=0 then 36230 
36210 xc%=29:yc%=ds%+cs%:cn%=cd%(cs%):gosub 30000
36215 if cs%=ci%-1 then 36230
36220 gosub 36500
36230 goto 36140

36500 rem clear line right of card
36520 cx%=36:cy%=ds%+cs%:gosub 34500:print "   ";:cc%=32
36525 if cs%>0 then cc%=93
36526 cy%=cy%*40:poke 39+cy%+sa,cc%:return

37000 rem clear selected card, tc% = card to clear
37005 cx%=29
37010 cy%=ds%+tc%:poke 646,1:ii%=0
37020 gosub 34500:cy%=cy%+1
37030 print "       ";
37040 ii%=ii%+1:gosub 22000:if ii%<8 then 37020
37050 gosub 35000:return

38000 rem sort and tidy deck
38010 ci%=0:for i=0 to 9:ii%=i
38020 if cd%(ii%)=-1 then 38040
38025 ct%(ci%)=cd%(ii%)
38030 cd%(ii%)=-1:ci%=ci%+1
38040 gosub 22000:next
38050 for i=0 to 9:ii%=i
38060 if i>=ci% then cd%(ii%)=-1:goto 38080
38070 cd%(ii%)=ct%(ii%)
38080 gosub 22000:next:return

38500 rem evaluate keypress during selection
38510 if ci%=0 then 38535
38520 if a$="s" then gosub 50900:cs%=cs%+1
38530 if a$="w" then gosub 50900:cs%=cs%-1
38535 if md%=1 then if a$="x" or a$="q" then gosub 35670:gosub 47010:md%=3:return
38540 if md%=0 then gosub 39000:return
38550 if md%=1 then gosub 39500:return
38560 return

39000 rem evaluate keypresses in mode 0
39010 if a$=" " or a$="a" or a$="x" or a$="q" then mg%=0: gosub 40000
39020 if a$="2" then if pi%>0 then gosub 40500:gosub 39100
39030 if a$="1" then gosub 41000:gosub 39100
39035 rem if a$="k" then gosub 61000: rem todo debug, remove
39040 return

39100 rem some gosubs...
39110 gosub 40700:gosub 50900:gosub 57280:md%=1:return

39500 rem evaluate keypresses in mode 1
39510 if a$=" " or a$="a" then gosub 44000
39520 return
 
40000 rem render toast (1 sec.)
40010 wt%=1:gosub 40100:return
 
40100 rem render toast
40110 sys 1024
40120 poke 646,10:a$=mg$(mg%)
40130 cy%=0:cx%=0:gosub 34500:print "{80*space}";
40160 cx%=20-len(a$)/2:gosub 34500
40170 print a$:gosub 40300
40180 sys 1027
40190 return

40300 rem wait for wt% seconds (or keypress)
40310 gosub 36080: ts=ti :gosub 50000
40315 wt%=wt%*60:poke 198,0
40320 if ti-ts>wt% then return
40330 get a$:if a$<>"" then return
40340 gosub 22000:goto 40320

40500 rem deal card from right stack
40510 rem
40520 pi%=pi%-1:cn%=cp%(pi%):
40530 gosub 34750
40540 gosub 40800
40550 cd%(ci%)=cn%
40560 cs%=ci%:gosub 38000:return
 
40700 rem draw single card deck if needed
40710 if ci%<>1 then return
40720 xc%=29:yc%=ds%:cn%=cd%(0):gosub 30000
40730 return
 
40800 rem range check
40810 if ci%>9 then 57300
40820 return
 
41000 rem deal card from left stack 
41010 gosub 34750:gosub 40800:cd%(ci%)=0
41020 cs%=ci%:gosub 38000:return
 
44000 rem handle card selection 
44010 gosub 50900:md%=2:dc%=5:gosub 30010
44020 sl%=0:poke 53249,203:gosub 44200
44030 poke 53269,1:return

44200 rem place card sprite, slot in sl%
44210 poke 53248,41+(56*sl%):return

44400 rem card selection
44405 hc%=0:gosub 46500:gosub 38000:gosub 34700
44410 gosub 35000:gosub 35500
44420 gosub 36100:return 

44500 rem choose card slot
44505 gosub 57350:gosub 36080
44510 gosub 36000:gosub 35600
44515 gosub 45000
44520 if a$="a" then gosub 50700:sl%=sl%-1
44530 if a$="d" then gosub 50700:sl%=sl%+1
44540 if sl%<0 then sl%=3
44550 if sl%>3 then sl%=0
44560 gosub 44200
44570 if a$="s" then gosub 50900:md%=1
44580 if a$=" " or a$="w" then gosub 50700:gosub 45600
44590 if md%<>2 then poke 53269,0:gosub 57280:return
44600 goto 44510

45000 rem check for card flip
45005 if md%=0 then return
45010 if a$>"0" then if a$<"5" then fs%=val(a$):gosub 46000
45020 return 
 
45500 rem back to selection (mode 1)
45510 xc%=29:yc%=ds%+cs%:gosub 30000
45520 gosub 36140:return

45600 rem place card (if possible)
45610 sd%=sl%+8:if pf%(sd%)>-1 then gosub 50000:return
45615 gosub 46800:if ii%=1 then return
45620 cn%=cd%(cs%):cd%(cs%)=-1:md%=1:gosub 38000
45630 gosub 47000:pf%(sd%)=cn%:hp%(sd%)=cv%(cn%,2):xc%=sl%*7:yc%=12:dc%=1:gosub 30000
45640 if ci%=0 then gosub 35670:md%=3
45660 cs%=0:tc%=cs%:gosub 34700: gosub 37000
45670 gosub 36500:cn%=cd%(0):return
 
46000 rem flip card in slot fs%
46010 ii% = pf%(fs%+7):if ii%=-1 then return
46020 gosub 50550:if ii%<0 then ii%=ii%+1000:dr%=-1:goto 46050
46030 ii%=ii%-1000:dr%=1
46050 pf%(fs%+7)=ii%:tx%=xc%:ty%=yc%:tn%=cn%
46060 xc%=(fs%-1)*7:yc%=12:if ii%<0 then gosub 46200:goto 46080
46070 cn%=ii%:hp%=hp%(fs%+7):gosub 30000
46080 gosub 46400:xc%=tx%:yc%=ty%:cn%=tn%:return

46200 rem render backside of card
46210 poke 646,1:cx%=xc%:cy%=yc%
46220 gosub 34500: gosub 31780
46230 for i=0 to 5:cy%=cy%+1:gosub 34500
46240 print "{98}{rvson}{230}{230}{230}{230}{230}{rvsoff}{98}";
46250 next
46260 cy%=cy%+1: gosub 34500
46270 gosub 31750
46280 return

46400 rem calculate amount of blood for turned card
46405 ir%=pf%(fs%+7)
46410 if ir%<0 then as%=cv%(ir%+1000, 1):da%=1:gosub 49360: gosub 49370:goto 46430
46420 da%=-1:as%=cv%(ir%, 1):gosub 49360: gosub 49370:if hc%<0 then hc%=0
46430 if hc%>9 then hc%=9
46435 if bc%>9 then bc%=9
46440 cy%=15:cx%=((fs%-1)*7)+3:gosub 46570
46450 return

46500 rem display amount of bones and blood
46510 poke 646,1
46530 cx%=0:cy%=22:gosub 34500:nn%=bc%:gosub 53100:print"{37}:"nn$;" "
46540 cx%=0:cy%=23:gosub 34500:poke 646,2:print"{92}";:poke 646,1
46545 nn%=hc%:gosub 53100:print":"nn$;" "
46550 return

46570 rem render both, blood and bones animation
46572 vx%=cx%:vy%=cy%
46575 c%=2:gosub 46600:gosub 46540:cx%=vx%:cy%=vy%:c%=1:gosub 46600:gosub 46500:return

46600 rem render blood/bones animation, direction in dr%
46610 dz%=dc%:xs%=cx%:ys%=cy%:xe%=2:ii%=(c%=2):ye%=22-ii%:pv%=37+9*ii%
46615 if dr%=-1 then ii%=xs%:xs%=xe%:xe%=ii%:ii%=ys%:ys%=ye%:ye%=ii%
46620 dx=xe%-xs%:dy=ye%-ys%
46630 if abs(dx)>abs(dy) then dy=dy/abs(dx):dx=sgn(dx):goto 46645
46640 dx=dx/abs(dy):dy=sgn(dy)
46645 i2=xs%:i3=ys%
46650 pp=int(i2)+40*int(i3)+sa
46655 ch%=peek(pp):dc%=peek(pp+ca)
46660 poke pp,pv%:poke pp+ca,c%
46670 i2=i2+dx:i3=i3+dy
46672 ts=ti:gosub 22000
46674 if ti=ts then 46674
46680 poke pp,ch%:poke pp+ca,dc%
46690 if int(i2+.5)=xe% then if int(i3+.5)=ye% then dc%=dz%:return
46700 goto 46650

46800 rem check if enough blood or bones are available, result in ii%
46810 ii%=0:i2%=cv%(cn%,3):if i2%=0 then 46850
46820 if hc%<i2% then ii%=1:mg%=1:gosub 50000:gosub 40000
46830 return 
46850 i2%=cv%(cn%,4):if i2%=0 then return
46860 if bc%<i2% then ii%=1:mg%=2:gosub 50000:gosub 40000
46870 return
 
47000 rem clean deck after card being placed, calc. new bones/blood values
47005 hc%=hc%-cv%(cn%,3):bc%=bc%-cv%(cn%,4)
47010 for ii=8 to 11:if pf%(ii)>=-1 then 47050
47040 gosub 46500:cy%=12:cx%=7*(ii-8):gosub 47200:pf%(ii)=-1
47050 next:gosub 46500:return

47200 rem clear card from play field
47210 poke 646,1
47230 for p=0 to 7:gosub 34500:cy%=cy%+1
47240 print "{7*space}";:next
47250 return

47300 rem clear card from play field with animation
47310 poke 646,1
47330 for p=0 to 7:gosub 34500
47340 if p<7 then gosub 31780
47345 ts=ti
47346 if ti-ts<=2 then gosub 22000:goto 47346
47350 gosub 34500:print "{7*space}":cy%=cy%+1:next
47360 return

47400 rem game won from wn% (1=player, 2=ai)
47410 md%=4:cs%=0:ci%=0
47420 if wn%=1 then al%=al%+1
47430 gosub 47900:if wn%=2 then return
47432 ck%(0)=-1:ck%(1)=-1:ii%=0
47435 for i=0 to 7:cc%=pf%(i):if cc%<1 then 47455
47440 if ii%<2 then ck%(ii%)=cc%:ii%=ii%+1:goto 47455
47445 for p=0 to 1:if cv%(ck%(p),0)<cv%(cc%,0) then ck%(p)=cc%:p=ii%:next
47455 next:if ii%>1 then 47470
47460 for i=ii% to 1:gosub 57200:ck%(i)=rs%:next
47470 return

47500 rem md%=3, fight
47505 gosub 57250:mg%=3:gosub 40000
47510 rw%=1:dr%=-1:gosub 48000
47520 s1%=s1%+ov%:cc%=5:gosub 47800:if wn%<>0 then gosub 47400:return
47530 rw%=0:dr%=1:gosub 48000
47535 ur%=ur%+1:if ov%>0 then ur%=0
47540 s2%=s2%+ov%:cc%=2:gosub 47800:if wn%<>0 then gosub 47400:return
47550 gosub 58000:gosub 49550:gosub 52000:md%=0:cs%=0:ci%=0:return
 
47600 rem draw score
47610 cy%=24:cx%=13
47620 gosub 57400:return

47700 rem show ov% in color cc%
47705 if ov%=0 then 47730
47710 p2%=peek(646):cx%=13:cy%=24:gosub 34500:poke 646,cc%:print right$(str$(ov%),1);
47720 wt%=1:gosub 40300:poke 646,p2%
47730 gosub 47600:return
 
47800 rem check for winner and print score
47810 ii%=s1%-s2%:if (ii%>=ww%) or (s1%>40) then wn%=1:goto 47830
47820 if (ii%<=-ww%) or (s2%>40) then wn%=2
47830 gosub 47700:if tp%>0 then return
47832 if ur%>4 then 47840
47835 for i=0 to 7:if pf%(i)>-1 then if cv%(pf%(i),0)>0 then return
47836 next
47840 wn%=1:mg%=8:gosub 40000:return

47900 rem set ai skill flags
47905 if al%>10 then 47930
47910 a%=al%*3:tp%=sk%(a%):fq=sk%(a%+1)/10:hf%=sk%(a%+2)
47920 return
47930 tp%=tp%+3:hf%=2:return
 
48000 rem battle, row in rw% (0 or 1), direction in dr% (-1 or 1), returns overkill in ov%
48010 i2%=rw%*4:i2%=i2%+4:i3%=i2%+3:rem row start and end
48015 ov%=0:i4%=i2%+4*dr%:i5%=i3%+4*dr%:rem attack row start and end
48020 cn%=pf%(i2%):hh%=hp%(i2%):if cn%=-1 then 48210
48022 av%=cv%(cn%,0):sg%=cv%(cn%,1):ib%=i2%+4*dr%: rem ib%=card to attack 
48025 if av%=0 then 48210: rem no attack value, no attack
48030 p0%=ib%:p1%=ib%:p2%=0:rem start, end, step
48040 if sg%=7 then p0%=p0%-1:p1%=p1%+1:p2%=2:rem dual strike
48050 if sg%=8 then p0%=p0%-1:p1%=p1%+1:p2%=1:rem tripple strike
48060 if p0%<i4% then p0%=p0%+p2%
48070 if p1%>i5% then p1%=p1%-p2%
48080 ib%=p0%:io%=ib%
48090 cb%=pf%(ib%):hp%=hp%(ib%)
48100 gosub 50200:if cb%=-1 then ov%=ov%+av%:goto 48200
48110 as%=cv%(cb%,1):tv%=av%:gosub 49500:gosub 49900:hp%=hp%-av%:av%=tv%
48120 if hp%<=0 then gosub 49000:ov%=ov%-hp%:goto 48200
48130 hp%(ib%)=hp%:gosub 49300:cn%=cb%:if av%<>0 then gosub 49470
48200 ib%=ib%+p2%:if ib%<>io% and ib%<=p1% and hh%>0 then 48090
48210 i2%=i2%+1:if i2%<=i3% then 48020
48215 if ov%>9 then ov%=9
48220 return

48300 rem render bones for card that died in battle
48310 c%=1:gosub 49300:cx%=cx%+3:cy%=15:dr%=1:da%=1:gosub 46600:gosub 49400
48320 return

48400 rem choose card after winning
48410 if pn%>=99 or wn%<>1 then return
48420 gosub 29800:xc%=7
48440 for ii=0 to 1:cn%=ck%(ii):hp%=-1:yc%=4:gosub 30000
48450 xc%=xc%+7:next:mg%=7:gosub 40000
48460 gosub 35850
48470 cx%=8:cy%=4:gosub 34500:print "1"
48480 cx%=15:gosub 34500:print "2"
48490 gosub 36000:if a$<"1" or a$>"2" then 48460
48500 gosub 50900:ii%=val(a$)-1:cp%(pn%)=ck%(ii%):pn%=pn%+1
48510 cy%=4:cx%=7+7*ii%:gosub 47300:return

49000 rem player's card killed by attack
49020 if dr%=1 then gosub 48300
49030 gosub 49300:gosub 50600:gosub 47300
49040 pf%(ib%)=-1:return

49300 rem calculate cx%, cy% based on array index (ib%)
49310 cx%=(ib%-4*int(ib%/4))*7:cy%=4*dr%:cy%=cy%+8:return

49330 rem calculate cx%, cy% based on array index (ib%) for shifting sign
49340 gosub 49300:cy%=4:if ib%>7 then cy%=12
49345 return

49350 rem calculate cx%, cy% based on array index (i2%)
49355 dr%=-dr%:it%=ib%:ib%=i2%:gosub 49300:ib%=it%:dr%=-dr%:return
 
49360 rem add/sub blood (based on da%)
49365 if as%=13 then hc%=hc%+3*da%:return
49368 hc%=hc%+da%:return 
 
49370 rem add/sub bones (based on da%)
49375 if as%=14 then bc%=bc%+3*da%:return
49380 bc%=bc%+da%:return
 
49400 rem add bones for dead card
49410 gosub 49370:gosub 46500:return

49450 rem dummy call for passive signs
49460 return

49470 rem assign coords and render card
49480 xc%=cx%:yc%=cy%:x1%=cx%:y1%=cy%:gosub 30010:cy%=y1%:cx%=x1%:return
 
49500 rem check signs at attack time
49510 on as% gosub 49600,49450,49650,49700,49750,49800,49450,49450,49850
49520 return

49550 rem check signs after attack
49555 p0=4:p1=7:gosub 49560:p0=8:p1=11:gosub 49560:return
49559 rem ...
49560 for ic=p0 to p1:ph%=pf%(ic):if ph%=-1 then 49570
49565 as%=cv%(ph%,1)
49566 if as%>9 then on as%-9 gosub 51500, 51600
49570 next:return

49600 rem process pitchfork sign
49605 hh%=hh%-1:hp%(i2%)=hh%:p3%=cx%:p4%=cy%
49610 gosub 49350:if hh%>0 then 49615
49612 pf%(i2%)=-1:if dr%=-1 then gosub 48300:dr%=-1:gosub 49350
49613 gosub 50600:gosub 47300:goto 49630
49615 it%=hp%:hp%=hh%:dc%=2:gosub 49470:wt%=1
49620 gosub 40300:hp%=hh%:dc%=1:gosub 49470:hp%=it%
49630 cx%=p3%:cy%=p4%:return

49650 rem process gift sign
49655 if hp%-av%>0 then return
49660 it%=rnd(1)*cm%:av%=0:cn%=it%
49665 pf%(ib%)=it%:hp%=cv%(it%,2):hp%(ib%)=hp%
49670 gosub 50900:gosub 49300:dc%=1:gosub 49470
49675 hp%=hp%(ib%)
49680 cb%=cn%
49690 return

49700 rem process weak sign
49710 av%=av%-1:return 

49750 rem process wings sign
49760 if sg%=6 then gosub 50500:ov%=ov%+av%:av%=0
49765 return

49800 rem process ocean sign
49810 if sg%=5 then gosub 50400:ov%=ov%+av%:av%=0
49815 return

49850 rem process recycle
49852 if dr%=-1 then return
49855 if hp%-av%>0 or pi%>=99 then return
49860 it%=pi%*rnd(1):i4%=cp%(it%):cp%(it%)=cb%:cp%(pi%)=i4%:pi%=pi%+1
49865 gosub 50900:return
 
49900 rem process death
49905 if sg%<>12 or cb%=-1 then return
49910 if dr%=-1 then it%=ib%:ib%=i2%:dr%=1:gosub 48300:dr%=-1:ib%=it% 
49915 po%=pf%(i2%):pf%(i2%)=-1:gosub 49350:gosub 50600:if po%<>-1 then gosub 47300
49920 return
 
50000 rem play *mooop* sound
50010 at%=4:dd%=4:el%=12:rl%=3:lq%=180:hq%=12
50020 wf%=16:pt%=8:im%=0:gosub 20000:return

50200 rem play attack sound and animation
50210 gosub 49350:cy%=8+4*-dr%
50220 gosub 50350:xc%=xt%:yc%=yt%
50230 poke 53250,xc%:poke 53251,yc%
50240 poke 53286,7:poke 53269,2
50250 gosub 49300:gosub 50350
50260 dx=(xt%-xc%)/abs(yt%-yc%):xc=xc%
50270 gosub 50850:yi%=yc%
50280 poke 53250,xc:poke 53251,yi%
50285 gosub 51000:gosub 22000
50290 xc=xc+dx:if yi%<>yt% then yi%=yi%+dr%:goto 50280
50300 poke 53269,0:poke 53286,1:return

50350 rem calculate anim coords
50360 xt%=8*(cx%+3)+20:yt%=8*(cy%+4)+30
50370 return

50400 rem play water sound
50410 at%=1:dd%=1:el%=0:rl%=0:lq%=100:hq%=8
50420 wf%=16:pt%=5:im%=0:gosub 20000:at%=3:hq%=9:goto 20000

50500 rem play air sound
50510 at%=10:dd%=1:el%=10:rl%=10:lq%=100:hq%=8
50520 wf%=128:pt%=2:im%=1:goto 20000

50550 rem play flip sound
50560 at%=12:dd%=15:el%=0:rl%=0:lq%=100:hq%=2
50570 wf%=128:pt%=2:im%=0:goto 20000

50600 rem play death sound
50610 at%=2:dd%=5:el%=15:rl%=8:lq%=100:hq%=5
50620 wf%=32:pt%=2:im%=1:goto 20000

50700 rem play beep sound
50710 at%=2:dd%=2:el%=2:rl%=2:lq%=100:hq%=12
50720 wf%=16:pt%=2:im%=1:goto 20000

50800 rem play recycle sound
50810 at%=2:dd%=15:el%=3:rl%=6:lq%=100:hq%=6
50820 wf%=128:pt%=5:im%=0:goto 20000

50850 rem play attack sound
50860 at%=9:dd%=6:el%=2:rl%=2:lq%=100:hq%=13
50870 wf%=128:pt%=4:im%=0:goto 20000

50900 rem play card sound
50910 at%=12:dd%=5:el%=2:rl%=3:lq%=100:hq%=7
50920 wf%=128:pt%=3:im%=0:goto 20000

50950 rem game over
50952 at%=7:dc%=7:el%=0:rl%=0:lq%=180:hq%=6
50954 wf%=16:pt%=20:im%=0:gosub 20000
50956 at%=8:dc%=3:el%=0:rl%=0:lq%=180:hq%=8
50958 wf%=16:pt%=25:im%=0:gosub 20000
50960 at%=9:dc%=3:el%=0:rl%=0:lq%=180:hq%=7
50962 wf%=16:pt%=34:im%=0:goto 20000

51000 rem short delay
51010 if peek(53266)>100 then 51010
51020 return

51100 rem system information
51110 mg$(10)="compiled with mospeed,"+str$(fre(0))+" bytes free!"
51120 mg%=10:goto 40000

51500 rem push right
51510 dr%=1:gosub 51700:return

51600 rem push left
51610 dr%=-1:gosub 51700:return

51700 rem push direction in dr% (1,-1), card pos in ic, might be modified in here...
51710 i4=int(ic/4)*4-3*(dr%=1)
51720 if ic=i4 then return
51730 i2=-1:for i3=ic to i4 step dr%
51740 if pf%(i3)=-1 then i2=i3:i3=i4+dr%
51750 next
51760 if i2=-1 then return
51770 for i3=i2 to ic+dr% step -dr%:ib%=i3
51780 pf%(ib%)=pf%(ib%-dr%):hp%(ib%)=hp%(ib%-dr%)
51785 if pf%(ib%)=-1 then 51810
51790 ib%=ib%-dr%:gosub 49330:gosub 47200
51800 ib%=i3:gosub 49330:xc%=cx%:yc%=cy%:hp%=hp%(ib%):cn%=pf%(ib%):gosub 30000
51810 next:ib%=ic:gosub 49330:gosub 47200:pf%(ib%)=-1
51820 if dr%=1 then ic=i2+1
51830 return

51900 rem "damped" ai card selection
51910 gosub 57200:sc%=rs%
51915 if af%=1 then gosub 57200:if rs%>sc% then rs%=sc%
51918 if af%=2 then gosub 57200:if rs%<sc% then rs%=sc%
51920 return

52000 rem ai move
52001 ii=0:for i=0 to 7:pf%=pf%(i):if pf%>-1 then ii=ii+cv%(pf%,0)
52002 next:if ii>0 then if (tp%<=0) or (rnd(1)>fq) then return
52005 af%=hf%:gosub 51900:cn%=rs%
52010 for i=0 to 3:ai%(i)=-1:next
52020 for i=0 to 3:ev%=-1:if pf%(i)<>-1 then 52100
52030 ev%=0:ii%=i:ii%=ii%+4:if pf%(ii%)=-1 then ev%=ev%+5: rem next field empty, +5
52040 ii%=ii%+4:if pf%(ii%)=-1 then ev%=ev%+5:goto 52100: rem opponent's field empty, +5
52050 i2%=cv%(cn%,0)*2+cv%(cn%,2):i3%=cv%(pf%(ii%),0)*2+cv%(pf%(ii%),2)
52060 i3%=i3%-i2%:ev%=ev%+i3%
52100 ai%(i)=ev%:next
52110 mx%=-32000:i2%=-1:for i=0 to 3:if ai%(i)=-1 then 52150
52120 if ai%(i)>mx% then mx%=ai%(i):i2%=i
52150 next
52160 if i2%=-1 then return
52170 pf%(i2%)=cn%:hp%(i2%)=cv%(cn%,2):yc%=0:xc%=i2%*7:gosub 30800
52180 tp%=tp%-1:return

53000 rem end of game
53010 poke 53269,0
53015 mg%=wn%+3:wt%=3:gosub 50950:gosub 40100:gosub 48400
53020 s1%=0:s2%=0
53025 ov%=0:hc%=0
53030 bc%=0:ds%=0
53040 cs%=0:so%=0:wn%=0
53050 md%=5:gosub 33600:gosub 33250
53060 gosub 34700:gosub 34750:gosub 47600:return

53100 rem convert number (nn%) into string (nn$)
53110 nn$=mid$(str$(nn%),2):return

54000 rem show help file
54010 sys 1024:poke 646,7:gz%=peek(53269):poke 53269,0
54020 ox%=cx%:oy%=cy%:for f=0 to 7
54030 print chr$(147);:cy%=0:cx%=0
54040 nn%=f:gosub 53100:open 2,8,2,"help"+nn$+".hlp,s,r"
54050 input#2,li$:if li$="***" then close 2:goto 54100
54060 if left$(li$,1)="%" then li$=chr$(val(mid$(li$,2,3)))+mid$(li$,5)
54070 gosub 34500:print li$;:cy%=cy%+1
54080 goto 54050
54100 cx%=1:cy%=24:gosub 34500
54110 print "c to continue, x to exit, 1-8 for page";
54120 get a$:if a$="x" then 54300
54125 if a$>"0" then if a$<"9" then f=val(a$)-2:a$="c"
54130 if a$="c" then next: goto 54300
54140 goto 54120
54300 sys 1027:poke 53269,gz%:a$="":cx%=ox%:cy%=oy%:return

57000 rem setup card values and evaluation structures
57010 rr%=1:rp%(0)=-1:mi%=32000:mx%=-32000:for i=1 to cm%-1
57020 ii%=cv%(i,0)*2+cv%(i,2)-5*(cv%(i,1)=3):if ii%<mi% then mi%=ii%
57025 if ii%>mx% then mx%=ii%
57030 rp%(rr%)=ii%:rr%=rr%+1
57040 next:mx%=1+mx%-mi%:i2%=0
57050 for i=1 to rr%-1:rp%(i)=rp%(i)-mi%:ro%(i)=mx%-rp%(i):i2%=i2%+ro%(i):next
57060 i4%=rr%:rr%=i2%:if rr%>90 then 57300
57070 i3%=0:for i=1 to i4%-1:ii%=ro%(i):for p=i3% to i3%+ii%-1:rc%(p)=i:next
57080 i3%=p:next
57090 if i3%<>rr% then 57300
57100 return

57200 rem select random card, based on "value"
57210 rs%=rc%(rnd(0)*rr%):return

57250 rem clear message box
57255 cy%=18:cx%=29:for i=0 to 5:gosub 34500
57260 print "{11*space}";:cy%=cy%+1
57270 next:return

57280 rem print "end turn"
57285 gosub 57250:cx%=29:cy%=19:gosub 34500
57290 print "{white}x:{light gray}end turn";
57292 cy%=20:gosub 34500:print "{white}s/w:{light gray}select";
57294 cy%=21:gosub 34500:print "{white}a/spc:{light gray}place";
57295 cy%=22:gosub 34500:print "{white}h:{light gray}help";
57296 return

57300 rem exit with error
57310 print "!!!":stop

57350 rem print "select slot"
57355 gosub 57250:cx%=29:cy%=19:gosub 34500
57360 print "{white}a/d:{light gray}select";
57362 cy%=20:gosub 34500:print "{white}w/spc:{light gray}place";
57364 cy%=21:gosub 34500:print "{white}s:{light gray}cancel";
57366 return

57400 rem print scoring, center in cx%, y in cy%,scores in s1%,s2%
57410 p=cx%+40*cy%+sa:pp=p:poke p,224:poke p+ca,1
57440 p1%=s1%/4:p2%=s1%-4*p1%:p=p+1:p3%=0
57450 if p1%>0 then p1%=p1%-1:poke p,224:gosub 57600:goto 57450
57460 if p2%>0 then poke p,sb%(p2%+2):gosub 57600
57465 if p3%<10 then for p=p to p+10-p3%:poke p,32:next  
57470 p=pp-1
57480 p1%=s2%/4:p2%=s2%-4*p1%:p3%=0
57490 if p1%>0 then p1%=p1%-1:poke p,224:gosub 57650:goto 57490
57500 if p2%>0 then poke p,sb%(p2%-1):gosub 57650
57510 if p3%<10 then for p=p to p-(10-p3%) step -1:poke p,32:next
57520 return

57600 rem bar part 1
57610 poke p+ca,5:p=p+1:p3%=p3%+1:return

57650 rem bar part 2
57660 poke p+ca,2:p=p-1:p3%=p3%+1:return

58000 rem scroll playfield down
58010 yi%=0
58015 cn%=pf%(yi%):if cn%=-1 then 58100
58020 ii%=yi%+4:cb%=pf%(ii%):if cb%<>-1 then 58100
58030 pf%(ii%)=pf%(yi%):hp%(ii%)=hp%(yi%):pf%(yi%)=-1
58040 yc%=0:xc%=yi%*7:gosub 32100
58050 yc%=4:hp%=hp%(ii%):gosub 30000
58100 yi%=yi%+1:if yi%<4 then 58015
58110 return

58500 rem init ai skill level settings
58510 dim sk%(32):for i=0 to 30 step 3 
58520 read a%,b%,c%:i%=i
58530 sk%(i%)=a%:sk%(i%+1)=b%:sk%(i%+2)=c%
58540 next:return

58999 rem init sprites
59000 poke 53285,11: rem multicolor 1
59010 poke 53286,1: rem multicolor 2
59020 poke 53269,0 : rem all sprites off
59030 for x=49152 to 49152+127: read y%: poke x,y%: next
59040 rem arrowcard
59050 poke 53287,5: rem color = 5
59060 poke 53240,0: rem pointer
59070 poke 53248, 97: rem x pos
59080 poke 53249, 100: rem y pos
59090 rem swords
59100 poke 53288,15: rem color = 15
59110 poke 53241,1: rem pointer
59120 poke 53250, 124: rem x pos
59130 poke 53251, 100: rem y pos
59190 poke 53276, 7: rem multicolor
59200 poke 53277, 0: rem width
59210 poke 53271, 0: rem height
59215 return
59220 rem arrowcard / multicolor / color: 5
59230 data 0,32,0,0,168,0,1,169,0,6,170,64,10,170,128,42
59240 data 170,160,42,170,160,7,171,64,7,171,64,7,171,64,7,171
59250 data 64,7,171,64,7,171,64,7,171,64,7,171,64,7,255,64
59260 data 5,85,64,7,255,64,5,221,64,7,255,64,1,85,0,133
59270 rem swords / multicolor / color: 15
59280 data 0,0,0,32,0,80,120,0,112,28,1,224,30,1,192,7
59290 data 7,128,7,135,0,1,222,0,1,220,0,0,120,0,0,112
59300 data 0,1,220,32,113,222,176,127,135,240,31,7,192,31,135,192
59310 data 31,222,224,56,220,112,48,0,112,0,0,0,0,0,0,143

59999 rem attack,sign,hitpoints,blood,bones,image
60010 data 0,0,1,0,0,124
60020 data 1,5,2,2,0,132
60030 data 0,3,1,4,0,136
60040 data 4,12,1,0,5,140
60050 data 2,1,2,0,3,128
60060 data 1,6,2,2,0,144
60070 data 3,6,3,0,4,148
60080 data 2,5,3,3,0,152
60090 data 3,7,3,4,0,156
60100 data 1,4,2,0,3,160
60110 data 2,8,3,4,0,164
60120 data 2,14,1,0,2,168
60130 data 1,6,4,3,0,172
60140 data 2,10,3,4,0,176
60150 data 1,9,1,0,2,180
60160 data 1,7,3,3,0,184
60170 data 1,12,2,0,3,188
60180 data 2,1,2,3,0,192
60190 data 0,13,5,0,4,196
60200 data 1,4,2,2,0,200
60210 data 3,11,2,4,0,204
60220 data 1,9,2,0,3,208
60230 data -1,0,0,0,0,0

61000 rem debug board setup
61010 rem pf%(8)=9:hp%(8)=2
61020 rem pf%(10)=1:hp%(10)=2:pf%(5)=15:hp%(5)=2
61030 rem xc%=7:yc%=4:cn%=pf%(5):hp%=-1:gosub 30000
61040 rem xc%=0:yc%=12:cn%=pf%(8):hp%=-1:gosub 30000
61050 rem xc%=14:yc%=12:cn%=pf%(10):hp%=-1:gosub 30000:return


62800 data "draw a new card first!"
62805 data "not enough blood!"
62810 data "not enough bones!"
62820 data "fight!"
62830 data "player wins!"
62840 data "computer wins!"
62850 data "get ready!"
62860 data "choose bonus card!"
62870 data "computer resigns!"
62899 data "/"

62900 rem fade colors
62910 data 2,10,7,1,7,10

62920 rem score bars
62930 data 59,39,38,34,35,36 

62940 rem ai levels: number of cards to play, frequency (*10), card 'quality' hack
62942 data 6,2,1
62944 data 6,3,1
62946 data 6,4,1
62948 data 8,4,1
62950 data 8,5,0
62952 data 10,6,0
62954 data 12,7,0
62956 data 14,7,0
62958 data 16,8,0
62960 data 20,9,0
62962 data 25,9,0

63000 rem cv%(i,v) - cards (cardnumber, attribute)
63002 rem cd%(i) - player's deck (max. 10 cards)
63004 rem ct%(i) - temp. array for sorting/stuffing the deck
63006 rem ci% - number of cards in deck
63007 rem cm% - number of card templates
63008 rem sa = screen address
63010 rem cs%, so% - currently selected and formerly selected card
63011 rem ds% - row of "deck start"
63012 rem i,ii,p, i2, i3, i4, ic - loop vars
63014 rem cn% - card to render
63016 rem xc%, yc% - position of card to render
63018 rem cx%, cy% - cursor position
63020 rem xd%, yd% - step values for rendering cols/rows
63022 rem ss%, se% - col/row start and end position (0 based)
63023 rem cc% - character to draw
63024 rem pv% - "poke value" for various pokes
63026 rem cp%(i) - card pile
63028 rem pi%, pn% - current and total number of cards on pile
63030 rem bc%, hc% - number of bones / blood drops
63034 rem ii%, i2%, i3%, i4%, i5%, p0%, p1%, p2%, p3%, p4%, io%, ib%, it%, ir%, x1%, y1%, dz% - temp. vars
63036 rem dc% - color to render the card in
63038 rem md% - mode, 0: draw card from stack, 1: select card, 2: place card
63040 rem mg% - message number
63042 rem mg$(i) - messages
63044 rem wt% - wait time in seconds
63046 rem ca - color ram delta (from sa)
63048 rem lt%,lt - event counter and time
63050 rem fc%(i) - fade colors
63052 rem ts - time store
63054 rem sl%, fs%, sd% - selected slot, slot to flip, slot pos in deck
63056 rem pf%(11), hp%(11), fi%, hp%, hh% - play field,hitpoints of cards on the board, field index, hitpoints to render, attacker's hp
63060 rem sf% - flag for rendering the deck regardless of size
63062 rem tx%,ty%,tn%,vx%,vy% - temp. vars to store xc%, yc% and cn%
63064 rem xs%,ys%,ye%,ys%,ch%,x%,y% - vars for animations
63065 rem pp - var for poke/peek adresses
63066 rem dr% - direction (of animation or battle)
63068 rem cb% - card to attack
63070 rem sg%, av% - sign and attack of attacking card
63072 rem as% - sign of attacked card
63074 rem ov% - overkill
63076 rem xt%, yt% - target coords for sprite animation
63078 rem dx, xy - deltas for animations
63080 rem da% - multiplier for bones/blood
63090 rem rp%(i), ro%(i) - "value" of each card and opposite value of that 
63100 rem rc%(p) - Array for randomly choosing a card
63110 rem rr%, rs% - number of entries in  rc%(p), randomly selected card
63120 rem ai%(i), ev% - evaluation of the slots, evaluation
63130 rem s1%,s2%, wn% - scores, winner
63140 rem al% - skill level of computer player
63150 rem sk%(32), tp%, fq, hf% - skill settings for ai, cards to play, frequency, hack flag
63160 rem ww% - min. difference in score to win
63170 rem ck%(1) - cards to select after player has won
63180 rem ur% - number of rounds in which the AI didn't deal any damage
63190 rem af%, sc% - if 1, the lesser valuable card will be taken, stored card
63200 rem vc$%, ic%, ac% - for sound system
63210 rem po% - old card on location
63220 rem tv% - temp. storage of av%