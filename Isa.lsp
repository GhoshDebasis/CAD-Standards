;;;  ISA.LSP, 30-04-1998, Rajagopalan SRINIVASAN, IBIL TECH LIMITED
;;;  Profile of Standard Angles acc. to ISA 
;;;  Start with: ISA

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

(defun c:ISA()

 (setq olderror *error*) 
 (setq *error* ip_error)
 (setq TR (getreal "\nISA - "))
 (setq os (getvar "osmode"))
 (setq oldpick (getvar "pickbox"))
 (setvar "pickbox" 0)
 (setvar "osmode" 0)
;*************
 (setq N nil)
 (if (= TR 20) (setq N 0))
 (if (= TR 25) (setq N 1))
 (if (= TR 30) (setq N 2))
 (if (= TR 35) (setq N 3))
 (if (= TR 40) (setq N 4))
 (if (= TR 45) (setq N 5))
 (if (= TR 50) (setq N 6))
 (if (= TR 55) (setq N 7))
 (if (= TR 60) (setq N 8))
 (if (= TR 65) (setq N 9))
 (if (= TR 70) (setq N 10))
 (if (= TR 75) (setq N 11))
 (if (= TR 80) (setq N 12))
 (if (= TR 90) (setq N 13))
 (if (= TR 100) (setq N 14))
 (if (= TR 110) (setq N 15))
 (if (= TR 130) (setq N 16))
 (if (= TR 150) (setq N 17))
 (if (= TR 200) (setq N 18))
;*************
 (if (= N nil)
 (alert "Profile not acc. to standard!")
 )
;************* 
 (if (/= N nil)
	(progn
	 (setq T (getreal "Thickness    : "))	
	 (setq IP (getpoint "Insertionpoint : "))

	(setq A (nth N '(20 25 30 35 40 45 50 55 60 65 70 75 80
			90 100 110 130 150 200)))
	(setq B (nth N '(20 25 30 35 40 45 50 55 60 65 70 75 80
			90 100 110 130 150 200)))			
;	(setq T (nth N '(3.0 3.0 3.0 3.0 3.0 3.0 3.0 5.0 5.0 5.0
;			5.0 5.0 6.0 6.0 6.0 8.0 8.0 10.0 12.0)))
	(setq R1 (nth N '(4.0 4.5 5.0 5.0 5.5 5.5 6.0 6.5 6.5 6.5 7.0
			7.0 8.0 8.5 8.5 10.0 10.0 12.0 15.0)))
	(setq R2 (nth N '(2.5 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.5 4.5 4.5 4.5
			4.5 5.5 5.5 6.0 6.0 8.0 10.0)))
;*************
	(setq p1 (polar ip (dtor 0) b)
	      p2 (polar ip (dtor 90) a)
	      p3 (polar p1 (dtor 90) t)
	      p4 (polar p2 (dtor 0) t)
	      p5 (list (car p4) (cadr p3))
	)
	(setq rp1 (polar p3 (dtor 270) r2)
	      rp2 (polar p3 (dtor 180) r2)
	      rp3 (polar p4 (dtor 270) r2)
	      rp4 (polar p4 (dtor 180) r2)
	      rp5 (polar p5 (dtor 90) r1)
	      rp6 (polar p5 (dtor 0) r1)
	)	            
;*************
	 (setvar "cmdecho" 0)
	 (setq as (ssadd))
	  (command "_line" "_none" ip "_none" P1 "")
	(setq e1 (entlast))
	(ssadd e1 as)
	  (command "_arc" "_none" rp1 "e" "_none" rp2 "r" R2)
	(setq e2 (entlast))
	(ssadd e2 as)
	  (command "_line" "_none" ip "_none" p2 "")
	(setq e3 (entlast))
	(ssadd e3 as)
	  (command "_arc" "_none" rp3 "e" "_none" rp4 "r" R2)
	(setq e4 (entlast))
	(ssadd e4 as)
	  (command "_line" "_none" rp6 "_none" rp2 "")
	(setq e5 (entlast))
	(ssadd e5 as)
	  (command "_arc" "_none" rP5 "e" "_none" rP6 "r" R1)
	(setq e6 (entlast))
	(ssadd e6 as)
	  (command "_line" "_none" rP3 "_none" rP5 "")
	(setq e7 (entlast))
	(ssadd e7 as)
	  (command "_line" "_none" p2 "_none" rP4 "")
	(setq e9 (entlast))
	(ssadd e9 as)
	  (command "_line" "_none" P1 "_none" rP1 "")
	(setq e10 (entlast))
	(ssadd e10 as)
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
