;;;  ISA.LSP, 30-04-1998, Rajagopalan SRINIVASAN, IBIL TECH LIMITED
;;;  Profile of Standard Channels acc. to ISMC 
;;;  Start with: ISMC

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

(defun c:ISMC()

 (setq olderror *error*) 
 (setq *error* ip_error)
 (setq TR (getreal "\nISMC - "))
 (setq os (getvar "osmode"))
 (setq oldpick (getvar "pickbox"))
 (setvar "pickbox" 0)
 (setvar "osmode" 0)
;*************
 (setq N nil)
 (if (= TR 75) (setq N 0))
 (if (= TR 100) (setq N 1))
 (if (= TR 125) (setq N 2))
 (if (= TR 150) (setq N 3))
 (if (= TR 175) (setq N 4))
 (if (= TR 200) (setq N 5))
 (if (= TR 225) (setq N 6))
 (if (= TR 250) (setq N 7))
 (if (= TR 300) (setq N 8))
 (if (= TR 350) (setq N 9))
 (if (= TR 400) (setq N 10))
;*************
 (if (= N nil)
 (alert "Profile not acc. to standard!")
 )
;************* 
 (if (/= N nil)
	(progn
	 (setq IP (getpoint "Insertionpoint : "))

	(setq H (nth N '(75 100 125 150 175 200 225 250 300 350 400)))
	(setq B (nth N '(40 50 65 75 75 75 80 80 90 100 100)))	
	(setq TF (nth N '(7.3 7.5 8.1 9.0 10.2 11.4 12.4 14.1 13.6 13.5 15.3)))
	(setq TW (nth N '(4.4 4.7 5.0 5.4 5.7 6.1 6.4 7.1 7.6 8.1 8.6)))
	(setq R1 (nth N '(8.5 9.0 9.5 10.0 10.5 11.0 12.0 12.0 13.0 14.0 15.0)))
	(setq R2 (nth N '(4.5 4.5 5.0 5.0 5.5 5.5 6.0 6.0 6.5 7.0 7.5)))
	(setq DG (nth N '(96 96 96 96 96 96 96 96 96 96 96)))
;*************
	(setq adj (/ (- b tw) 2.0))
	
	(setq p1 (polar ip (dtor 0) b)
	      p2 (polar ip (dtor 90) h)
	      p3 (polar p2 (dtor 0) b)
	)
	(setq pmidt (polar p3 (dtor 180) adj)
	      ptft (polar pmidt (dtor 270) tf)
	      pmidb (polar p1 (dtor 180) adj)
	      ptfb (polar pmidb (dtor 90) tf)	      
	)	      
	(setq ngel (- dg 90.0)
	      hyp (/ adj (cos (dtor ngel)))
	)
	(setq p4 (polar ptft (dtor ngel) hyp)
	      p7 (polar ptft (dtor (+ 180.0 ngel)) hyp)
	      p5 (polar ptfb (dtor (- 360.0 ngel)) hyp)
	      p6 (polar ptfb (dtor (- 180.0 ngel)) hyp)
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
;*************
	 (setvar "cmdecho" 0)
	 (setq as (ssadd))
	  (command "_line" "_none" ip "_none" P1 "")
	(setq e1 (entlast))
	(ssadd e1 as)
	  (command "_arc" "_none" apt2 "e" "_none" apt1 "r" R1)
	(setq e2 (entlast))
	(ssadd e2 as)
	  (command "_line" "_none" ip "_none" p2 "")
	(setq e3 (entlast))
	(ssadd e3 as)
	  (command "_arc" "_none" apt3 "e" "_none" apt4 "r" R1)
	(setq e4 (entlast))
	(ssadd e4 as)
	  (command "_line" "_none" p2 "_none" p3 "")
	(setq e5 (entlast))
	(ssadd e5 as)
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
	 (command "pedit" as "_yes" "_join" as "" "") 
	 (princ "\nRotate about how many degrees?   ")
	 (command "_rotate" "l" "" IP pause)
 (command "_area" "_entity" "l")
 (setq G (* (getvar "AREA") 0.00785))
 (prompt "Weight : ")(princ G)(prompt " kg/m")
 ))
 
 (setvar "osmode" os)
 (setvar "pickbox" oldpick)
 (setvar "cmdecho" 1)
 (setq *error* olderror)
 (princ)
)
