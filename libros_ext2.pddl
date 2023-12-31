(define (domain planificacion-libros)
  (:requirements :adl :typing :existential-preconditions :fluents)
  
  (:types
    libro mes
  )

  (:functions
        (numero_mes ?mes - mes)                            
        (planificado_para ?libro - libro)
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
                      (and (paralelo ?libro ?par) (leido ?par) (<= (planificado_para ?par) (numero_mes ?mes)))
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (assign (planificado_para ?libro) (numero_mes ?mes))
          )
)
)