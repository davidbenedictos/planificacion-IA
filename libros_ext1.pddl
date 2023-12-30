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
  )

  (:action leer
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (not (leido ?libro))
                  (or 
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (forall (?x - libro) 
                      (or 
                        (not (prerequisito ?libro ?x))
                        (and (prerequisito ?libro ?x) (leido ?x) (< (planificado_para ?x) (numero_mes ?mes)))
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (increase (planificado_para ?libro) (numero_mes ?mes))
          )
)
)