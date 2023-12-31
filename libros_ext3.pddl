(define (domain planificacion-libros)
  (:requirements :adl :typing :existential-preconditions :fluents)
  
  (:types
    libro mes
  )

  (:functions
        (numero_mes ?mes - mes)                            
        (planificado_para ?libro - libro)
        (paginas_leidas ?mes - mes)
        (paginas_libro ?libro - libro)
  )

  (:predicates
    (leido ?libro - libro)
    (prerequisito ?libro - libro ?pre - libro)
    (paralelo ?libro1 - libro ?libro2 - libro)
  )

  (:action leer
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (not (leido ?libro))
                  (<= (+ (paginas_leidas ?mes) (paginas_libro ?libro)) 800)
                  ; prerequisitos
                  (or 
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (forall (?pre - libro) 
                      (or 
                        (not (prerequisito ?libro ?pre))
                        (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                      )
                    )
                  )
                  ; paralelos
                  (forall (?par - libro)
                    (or
                      (not (paralelo ?libro ?par))
                      (and 
                        (paralelo ?libro ?par)
                        (leido ?par)
                        (or 
                          (= (planificado_para ?par) (numero_mes ?mes)) ; Mismo mes
                          (= (planificado_para ?par) (- (numero_mes ?mes) 1)) ; Mes anterior
                          (= (planificado_para ?par) (+ (numero_mes ?mes) 1)) ; Mes siguiente
                        )
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (increase (paginas_leidas ?mes) (paginas_libro ?libro))
            (assign (planificado_para ?libro) (numero_mes ?mes))
          )
)
)