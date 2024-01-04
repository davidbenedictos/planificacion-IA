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
    (quiere_leer ?libro - libro)
  )

  (:action querer_prerequisito
    :parameters (?libro - libro ?pre - libro)
    :precondition (and 
                    (not (quiere_leer ?pre))
                    (prerequisito ?libro ?pre)
                    (quiere_leer ?libro)
                  )
    :effect (and 
              (quiere_leer ?pre) 
            )
  )

  (:action leer
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (quiere_leer ?libro)
                  (not (leido ?libro))
                  (or 
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (forall (?pre - libro) 
                      (or 
                        (not (prerequisito ?libro ?pre))
                        (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (assign (planificado_para ?libro) (numero_mes ?mes))
          )
  )
)