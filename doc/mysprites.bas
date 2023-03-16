10 print chr$(147)
20 print "generated with spritemate"
30 print "3 of 3 sprites displayed."
40 poke 53285,0: rem multicolor 1
50 poke 53286,1: rem multicolor 2
60 poke 53269,255 : rem set all 8 sprites visible
70 for x=12800 to 12800+191: read y: poke x,y: next x: rem sprite generation
80 :: rem arrowcard
90 poke 53287,5: rem color = 5
100 poke 2040,200: rem pointer
110 poke 53248, 44: rem x pos
120 poke 53249, 120: rem y pos
130 :: rem swords
140 poke 53288,15: rem color = 15
150 poke 2041,201: rem pointer
160 poke 53250, 92: rem x pos
170 poke 53251, 120: rem y pos
180 :: rem crosshair
190 poke 53289,15: rem color = 15
200 poke 2042,202: rem pointer
210 poke 53252, 140: rem x pos
220 poke 53253, 120: rem y pos
230 poke 53276, 7: rem multicolor
240 poke 53277, 0: rem width
250 poke 53271, 0: rem height
1000 :: rem arrowcard / multicolor / color: 5
1010 data 0,32,0,0,168,0,1,169,0,6,170,64,10,170,128,42
1020 data 170,160,42,170,160,7,171,64,7,171,64,7,171,64,7,171
1030 data 64,7,171,64,7,171,64,7,171,64,7,171,64,7,255,64
1040 data 5,85,64,7,255,64,5,221,64,7,255,64,1,85,0,133
1050 :: rem swords / multicolor / color: 15
1060 data 0,0,0,32,0,80,120,0,112,28,1,224,30,1,192,7
1070 data 7,128,7,135,0,1,222,0,1,220,0,0,120,0,0,112
1080 data 0,1,220,32,113,222,176,127,135,240,31,7,192,31,135,192
1090 data 31,222,224,56,220,112,48,0,112,0,0,0,0,0,0,143
1100 :: rem crosshair / multicolor / color: 15
1110 data 0,48,0,0,184,0,11,255,128,14,50,192,44,48,224,56
1120 data 48,176,50,254,48,51,187,48,51,51,48,179,51,56,255,207
1130 data 252,179,51,56,51,51,48,51,187,48,50,254,48,56,48,176
1140 data 44,48,224,14,50,192,11,255,128,0,184,0,0,48,0,143
