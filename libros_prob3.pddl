(define (problem planificacion-libros-problema3)
  (:domain planificacion-libros)

  (:objects
    libro1 libro2 libro3 libro4 libro5 libro6 - libro
    enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre - mes
  )

  (:init
    (prerequisito libro1 libro2)
    (prerequisito libro1 libro3)
    (prerequisito libro2 libro3) 
    (prerequisito libro6 libro5)
    (prerequisito libro6 libro4)
    (prerequisito libro6 libro3)
    (prerequisito libro6 libro2)
    (prerequisito libro1 libro6)

    (paralelo libro1 libro6)

    (= (numero_mes enero) 1)
    (= (numero_mes febrero) 2)
    (= (numero_mes marzo) 3)
    (= (numero_mes abril) 4)
    (= (numero_mes mayo) 5)
    (= (numero_mes junio) 6)
    (= (numero_mes julio) 7)
    (= (numero_mes agosto) 8)
    (= (numero_mes septiembre) 9)
    (= (numero_mes octubre) 10)
    (= (numero_mes noviembre) 11)
    (= (numero_mes diciembre) 12)
    (= (planificado_para libro1) 0)
    (= (planificado_para libro2) 0)
    (= (planificado_para libro3) 0)
    (= (planificado_para libro4) 0)
    (= (planificado_para libro5) 0)
    (= (planificado_para libro6) 0)
  )

  (:goal (forall (?l - libro) (leido ?l)))
)
