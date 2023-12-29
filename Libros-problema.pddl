(define (problem planificacion-libros-problema)
  (:domain planificacion-libros)
  (:requirements :strips :typing)
  
  (:objects
    libro1 libro2 libro3 - libro
    anterior enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre - mes
  )

  (:init
    (= (numero_mes anterior) 0)
    (= (numero_mes enero) 1)
    (= (numero_mes febrero) 2)
    (= (numero_mes marzo) 3)
    (= (numero_mes abril) 4)
    (= (numero_mes mayo) 5)
    (= (numero_mes junio)6)
    (= (numero_mes julio) 7)
    (= (numero_mes agosto) 8)
    (= (numero_mes septiembre) 9)
    (= (numero_mes octubre) 10)
    (= (numero_mes noviembre) 11)
    (= (numero_mes diciembre) 12)
    (quiere-leer libro1)
    (quiere-leer libro2)
    (quiere-leer libro3)
    (= (fecha libro1) 0)
    (= (fecha libro2) 0)
    (= (fecha libro3) 0)
    (predecesor libro1 libro2)
    (predecesor libro2 libro3)
  )

  (:goal (forall (?l - libro)(leido ?l)))
)
