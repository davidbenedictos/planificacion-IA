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
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and 
                    (not (leido ?libro))
                    (or 
                      (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                      (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    )
                  )
    :effect (and 
              (leido ?libro) 
              (increase (planificado_para ?libro) (numero_mes ?mes))
            )
  )
)