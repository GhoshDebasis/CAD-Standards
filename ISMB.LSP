;;;  ISA.LSP, 04-05-1998, Rajagopalan SRINIVASAN, IBIL TECH LIMITED
;;;  Profile of Standard Beams acc. to ISMC 
;;;  Start with: ISMB

(defun dtor(a) (* pi (/ a 180.0)))
(defun rtod(b) (/ (* b 180.0) pi))

(defun ip_error(err)
 (if (/= err "Function cancelled")
    (princ (strcat "\nError: " err "\n\n"))
 )
 (setvar "pickbox" oldpick)
 (setvar "osmode" os)
 (setvar "cmdecho" 1)
 (setq *error* olderror)
 (princ)
)

(defun c:ISMB()

 (setq olderror *error*) 
 (setq *error* ip_error)
 (setq TR (getreal "\nISMB - "))
 (setq osm (getvar "osmode"))
 (setq oldpick (getvar "pickbox"))
 (setvar "pickbox" 0)
 (setvar "osmode" 0)
;*************
 (setq N nil)
 (if (= TR 100) (setq N 0))
 (if (= TR 125) (setq N 1))
 (if (= TR 150) (setq N 2))
 (if (= TR 175) (setq N 3))
 (if (= TR 200) (setq N 4))
 (if (= TR 225) (setq N 5))
 (if (= TR 250) (setq N 6))
 (if (= TR 300) (setq N 7))
 (if (= TR 350) (setq N 8))
 (if (= TR 400) (setq N 9))
 (if (= TR 450) (setq N 10))
 (if (= TR 500) (setq N 11))
 (if (= TR 550) (setq N 12))
 (if (= TR 600) (setq N 13))
;*************
 (if (= N nil)
 (alert "Profile not acc. to standard!")
 )
;************* 
 (if (/= N nil)
	(progn
	 (setq IP (getpoint "Insertionpoint : "))

	(setq H (nth N '(100 125 150 175 200 225 250 300 350 400 450 500 
	                 550 600)))
	(setq B (nth N '(70 70 75 85 100 110 125 140 140 140 150 180 190 210)))	
	(setq TF (nth N '(7.5 8.0 8.0 9.0 10.8 11.8 12.5 13.1 14.2 16.0 17.4
	                  17.2 19.3 20.8)))
	(setq TW (nth N '(4.5 5.0 5.0 5.8 5.7 6.5 6.9 7.7 8.1 8.9 9.4
	                  10.2 11.2 12.0)))
	(setq R1 (nth N '(9.0 9.0 9.0 10.0 11.0 12.0 13.0 14.0 14.0 14.0 15.0
	                  17.0 18.0 20.0)))
	(setq R2 (nth N '(4.5 4.5 4.5 5.0 5.5 6.0 6.5 7.0 7.0 7.0 7.5 8.5
	                  9.0 10.0)))
	(setq DG (nth N '(98 98 98 98 98 98 98 98 98 98 98 98 98 98)))
;*************
	(setq adj (/ (- b tw) 4.0))

	(setq p2a (polar ip (dtor 180) (/ b 2.0))
	      ph  (polar ip (dtor 90)  h)
	      p2  (polar ph (dtor 180) (/ b 2.0))
	)	      	
	(setq p1 (polar ip (dtor 0) (/ b 2.0))
;	      p2 (polar ip (dtor 90) h)
	      p3 (polar p2 (dtor 0) b)
	)
	(setq pmidt (polar p3 (dtor 180) adj)
	      ptft (polar pmidt (dtor 270) tf)
	      pmidb (polar p1 (dtor 180) adj)
	      ptfb (polar pmidb (dtor 90) tf)	      
	)	      
	(setq omidt (polar p2 (dtor 0) adj)
	      otft (polar omidt (dtor 270) tf)
	      omidb (polar p2a (dtor 0) adj)
	      otfb (polar omidb (dtor 90) tf)	      
	)	      		
	(setq ngel (- dg 90.0)
	      hyp (/ adj (cos (dtor ngel)))
	)
	(setq p4 (polar ptft (dtor ngel) hyp)
	      p7 (polar ptft (dtor (+ 180.0 ngel)) hyp)
	      p5 (polar ptfb (dtor (- 360.0 ngel)) hyp)
	      p6 (polar ptfb (dtor (- 180.0 ngel)) hyp)
	)	      	      
	(setq o4 (polar otft (dtor (- 180 ngel)) hyp)
	      o7 (polar otft (dtor (- 360.0 ngel)) hyp)
	      o5 (polar otfb (dtor (+ 180.0 ngel)) hyp)
	      o6 (polar otfb (dtor ngel) hyp)
	)	      	      	

;;;;;CALCULATION FOR FILLET (root radius)
	(setq opp (* (atan (dtor ngel)) r1)
	      vrt (/ r1 (cos (dtor ngel)))
	      dst (- vrt opp)
	)
	(setq yy1 (cadr p7)
	      xx1 (car p7)
	)
	(setq xpt1 (+ xx1 r1)
	      ypt1 (- yy1 dst)
	)
	(setq cpt1 (list xpt1 ypt1)
	      apt1 (polar cpt1 (dtor 180) r1)
	      apt2 (polar cpt1 (dtor (+ 90 ngel)) r1)
	)
;;;;;
	(setq oy1 (cadr o7)
	      ox1 (car o7)
	)
	(setq xot1 (- ox1 r1)
	      yot1 (- oy1 dst)
	)
	(setq cot1 (list xot1 yot1)
	      aot1 (polar cot1 (dtor 0) r1)
	      aot2 (polar cot1 (dtor (- 90 ngel)) r1)
	)	
;*******
	(setq yy2 (cadr p6)
	      xx2 (car p6)
	)
	(setq xpt2 (+ xx2 r1)
	      ypt2 (+ yy2 dst)
	)
	(setq cpt2 (list xpt2 ypt2)
	      apt3 (polar cpt2 (dtor 180) r1)
	      apt4 (polar cpt2 (dtor (- 270 ngel)) r1)
	)	
;;;;;
	(setq oy2 (cadr o6)
	      ox2 (car o6)
	)
	(setq xot2 (- ox2 r1)
	      yot2 (+ oy2 dst)
	)
	(setq cot2 (list xot2 yot2)
	      aot3 (polar cot2 (dtor 0) r1)
	      aot4 (polar cot2 (dtor (+ 270 ngel)) r1)
	)	
	      	      	      		      	
;;;;;CALCULATION FOR FILLET (toe radius)
	(setq opp (* (atan (dtor ngel)) r2)
	      vrt (/ r2 (cos (dtor ngel)))
	      dst (- vrt opp)
	)
	(setq yy3 (cadr p4)
	      xx3 (car p4)
	)
	(setq xpt3 (- xx3 r2)
	      ypt3 (+ yy3 dst)
	)
	(setq cpt3 (list xpt3 ypt3)
	      apt5 (polar cpt3 (dtor 0) r2)
	      apt6 (polar cpt3 (dtor (+ 270 ngel)) r2)
	)
;;;;;
	(setq oy3 (cadr o4)
	      ox3 (car o4)
	)
	(setq xot3 (+ ox3 r2)
	      yot3 (+ oy3 dst)
	)
	(setq cot3 (list xot3 yot3)
	      aot5 (polar cot3 (dtor 180) r2)
	      aot6 (polar cot3 (dtor (+ 270 ngel)) r2)
	)

	(setq yy4 (cadr p5)
	      xx4 (car p5)
	)
	(setq xpt4 (- xx4 r2)
	      ypt4 (- yy4 dst)
	)
	(setq cpt4 (list xpt4 ypt4)
	      apt7 (polar cpt4 (dtor 0) r2)
	      apt8 (polar cpt4 (dtor (- 90 ngel)) r2)
	)		      
;;;;;
	(setq oy4 (cadr o5)
	      ox4 (car o5)
	)
	(setq xot4 (+ ox4 r2)
	      yot4 (- oy4 dst)
	)
	(setq cot4 (list xot4 yot4)
	      aot7 (polar cot4 (dtor 180) r2)
	      aot8 (polar cot4 (dtor (+ 90 ngel)) r2)
	)		      
;*************
	 (setvar "cmdecho" 0)
	 (setq as (ssadd))
	 (setq ar (ssadd))
	 (setq os (ssadd))
	  (command "_line" "_none" p2a "_none" aot7 "")
	(setq o1 (entlast))
	(ssadd o1 os)	 
	  (command "_line" "_none" aot8 "_none" aot4 "")
	(setq o2 (entlast))
	(ssadd o2 os)	
	  (command "_line" "_none" aot1 "_none" aot3 "")
	(setq o3 (entlast))
	(ssadd o3 os)		
	  (command "_line" "_none" aot6 "_none" aot2 "")
	(setq o4 (entlast))
	(ssadd o4 os)		
	  (command "_line" "_none" aot5 "_none" p2 "")
	(setq o5 (entlast))
	(ssadd o5 os)
	  (command "_arc" "_none" aot5 "e" "_none" aot6 "r" R2)
	(setq o6 (entlast))
	(ssadd o6 os)			
	  (command "_arc" "_none" aot8 "e" "_none" aot7 "r" R2)
	(setq o7 (entlast))
	(ssadd o7 os)	
	  (command "_arc" "_none" aot1 "e" "_none" aot2 "r" R1)
	(setq o8 (entlast))
	(ssadd o8 os)	
	  (command "_arc" "_none" aot4 "e" "_none" aot3 "r" R1)
	(setq o9 (entlast))
	(ssadd o9 os)	
;	  (command "_line" "_none" ip "_none" P1 "")
;	(setq e1 (entlast))
;	(ssadd e1 as)
	  (command "_arc" "_none" apt2 "e" "_none" apt1 "r" R1)
	(setq e2 (entlast))
	(ssadd e2 as)
;	  (command "_line" "_none" ip "_none" p2 "")
;	(setq e3 (entlast))
;	(ssadd e3 as)
	  (command "_arc" "_none" apt3 "e" "_none" apt4 "r" R1)
	(setq e4 (entlast))
	(ssadd e4 as)
;	  (command "_line" "_none" p2 "_none" p3 "")
;	(setq e5 (entlast))
;	(ssadd e5 as)
	  (command "_arc" "_none" aPt6 "e" "_none" aPt5 "r" R2)
	(setq e6 (entlast))
	(ssadd e6 as)
	  (command "_arc" "_none" aPt7 "e" "_none" aPt8 "r" R2)
	(setq e13 (entlast))
	(ssadd e13 as)	
	  (command "_line" "_none" P3 "_none" aPt5 "")
	(setq e7 (entlast))
	(ssadd e7 as)
	  (command "_line" "_none" apt2 "_none" aPt6 "")
	(setq e9 (entlast))
	(ssadd e9 as)
	  (command "_line" "_none" aPt1 "_none" aPt3 "")
	(setq e10 (entlast))
	(ssadd e10 as)
	  (command "_line" "_none" aPt4 "_none" aPt8 "")
	(setq e11 (entlast))
	(ssadd e11 as)	
	  (command "_line" "_none" aPt7 "_none" P1 "")
	(setq e12 (entlast))
	(ssadd e12 as)	
;	 (command "pedit" as "_yes" "_join" as "" "") 
;	 (command "mirror" as "" ip ph "n" "")
;	 (setq e15 (entlast))
;	 (ssadd e15 ar)
	  (command "_line" "_none" P2a "_none" P1 "")
	(setq e1 (entlast))
	(ssadd e1 as)	 
	  (command "_line" "_none" p2 "_none" p3 "")
	(setq e5 (entlast))
	(ssadd e5 as)	
	 (command "pedit" as "_yes" "_join" as os "" "") 	
	 (princ "\nRotate about how many degrees?   ")
	 (command "_rotate" "l" "" IP pause)
 (command "_area" "_entity" "l")
 (setq G (* (getvar "AREA") 0.00785))
 (prompt "Weight : ")(princ G)(prompt " kg/m")
 ))
 
 (setvar "osmode" osm)
 (setvar "pickbox" oldpick)
 (setvar "cmdecho" 1)
 (setq *error* olderror)
 (princ)
)
